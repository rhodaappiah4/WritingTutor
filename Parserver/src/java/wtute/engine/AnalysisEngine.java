/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wtute.engine;

import java.sql.Connection;
import weka.core.Instances;
import weka.experiment.InstanceQuery;

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
        // query.setSparseData(true);
        Instances data = query.retrieveInstances();
        System.out.println(data);
    }
    public static void main(String[] args) throws Exception {
        train();
    }
}
