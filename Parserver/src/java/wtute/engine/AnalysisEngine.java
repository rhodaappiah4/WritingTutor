/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wtute.engine;

import edu.stanford.nlp.trees.Tree;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instance;
import weka.core.Instances;
import weka.experiment.InstanceQuery;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.*;
import wtute.parser.EssayParser;

/**
 *
 * @author HP
 */
public class AnalysisEngine {

    private FastVector attributeList;
    private Instances data;

    public AnalysisEngine() throws Exception {
        attributeList = new FastVector();
        Class.forName("com.mysql.jdbc.Driver").newInstance();

        InstanceQuery query = new InstanceQuery();
        query.setUsername("root");
        query.setPassword("");
        query.setQuery("select sentence,sentence_quality from sentences");
        //data set is sparse
        query.setSparseData(true);
        data = query.retrieveInstances();
        StringToWordVector nts = new StringToWordVector();
        nts.setInputFormat(data);
        data = Filter.useFilter(data, nts);
    }

    public void train() throws Exception {

        Instances trainingInstances = createInstances("TRAINING INS");
        for (int i = 0; i < data.numInstances(); i++) {
            Instance instance = convertInstance(data.instance(i));
        }

        System.out.println(data);
    }

    private Instances createInstances(final String INSTANCES_NAME) {
        FastVector fv = new FastVector();
        fv.addElement("KOL");
        attributeList.addElement(new Attribute("Sentence", fv));
        fv.addElement("KOL2");
        attributeList.addElement(new Attribute("Level 0", fv));
        attributeList.addElement(new Attribute("Level 1", fv));
        attributeList.addElement(new Attribute("Level 2", fv));
        attributeList.addElement(new Attribute("Level 3", fv));
        attributeList.addElement(new Attribute("Quality", fv));

        //create an Instances object with initial capacity as zero 
        Instances instances = new Instances(INSTANCES_NAME, attributeList, 0);

        //sets the class index as the last attribute (positive or negative)
        instances.setClassIndex(instances.numAttributes() - 1);
        System.out.println(instances);
        return instances;
    }

    public static void main(String[] args) throws Exception {
        // train();
        AnalysisEngine ae = new AnalysisEngine();
        ae.createInstances("Test");

    }

    private Instance convertInstance(Instance instance) { 
        EssayParser ep = new EssayParser();
        Tree pt = ep.getTreeOf(instance.stringValue(0));
        List<Tree> tl = pt.getChildrenAsList();
        for(Tree tree:tl){
            
        }
        return null;
    }
    HashMap<Integer,ArrayList<String>> levels = new HashMap<>();
   
    private String createLevels(Tree tree,int level){
        List<Tree> tl = tree.getChildrenAsList();
        levels.put(level,new ArrayList(tl));
        
        for(Tree t:tl){
            createLevels(t,level+1);
        }
        return null;
    }
}
