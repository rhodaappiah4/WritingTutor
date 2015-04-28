/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wtute.engine;

import java.sql.Connection;
import java.util.ArrayList;
import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instance;
import weka.core.Instances;
import weka.experiment.InstanceQuery;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.*;

/**
 *
 * @author HP
 */
public class AnalysisEngine {

    private FastVector attributeList;
    public AnalysisEngine(){
        attributeList = new FastVector();
    }

    public static void train() throws Exception {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        
        InstanceQuery query = new InstanceQuery();
        query.setUsername("root");
        query.setPassword("");
        query.setQuery("select sentence,sentence_quality from sentences");
        //data set is sparse
        query.setSparseData(true);
        Instances data = query.retrieveInstances(); 
        if (data.classIndex() == -1){
            data.setClassIndex(data.numAttributes() - 1);
        }
        for(int i =0;i<data.numInstances();i++){
            Instance instance = data.instance(i); 
        }
       
       
        StringToWordVector nts = new StringToWordVector();
        nts.setInputFormat(data); 
        Instances newData = Filter.useFilter(data, nts); 
        
        System.out.println(newData);
        System.out.println(data);
    }
     private Instances createInstances(final String INSTANCES_NAME)
    {
        FastVector fv  = new FastVector();
        fv.addElement("KOL");
         attributeList.addElement(new Attribute("Tags",fv ));
          fv.addElement("KOL2");
         attributeList.addElement(new Attribute("Tags2",fv ));
        
        //create an Instances object with initial capacity as zero 
        Instances instances = new Instances(INSTANCES_NAME,attributeList,0);
        
        //sets the class index as the last attribute (positive or negative)
        instances.setClassIndex(instances.numAttributes()-1);
            System.out.println(instances);
        return instances;
    }
    public static void main(String[] args) throws Exception {
       // train();
        AnalysisEngine ae = new AnalysisEngine();
        ae.createInstances("Test");
                
    }
}
