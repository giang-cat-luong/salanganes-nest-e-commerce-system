/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package others;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import seller.dto.Seller;
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

    public static double getSumRateProduct(String productID) throws Exception {
        int rateCount = 0, ratePoint = 0;
        double sumRate = 0;
        String SQL = "SELECT COUNT (commentID) AS totalComment FROM comment WHERE productID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, productID);
                res = pre.executeQuery();
                while (res.next()) {
                    rateCount = res.getInt("totalComment");
                }

                SQL = "SELECT rate FROM comment WHERE productID = ?";
                pre = con.prepareStatement(SQL);
                pre.setString(1, productID);
                res = pre.executeQuery();
                while (res.next()) {
                    ratePoint += res.getInt("rate");
                }
            }

            if (rateCount != 0 && ratePoint != 0) {
                sumRate = ratePoint / rateCount;
            }
        } finally {
            if (con != null) {
                con.close();
            }

            if (pre != null) {
                pre.close();
            }

            if (res != null) {
                res.close();
            }

        }
        return sumRate;
    }

    public static Seller getSellerByProductID(String productID) throws Exception {
        Seller sel = new Seller();
        String SQL = "SELECT sellerID, sellerName, avatar, loc FROM seller WHERE productID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, productID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        String sellerID = res.getString("sellerID");
                        String sellerName = res.getString("sellerName");
                        String avatar = res.getString("avatar");
                        String loc = res.getString("loc");
                        sel = new Seller(sellerID, sellerName, "", "",
                                avatar, "", "", "SE", loc, 0, 0, 0);
                    }
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }

            if (pre != null) {
                pre.close();
            }

            if (res != null) {
                res.close();
            }

        }
        return sel;
    }

    public static ArrayList<VoucherSeller> getVoucherList(String productID, String sellerID) throws Exception {
        ArrayList<VoucherSeller> vou = new ArrayList<>();
        float price = 0;
        String SQL = "SELECT price FROM product WHERE productID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, productID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        price = res.getFloat("price");
                    }
                }

                SQL = "SELECT voucherID, name, codeID, priceAffect FROM voucherID WHERE sellerID = ?";
                pre = con.prepareStatement(SQL);
                pre.setString(1, sellerID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        String voucherID = res.getString("voucherID");
                        String name = res.getString("name");
                        String codeID = res.getString("codeID");
                        float priceAffect = res.getFloat("priceAffect");
                        if (price >= priceAffect) {
                            VoucherSeller vous = new VoucherSeller(voucherID, name, codeID, "", priceAffect);
                            vou.add(vous);
                        }
                    }
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }

            if (pre != null) {
                pre.close();
            }

            if (res != null) {
                res.close();
            }

        }
        return vou;
    }

    public static ArrayList<CommentDTO> getCommentByProductID(String productID) throws Exception {
        ArrayList<CommentDTO> cmt = new ArrayList<>();
        String SQL = "SELECT cusID, detail, img, rate FROM comment WHERE productID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, productID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        String cusID = res.getString("cusID");
                        String detail = res.getString("detail");
                        String img = res.getString("img");
                        int rate = res.getInt("rate");

                        SQL = "SELECT cover FROM customer WHERE cusID = ?";
                        pre = con.prepareStatement(SQL);
                        pre.setString(1, cusID);
                        res = pre.executeQuery();
                        if (res != null) {
                            String cover = res.getString("cover");
                            CommentDTO cm = new CommentDTO(cover, cusID, productID, detail, img, rate);
                            cmt.add(cm);
                        }
                    }
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }

            if (pre != null) {
                pre.close();
            }

            if (res != null) {
                res.close();
            }

        }
        return cmt;
    }

    public static boolean insertRequest(RequestDTO request) throws Exception {
        boolean flag = false;
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String SQL = "INSERT INTO request(cusID, detail) "
                        + "VALUE (?, ?) "
                        + "WHERE status = 1";
                ps = cn.prepareStatement(SQL);
                ps.setString(1, request.getCusId());
                ps.setString(2, request.getDetail());
                flag = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.out.println("Error at insertReport: " + e.toString());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return flag;
    }

    public static boolean insertReport(ReportDTO report) throws Exception {
        boolean flag = false;
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {

                String sql = "INSERT INTO reportProduct(cusID, productID, dateReport, description, img) "
                        + "VALUE (?, ?, ?, ?, ?) "
                        + "WHERE status = 1";
                ps = cn.prepareStatement(sql);
                ps.setString(1, report.getCusID());
                ps.setString(2, report.getProductID());
                ps.setTimestamp(3, report.getDateReport());
                ps.setString(4, report.getDescription());
                ps.setString(5, report.getImg());
                flag = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.out.println("Error at insertReport: " + e.toString());
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return flag;
    }

    public static Timestamp getCurrentDateTime() {
        return new Timestamp(System.currentTimeMillis());
    }

    public static boolean removeWishList(int wishID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "DELETE FROM wishlist "
                    + "WHERE wishID = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, wishID);
            int table = ps.executeUpdate();
            if (table == 1) {
                flag = true;
            } else {
                flag = false;
            }
            cn.close();
        }
        return flag;
    }
    
     public static boolean addWishlist(String productID, String cusID, int quantity) throws Exception{
        Connection cn = DBUtils.getConnection();
        boolean flag = false;
        if(cn!=null){
            String sql = "SELECT sellerID, cateID, productName, cover, description, price"
                    + "FROM product"
                    + "WHERE productID LIKE ?";
            PreparedStatement ptm = cn.prepareStatement(sql);
            ptm.setString(1, productID);
            ResultSet rs = ptm.executeQuery();
            if(rs != null){
                String sellerID = rs.getString("sellerID");
                String cateID = rs.getString("cateID");
                String productName = rs.getString("productName");
                String cover = rs.getString("cover");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
    
                sql = "insert into wishList(cusID, productID, cateID, sellerID, productName, quantity, cover, price, description)"
                    + "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ptm = cn.prepareStatement(sql);
                ptm.setString(1, cusID);
                ptm.setString(2, productID);
                ptm.setString(3, cateID);
                ptm.setString(4, sellerID);
                ptm.setString(5, productName);
                ptm.setInt(6, quantity);
                ptm.setString(7, cover);
                ptm.setFloat(8, price);
                 ptm.setString(9, description);
                int table = ptm.executeUpdate();
                if(table > 0){
                    flag = true;
                }
                else {
                    flag = false;
                }
            }
            cn.close();
        }
        return flag;
    }
}
