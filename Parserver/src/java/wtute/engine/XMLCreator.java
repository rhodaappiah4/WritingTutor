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

    StringBuilder sb;

    public XMLCreator() {
        sb = new StringBuilder();
        sb.append("<results>\n");
    }

    public void addError(String error, String desc, String pre, String[] options, String type) {

        sb.append("  <error>\n");
        sb.append("    <string>").append(error).append("</string>\n");
        sb.append("    <description>").append(desc).append("</description>\n");
        sb.append("    <precontext>").append((pre != null) ? pre : "").append("</precontext>\n");
        sb.append("    <suggestions>\n");
        if (options != null) {
            for (String option : options) {
                sb.append("        <option>").append(option).append("</option>\n");
            }
        } else {
            sb.append("        <option>None</option>\n");
        }
        sb.append("    </suggestions>\n");
        sb.append("    <type>").append(type).append("</type>\n");
        sb.append("  </error>\n");
      
    }
    public String getErrorXML(){
        sb.append("</results>\n");
        return sb.toString();
    }
}
