/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wtute.engine;

import java.sql.Connection;
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

    Connection conn = null;
    public void users() {

        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = java.sql.DriverManager.getConnection(
                    "jdbc:mysql://localhost/kontrol?user=root&password=");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void train() throws Exception {
        Class.forName("com.mysql.jdbc.Driver").newInstance();

        InstanceQuery query = new InstanceQuery();
        query.setUsername("root");
        query.setPassword("");
        query.setQuery("select tags,sentence_quality from sentences");
        // You can declare that your data set is sparse
         query.setSparseData(true);
        Instances data = query.retrieveInstances(); 
//        if (data.classIndex() == -1){
//            data.setClassIndex(data.numAttributes() - 1);
//        }
       
       
        StringToWordVector nts = new StringToWordVector();
        nts.setInputFormat(data); 
        Instances newData = Filter.useFilter(data, nts); 
        
        System.out.println(newData);
        System.out.println(data);
    }
    public static void main(String[] args) throws Exception {
        train();
    }
}
