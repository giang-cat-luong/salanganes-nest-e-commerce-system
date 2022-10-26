/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package others;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import utils.DBUtils;

/**
 *
 * @author lequa
 */
public class OtherDAO {

    public static ArrayList<RequestDTO> getRequests() throws Exception {
        ArrayList<RequestDTO> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select requestID,cusID,detail,status\n"
                    + "from request\n"
                    + "where status = 1";
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(sql);
            if (table != null) {
                while (table.next()) {
                    int requestid = table.getInt("requestID");
                    String cusid = table.getString("cusID");
                    String detail = table.getString("detail");
                    int status = table.getInt("status");
                    RequestDTO req = new RequestDTO(requestid, cusid, detail, status);
                    list.add(req);
                }
            }
            cn.close();
        }
        return list;
    }

    public static ArrayList<BlogDTO> getBlogList() throws Exception {
        ArrayList<BlogDTO> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select blogID,title,summary, detail, cover\n"
                    + "from blogList\n";
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(sql);
            if (table != null) {
                while (table.next()) {
                    String blogID = table.getString("blogID");
                    String title = table.getString("title");
                    String summary = table.getString("summary");
                    String detail = table.getString("detail");
                    String cover = table.getString("cover");
                    BlogDTO blog = new BlogDTO(blogID, title, summary, detail, cover);
                    list.add(blog);
                }
            }
            cn.close();
        }
        return list;
    }
}
