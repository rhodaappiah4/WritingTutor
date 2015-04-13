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
import java.util.ArrayList;
import java.util.List;

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

    public EssayParser() {
        grammar = "edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz";
        String[] options = {"-maxLength", "80", "-retainTmpSubcategories"};
        lp = LexicalizedParser.loadModel(grammar, options);
        tlp = lp.getOp().langpack();
        gsf = tlp.grammaticalStructureFactory();
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

    private String parse(Tree toParse) { 
        GrammaticalStructure gs = gsf.newGrammaticalStructure(toParse);
        List<TypedDependency> tdl = gs.typedDependenciesCCprocessed();
        toParse.pennPrint();
        System.out.println(tdl);
        return toParse.pennString() + "\n" + tdl + "\n" + toParse.taggedYield()+"\n\n";
    }
    
//    Tree x = lp.apply("Christopher Manning owns club barcelona?");
//    TregexPattern NPpattern = TregexPattern.compile("@NP !<< @NP");
//    TregexMatcher matcher = NPpattern.matcher(x);
//    while (matcher.findNextMatchingNode()) {
//    Tree match = matcher.getMatch();
//    System.out.println(Sentence.listToString(match.yield()));
//        return null;
//    }
    
    
//    public static ArrayList<Tree> extract(Tree t) 
//{
//    ArrayList<Tree> wanted = new ArrayList<Tree>();
//   if (t.label().value().equals("S") )
//    {
//       wanted.add(t);
//        for (Tree child : t.children())
//        {
//            ArrayList<Tree> temp = new ArrayList<Tree>();
//            temp=extract(child);
//            if(temp.size()>0)
//            {
//                int o=-1;
//                o=wanted.indexOf(t);
//                if(o!=-1)
//                    wanted.remove(o);
//            }
//            wanted.addAll(temp);
//        }
//    }
//
//    else
//        for (Tree child : t.children())
//            wanted.addAll(extract(child));
//    return wanted;
//}

  
    public static String extractTag(String s){
        Tree t = null;
        Tree comma_splice = null;
        for (Tree subtree : t) { 
            if (subtree.label().value().equals("S")) {
            comma_splice.add(subtree);
            }
        }
        return "Good";
    }
}
