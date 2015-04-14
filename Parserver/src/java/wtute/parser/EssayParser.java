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
        return toParse.pennString() + "\n" + tdl + "\n" + toParse.taggedYield() + "\n\n";
    }

    public String extractTag(String sentence) {
        Tree parseTree = lp.parse(sentence);
        Tree comma_splice = null;
        String res="<results></results>";
        System.out.println(parseTree);
        Tree[] treeArr = parseTree.children()[0].children();
        for (Tree substree : treeArr) {
            System.out.println(substree.label());
            if(substree.label().toString().equals(",")){
                
            }
        }
         
        return res;
    }
}
