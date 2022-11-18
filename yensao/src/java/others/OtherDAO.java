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

    public static boolean updateQuantityProductWishList(String productID) throws Exception {
        boolean check = false;
        int quantity = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT quantity FROM wishList WHERE productID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    quantity = rs.getInt("quantity");
                }

                SQL = "UPDATE wishList SET quantity = ? WHERE productID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setInt(1, quantity + 1);
                ptm.setString(2, productID);
                if (ptm.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public static boolean checkRequest(String cusID) throws Exception {
        boolean check = false;
        String requestID = "";
        String SQL = "SELECT requestID FROM request WHERE cusID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, cusID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        requestID = res.getString("requestID");
                    }
                    check = true;
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
        return check;
    }

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

    public static Seller getSellerByProductID(String sellerID) throws Exception {
        Seller sel = new Seller();
        String SQL = "SELECT  sellerName, email, avatar, phone, loc FROM seller WHERE sellerID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, sellerID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        String sellerName = res.getString("sellerName");
                        String email = res.getString("email");
                        String avatar = res.getString("avatar");
                        String phone = res.getString("phone");
                        String loc = res.getString("loc");
                        sel = new Seller(sellerID, sellerName, "", email,
                                avatar, phone, "", "SE", loc, 0, 0);
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

    public static ArrayList<Voucher> getVoucherList(String productID, String sellerID) throws Exception {
        ArrayList<Voucher> vou = new ArrayList<>();
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

                SQL = "SELECT voucherID, name, codeID, priceAffect FROM voucherSeller WHERE sellerID = ?";
                pre = con.prepareStatement(SQL);
                pre.setString(1, sellerID);
                res = pre.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        int voucherID = res.getInt("voucherID");
                        String name = res.getString("name");
                        String codeID = res.getString("codeID");
                        float priceAffect = res.getFloat("priceAffect");
                        if (price >= priceAffect) {
                            Voucher vous = new Voucher(voucherID, name, codeID, "", 0);
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

                        SQL = "SELECT cusName, avatar FROM customer WHERE cusID = ?";
                        pre = con.prepareStatement(SQL);
                        pre.setString(1, cusID);
                        ResultSet res2 = null;
                        res2 = pre.executeQuery();
                        if (res2.next()) {
                            String cusName = res2.getString("cusName");
                            String cover = res2.getString("avatar");
                            CommentDTO cm = new CommentDTO(productID, cusName, cover, cusID, detail, img, rate);
                            cmt.add(cm);
                        }
                    }
                }
            }
        } catch (Exception e) {
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
                String SQL = "INSERT INTO request(cusID, detail) VALUES (?, ?)";
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

    public static boolean addWishlist(String productID, String cusID, int quantity) throws Exception {
        Connection cn = DBUtils.getConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "SELECT sellerID, cateID, productName, cover, description, price FROM product WHERE productID = ?";
            PreparedStatement ptm = cn.prepareStatement(sql);
            ptm.setString(1, productID);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
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
                if (table > 0) {
                    flag = true;
                } else {
                    flag = false;
                }
            }
            cn.close();
        }
        return flag;
    }

    public static ArrayList<WishList> getWishList() throws Exception {
        ArrayList<WishList> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select * from wishList";
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(sql);
            if (table != null) {
                while (table.next()) {
                    int wishID = table.getInt("wishID");
                    String cusID = table.getString("cusID");
                    String productID = table.getString("productID");
                    String cateID = table.getString("cateID");
                    String sellerID = table.getString("sellerID");
                    String productName = table.getString("productName");
                    int quantity = table.getInt("quantity");
                    String cover = table.getString("cover");
                    float price = table.getFloat("price");
                    String description = table.getString("description");
                    WishList wl = new WishList(wishID, cusID, productID, cateID, sellerID,
                            productName, quantity, cover, price, description);
                    list.add(wl);
                }
            }
            cn.close();
        }
        return list;
    }

    public static int getTotalSellProduct(String productID) throws Exception {
        int totalSell = 0;
        String SQL = "SELECT COUNT (commentID) AS totalSell FROM comment WHERE productID = ?";
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
                    totalSell = res.getInt("totalSell");
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
        return totalSell;
    }

    public static ArrayList<Culmulative> getCumulative(String cusID) throws Exception {
        ArrayList<Culmulative> list = new ArrayList<>();
        String SQL = "SELECT * FROM saveCumulative WHERE cusID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setString(1, cusID);
                res = pre.executeQuery();
                while (res.next()) {
                    int saveID = res.getInt("saveID");
                    String infor = res.getString("infor");
                    Timestamp time = res.getTimestamp("time");
                    Culmulative cu = new Culmulative(saveID, cusID, infor, time);
                    list.add(cu);
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
        return list;
    }

    public static String getKeyCode(int voucherID) throws Exception {
        String keyCode = "";
        String SQL = "SELECT codeID FROM voucher WHERE voucherID = ?";
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet res = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                pre = con.prepareStatement(SQL);
                pre.setInt(1, voucherID);
                res = pre.executeQuery();
                while (res.next()) {
                    String codeID = res.getString("codeID");
                    SQL = "SELECT keyCode FROM codeStore WHERE codeID = ?";
                    pre = con.prepareStatement(SQL);
                    pre.setString(1, codeID);
                    res = pre.executeQuery();
                    if (res.next()) {
                        keyCode = res.getString("keyCode");
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
        return keyCode;
    }
}
