/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wtute.parser;

import edu.stanford.nlp.ling.HasWord;
import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
import edu.stanford.nlp.process.DocumentPreprocessor;
import edu.stanford.nlp.process.Tokenizer;
import edu.stanford.nlp.trees.GrammaticalStructure;
import edu.stanford.nlp.trees.GrammaticalStructureFactory;
import edu.stanford.nlp.trees.Tree;
import edu.stanford.nlp.trees.TreebankLanguagePack;
import edu.stanford.nlp.trees.TypedDependency;
import edu.stanford.nlp.trees.tregex.TregexMatcher;
import edu.stanford.nlp.trees.tregex.TregexPattern;
import java.io.Reader;
import java.io.StringReader;
import java.util.Iterator;
import java.util.List;
import wtute.engine.TreeHelper;
import wtute.engine.XMLCreator;

/**
 *
 * @author Rhoda Appiah
 */
public class EssayParser {

    String grammar;

    LexicalizedParser lp;
    TreebankLanguagePack tlp;
    GrammaticalStructureFactory gsf;
    Iterable<List<? extends HasWord>> sentences;
    XMLCreator xmlc;

    public EssayParser() {
        grammar = "edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz";
        String[] options = {"-maxLength", "80", "-retainTmpSubcategories"};
        lp = LexicalizedParser.loadModel(grammar, options);
        tlp = lp.getOp().langpack();
        gsf = tlp.grammaticalStructureFactory();
        xmlc = new XMLCreator();
    }

    public EssayParser(String serGrammarURL) {

        grammar = serGrammarURL;
        String[] options = {"-maxLength", "80", "-retainTmpSubcategories"};
        lp = LexicalizedParser.loadModel(grammar, options);
        tlp = lp.getOp().langpack();
        gsf = tlp.grammaticalStructureFactory();
    }

    public String parseEssay(String essay) {
        String parsedOut = "";
        Reader reader = new StringReader(essay);
        DocumentPreprocessor dp = new DocumentPreprocessor(reader);
        for (List<HasWord> sentence : dp) {
            Tree parseTree = lp.parse(sentence);
            System.out.print(parseTree);
            parsedOut += parse(parseTree);
        }
        return parsedOut;
    }

    public String parseSentenceArr(String... sentences) {
        String parsedOut = "";
        for (String sentence : sentences) {
            Tokenizer<? extends HasWord> toke = tlp.getTokenizerFactory().getTokenizer(new StringReader(sentence));
            List<? extends HasWord> essayTok = toke.tokenize();
            Tree parseTree = lp.parse(essayTok);
            parsedOut += parse(parseTree);
        }
        return parsedOut;
    }

    public Tree getTreeOf(String... sentences) {
        Tree parseTree = null;
        for (String sentence : sentences) {
            Tokenizer<? extends HasWord> toke = tlp.getTokenizerFactory().getTokenizer(new StringReader(sentence));
            List<? extends HasWord> essayTok = toke.tokenize();
            parseTree = lp.parse(essayTok);

        }
        return parseTree;
    }

    private String parse(Tree toParse) {
        GrammaticalStructure gs = gsf.newGrammaticalStructure(toParse);
        List<TypedDependency> tdl = gs.typedDependenciesCCprocessed();
        toParse.pennPrint();
        System.out.println(tdl);
        return toParse.pennString() + "\n" + tdl + "\n" + toParse.taggedYield() + "\n\n";
    }

    public String analyze(String essay) { 
        Reader reader = new StringReader(essay);
        DocumentPreprocessor dp = new DocumentPreprocessor(reader);
        for (List<HasWord> sentence : dp) {
            commaSplice(sentence);
        }
        return xmlc.getErrorXML();
    }

    public void commaSplice(List<HasWord> sentence) {
        System.out.println("SPLICEr");
        Tree sentenceTree = lp.parse(sentence);
        Iterator<Tree> iter = sentenceTree.iterator();
        TregexPattern pattern = TregexPattern.compile("@S < (@S $+ (/,/ $+ (@NP $+ @VP))) | < (@NP $+ (@VP $+ (/,/ $+ @VP)))");
        TregexPattern patternTwo = TregexPattern.compile("@VP < (@VP $+ (/,/ $+ @VP))");
        TregexPattern patternThree = TregexPattern.compile("@S < (@S $+ (/,/ $+ @S))");
        TregexMatcher matcher = pattern.matcher(sentenceTree);
        TregexMatcher matcherTwo = patternTwo.matcher(sentenceTree);
        TregexMatcher matcherThree = patternThree.matcher(sentenceTree);
        boolean oneFound, twoFound = false, threeFound = false;
        while ((oneFound = matcher.findNextMatchingNode())
                || (twoFound = matcherTwo.findNextMatchingNode())
                || (threeFound = matcherThree.findNextMatchingNode())) {
            Tree match;
            if (oneFound) {
                System.out.println("1");
                match = matcher.getMatch();
            } else if (twoFound) {
                System.out.println("2");
                match = matcherTwo.getMatch();
            } else {
                System.out.println("3");
                match = matcherThree.getMatch();
            }

            System.out.println(Sentence.listToString(match.yield()));
            List<Tree> tl = match.preOrderNodeList(); 
           
                    String errorSect = tl.get(tl.indexOf(Tree.valueOf("(, ,)"))-1) + ", "
                    +  Sentence.listToString(tl.get(tl.indexOf(Tree.valueOf("(, ,)"))+2).yieldWords()) ;
                    System.out.println(errorSect);
            xmlc.addError(errorSect,
                    "Comma splice: You have used a comma to separate two individual sentences",
                    null, new String[]{"or", "and", "but", "so", " ; ", " . "}, "grammar", "Consider using a "
                    + "conjunction after the comma, a semi-colon or a full-stop to break the sentence.");
             
        }
    }

    public static void main(String[] args) {
        EssayParser ep = new EssayParser();
        ep.analyze("The sun is high, put on some sunblock. It was raining, we stayed home. It was raining, so we stayed home.\n"
                + "The pink shirt is $20, black shirt is $18, dark pant is $15.\n"
                + "It can help salesperson to promote up-sales and cross sales, provide better services.\n"
                + "We hiked for three days, we were very tired.\n"
                + "The television is too loud, the picture is fuzzy.\n"
                + "Mary kissed Frank, then, for no apparent reason, she slapped him.\n"
                + "John studied hard for the test, he failed it anyway.\n"
                + "Charlie is not only handsome, he is also rich.\n"
                + "Heavy rain fell throughout the night, by morning every major road was flooded.\n"
                + "This has been a very dry summer, therefore, the supply of water in the reservoirs is low.\n"
                + "This has been a very dry summer; therefore, the supply of water in the reservoirs is low.\n"
                + "The coach was mad at his team, he told the players that they had to work harder in practice, he made them watch extra film to prepare for the next game. ");
    }

}
