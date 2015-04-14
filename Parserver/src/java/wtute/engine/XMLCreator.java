/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package wtute.engine;

/**
 *
 * @author HP
 */ 
public class XMLCreator {
    public enum sd{d;}
    public XMLCreator(){
       
    }
    public void addError(String error,String desc,String pre, String[]options,String type){
       String res = "<results>\n"
                + "  <error>\n"
                + "    <string>"+error+"</string>\n"
                + "    <description>Comma splice: Use a conjunction after the comma</description>\n"
                + "    <precontext></precontext>\n"
                + "    <suggestions>\n"
                + "        <option>or, and, but, so</option>\n" 
                + "    </suggestions>\n"
                + "    <type>grammar</type>\n"
                + "\n"
                + "  </error>\n"
                + "</results>";
    }
}
