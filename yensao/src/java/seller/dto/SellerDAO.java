
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package seller.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.naming.NamingException;
import others.CategoryDTO;
import others.OrderDetailDTO;
import others.SellerInforRelative;
import utils.DBUtils;

/**
 *
 * @author lequa
 */
public class SellerDAO {

    private static final String GET_ORDERDETAIL_LIST = "SELECT orderDetailID, orderID, productID, productName, img, quantity, status FROM orderDetail WHERE status = ? AND sellerID = ?";
    private static final String GET_SELLER_LIST = "SELECT sellerID, sellerName, password, email, avatar, phone, role, gender, loc, profit, status FROM seller";
    private static final String REMOVE_SELLER = "DELETE seller WHERE sellerID=?";
    private static final String REMOVE_RELATIVE_ORDERDETAIL = "DELETE orderDetail WHERE productID=?";
    private static final String REMOVE_RELATIVE_REPORTPRODUCT = "DELETE reportProduct WHERE productID = ?";
    private static final String REMOVE_RELATIVE_COMMENT = "DELETE comment WHERE productID = ?";
    private static final String GET_REMOVE_PRODUCT = "SELECT productID\n"
            + "FROM product join seller on product.sellerID = seller.sellerID\n"
            + "WHERE seller.sellerID LIKE ?";
    private static final String GET_CATEGORY_LIST = "SELECT cateID, cateName FROM category";

    private static final String GET_BACKSELLER_LIST = "SELECT sellerName, password, email, avatar, phone, role, gender, loc, balance, status, shipAllow FROM seller WHERE sellerID=?";
    private static final String UPDATE_SELLER = "UPDATE seller "
            + " SET sellerName = ? \n"
            + "    ,password = ?\n"
            + "    ,email = ?\n"
            + "    ,phone = ?\n"
            + "    ,gender = ?\n"
            + "    ,loc = ?\n"
            + "    ,shipAllow = ?\n"
            + " WHERE sellerID = ?";

    public static ArrayList<OrderDetailDTO> getOrderDetailList(String sellerID) throws Exception {
        Connection conn = null;
        PreparedStatement pt = null;
        ResultSet rs = null;
        ArrayList<OrderDetailDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                pt = conn.prepareStatement(GET_ORDERDETAIL_LIST);
                pt.setInt(1, 1);
                pt.setString(2, sellerID);
                rs = pt.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String orderDetailID = rs.getString("orderDetailID");
                        String orderID = rs.getString("orderID");
                        String productID = rs.getString("productID");
                        String productName = rs.getString("productName");
                        String img = rs.getString("img");
                        int quantity = rs.getInt("quantity");
                        int status = rs.getInt("status");
                        OrderDetailDTO ord = new OrderDetailDTO(orderDetailID, orderID, sellerID, productID, productName, img, quantity, status, 0);
                        list.add(ord);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pt != null) {
                pt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public static Seller getBackInformation(String sellerID) throws Exception {
        Connection conn = null;
        PreparedStatement pt = null;
        ResultSet rs = null;
        Seller sel = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                pt = conn.prepareStatement(GET_BACKSELLER_LIST);
                pt.setString(1, sellerID);
                rs = pt.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String sellerName = rs.getString("sellerName");
                        String password = rs.getString("password");
                        String email = rs.getString("email");
                        String avatar = rs.getString("avatar");
                        String phone = rs.getString("phone");
                        String role = rs.getString("role");
                        String gender = rs.getString("gender");
                        String loc = rs.getString("loc");
                        float profit = rs.getFloat("balance");
                        int status = rs.getInt("status");

                        sel = new Seller(sellerID, sellerName, password, email, avatar, phone, role, gender, loc, profit, status);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pt != null) {
                pt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return sel;
    }

    public static ArrayList<CategoryDTO> getCategory() throws Exception {
        ArrayList<CategoryDTO> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(GET_CATEGORY_LIST);
            if (table != null) {
                while (table.next()) {
                    String cateID = table.getString("cateID");
                    String cateName = table.getString("cateName");
                    CategoryDTO cate = new CategoryDTO(cateID, cateName);
                    list.add(cate);
                }
            }
            cn.close();
        }
        return list;
    }

    public static boolean removeSeller(String sellerID) throws Exception {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(REMOVE_SELLER);
                ptm.setString(1, sellerID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
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

    public static ArrayList<Seller> getSellerList() throws Exception {
        ArrayList<Seller> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(GET_SELLER_LIST);
            if (table != null) {
                while (table.next()) {
                    String sellerid = table.getString("sellerID");
                    String sellername = table.getString("sellerName");
                    String password = table.getString("password");
                    String email = table.getString("email");
                    String avatar = table.getString("avatar");
                    String phone = table.getString("phone");
                    String role = table.getString("role");
                    String gender = table.getString("gender");
                    String loc = table.getString("loc");
                    float profit = table.getFloat("profit");
                    int status = table.getInt("status");
                    Seller acc = new Seller(sellerid, sellername, password, email, avatar, phone, role,
                            gender, loc, profit, status);
                    list.add(acc);
                }
            }
            cn.close();
        }
        return list;
    }

    public static boolean changePassword(String email, String newPass) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update seller\n"
                    + "set password=?\n"
                    + "where email=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, newPass);
            pst.setString(2, email);
            int table = pst.executeUpdate();
            if (table == 1) {
                flag = true;
            } else {
                flag = false;
            }
            cn.close();
        }
        return flag;
    }

    public static boolean updateAccount(String email, String newPassword, String newName, String newPhone, String newLoc) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update seller\n"
                    + "set sellerName=?, phone=?, password=?, loc=?\n"
                    + "where email=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, newName);
            pst.setString(2, newPhone);
            pst.setString(3, newPassword);
            pst.setString(4, newLoc);
            pst.setString(5, email);
            int table = pst.executeUpdate();
            if (table == 1) {
                flag = true;
            } else {
                flag = false;
            }
            cn.close();
        }
        return flag;
    }

    public static boolean banSeller(String sellerID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update seller\n"
                    + "set status=2\n"
                    + "where sellerID=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, sellerID);
            int table = pst.executeUpdate();
            if (table == 1) {
                flag = true;
            } else {
                flag = false;
            }
            cn.close();
        }
        return flag;
    }

    public static boolean unBanSeller(String sellerID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update seller\n"
                    + "set status=1\n"
                    + "where sellerID=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, sellerID);
            int table = pst.executeUpdate();
            if (table == 1) {
                flag = true;
            } else {
                flag = false;
            }
            cn.close();
        }
        return flag;
    }

    public static boolean updateSeller(Seller seller) throws Exception {
        try {
            Connection cn = DBUtils.makeConnection();
            PreparedStatement ps = cn.prepareStatement(UPDATE_SELLER);
            int i = 1;
            ps.setString(i++, seller.getName());
            ps.setString(i++, seller.getPassword());
            ps.setString(i++, seller.getEmail());
            ps.setString(i++, seller.getPhone());
            ps.setString(i++, seller.getGender());
            ps.setString(i++, seller.getLocation());

            ps.setString(i++, seller.getId());
            boolean flag = ps.executeUpdate() > 0;
            if (flag) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Update Error!!");
        }
        return false;
    }

    public static boolean updateOrderDetail(String orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "UPDATE orderDetail SET status = 2 WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (ptm.executeUpdate() > 0) {
                    check = true;
                }

                SQL = "UPDATE orders SET status = 2 WHERE orderID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (ptm.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
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

    public static SellerInforRelative getSellerInfor(String sellerID) throws SQLException {
        SellerInforRelative sir = null;
        int totalProduct = 0, totalSold = 0, totalComment = 0;
        float profit = 0;
        double averageRate = 0, totalRate = 0;
        ArrayList<String> productIdList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT count (productID) AS totalProduct FROM product WHERE sellerID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, sellerID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    totalProduct = rs.getInt("totalProduct");
                }

                SQL = "SELECT sumSold FROM product WHERE sellerID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, sellerID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int tmpTotalSold = rs.getInt("sumSold");
                    totalSold += tmpTotalSold;
                }

                SQL = "SELECT productID FROM product WHERE sellerID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, sellerID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    productIdList.add(productID);
                }

                SQL = "SELECT count (commentID) AS totalCommnet FROM comment WHERE productID = ?";
                for (int i = 0; i < productIdList.size(); i++) {
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, productIdList.get(i));
                    rs = ptm.executeQuery();
                    while (rs.next()) {
                        int tmpComment = rs.getInt("totalCommnet");
                        totalComment += tmpComment;
                    }
                }

                SQL = "SELECT rate FROM comment WHERE productID = ?";
                for (int j = 0; j < productIdList.size(); j++) {
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, productIdList.get(j));
                    rs = ptm.executeQuery();
                    while (rs.next()) {
                        int tmpRate = rs.getInt("rate");
                        totalRate += tmpRate;
                    }
                }
                averageRate = totalRate / totalComment;
                SQL = "SELECT profit FROM seller WHERE sellerID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, sellerID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    profit = rs.getFloat("profit");
                }
                sir = new SellerInforRelative(totalProduct, totalSold, profit, averageRate, totalComment);
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
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
        return sir;
    }

}
