/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wtute.engine;

import edu.stanford.nlp.trees.Tree;
import java.util.List;
import java.util.ListIterator;

/**
 *
 * @author HP
 */
public class TreeHelper {

    public static Tree nextSibling(Tree child, Tree root) {
        Tree parent = child.parent(root);
        List<Tree> preList = parent.getChildrenAsList();
        int indexOfChild = preList.indexOf(child);

        try {
            return parent.getChild(indexOfChild + 1);
        } catch (Exception e) {
            return null;
        }
    }

    public static Tree prevSibling(Tree child, Tree root) {
        Tree parent = child.parent(root); 
        List<Tree> postList = parent.getChildrenAsList();
        int indexOfChild = postList.indexOf(child);
        ListIterator liter = postList.listIterator();
        
        try {
            return parent.getChild(indexOfChild - 1);
        } catch (Exception e) {
            return null;
        }
    }

    public static boolean isConjunction(Tree head) {
        String headTag = head.label().toString();
        return (headTag.equals("IN") || headTag.equals("CC"));
    }
    public static boolean isAdjectivalPhrase(Tree head){
        String headTag = head.label().toString();
        return (headTag.equals("ADVP"));
    }
}
