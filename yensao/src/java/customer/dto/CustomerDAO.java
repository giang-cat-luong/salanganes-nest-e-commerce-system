/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package customer.dto;

import google.GoogleDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import seller.dto.Seller;
import utils.DBUtils;

/**
 *
 * @author lequa
 */
public class CustomerDAO {

    public static ArrayList<Customer> getAccounts() throws Exception {
        ArrayList<Customer> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative\n"
                    + "from customer";
            Statement st = cn.createStatement();
            ResultSet table = st.executeQuery(sql);
            if (table != null) {
                while (table.next()) {
                    String cusid = table.getString("cusID");
                    String cusname = table.getString("cusName");
                    String password = table.getString("password");
                    String email = table.getString("email");
                    String avatar = table.getString("avatar");
                    String cusphone = table.getString("cusPhone");
                    String role = table.getString("role");
                    String gender = table.getString("gender");
                    String loc = table.getString("loc");
                    int cumulative = table.getInt("cumulative");
                    Customer acc = new Customer(cusid, cusname, password, email, avatar, cusphone, role, gender, loc, cumulative, 0);
                    list.add(acc);
                }
            }
            cn.close();
        }
        return list;
    }

    public static Customer getAccount(String cusID) throws Exception {
        ArrayList<Customer> list = new ArrayList<>();
        Customer acc = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative\n"
                    + "from customer\n"
                    + "where cusID=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, cusID);
            ResultSet table = pst.executeQuery();
            if (table != null && table.next()) {
                String cusname = table.getString("cusName");
                String password = table.getString("password");
                String email = table.getString("email");
                String avatar = table.getString("avatar");
                String cusphone = table.getString("cusPhone");
                String role = table.getString("role");
                String gender = table.getString("gender");
                String loc = table.getString("loc");
                int cumulative = table.getInt("cumulative");
                acc = new Customer(cusID, cusname, password, email, avatar, cusphone, role, gender, loc, cumulative, 0);
                list.add(acc);
            }
            cn.close();
        }
        return acc;
    }

    public static boolean updateAccount(String email, String newPassword, String newName, String newPhone, String newLoc) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update customer\n"
                    + "set cusName=?, cusPhone=?, password=?, loc=?\n"
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

    public boolean registerGoogle(String email, String givenName, String picture) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO customer(cusName, password, email ,avatar, cusPhone, role, gender, loc, cumulative) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setString(1, givenName);
                pst.setString(2, "*****");
                pst.setString(3, email);
                pst.setString(4, "picture");
                pst.setString(5, "N/A");
                pst.setString(6, "US");
                pst.setString(7, "gender");
                pst.setString(8, "");
                pst.setString(9, "0");
                check = pst.executeUpdate() > 0 ? true : false; // if ptm > 0 => true//

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<Customer> getAllCus() throws SQLException {
        List<Customer> CustomerList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative, balance FROM customer";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String cusID = rs.getString("cusID");
                    String cusName = rs.getString("cusName");
                    String password = rs.getString("password");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String cusPhone = rs.getString("cusPhone");
                    String role = rs.getString("role");
                    String gender = rs.getString("gender");
                    String loc = rs.getString("loc");
                    float cumulative = rs.getFloat("cumulative");
                    float balance = rs.getFloat("balance");
                    CustomerList.add(new Customer(cusID, cusName, password, email, avatar, cusPhone, role, gender,
                            loc, cumulative, balance));
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return CustomerList;
    }

    public List<Seller> getAllSell() throws SQLException {
        List<Seller> SellerList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT sellerID, sellerName, password, email, role FROM seller";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String sellerID = rs.getString("sellerID");
                    String sellerName = rs.getString("sellerName");
                    String password = rs.getString("password");
                    String email = rs.getString("email");
                    String role = rs.getString("role");
                    SellerList.add(new Seller(sellerID, sellerName, password, email, "", "", role, "", "", 1, 0));
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return SellerList;
    }

    public Customer getCusByID(String cusID) throws SQLException {
        Customer Customer = null;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cusName, password, email,avatar, cusPhone, role, gender, loc, cumulative, balance FROM customer WHERE cusID=?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, cusID);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String cusName = rs.getString("cusName");
                    String password = rs.getString("password");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String cusPhone = rs.getString("cusPhone");
                    String role = rs.getString("role");
                    String gender = rs.getString("gender");
                    String loc = rs.getString("loc");
                    float cumulative = rs.getFloat("cumulative");
                    float balance = rs.getFloat("balance");
                    Customer = (new Customer(cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative, balance));
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return Customer;
    }

    public Seller getSellByID(String sellerID) throws SQLException {
        Seller Seller = null;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT sellerName, password, email,avatar, phone, role, gender, loc, balance, status, shipAllow FROM seller WHERE sellerID =?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, sellerID);
                rs = pst.executeQuery();
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

                    Seller = (new Seller(sellerID, sellerName, password, email, avatar, phone, role, gender, loc, profit, status));
                }
            }
        } catch (Exception e) {

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return Seller;
    }

    public boolean registerCustomer(String cusName, String password, String email, String gender) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO customer( cusID, cusName, email, password, role, gender)" + " VALUES(?, ?, ?, ?, ?, ?)";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, "");
                ptm.setString(2, cusName);
                ptm.setString(3, email);
                ptm.setString(4, password);
                ptm.setString(5, "US");
                ptm.setString(6, gender);
                check = ptm.executeUpdate() > 0 ? true : false; // if ptm > 0 => true//
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean insertGoogleUser(GoogleDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO customer( cusID,cusName, email, avatar, role)" + " VALUES(?, ?, ?, ?, ?)";
                ptm = conn.prepareStatement(sql);
                String newName = user.getGiven_name().replaceAll(" ", "");
                ptm.setString(1, "");
                ptm.setString(2, newName);
                ptm.setString(3, user.getEmail());
                ptm.setString(4, user.getPicture());
                ptm.setString(5, "US");
                if (check = ptm.executeUpdate() > 0) {
                    check = true;
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public Customer checkLoginUS(String cusName, String password) throws SQLException {
        Customer cus = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cusID, cusName, password , email, avatar, cusPhone, role, gender, loc, cumulative, balance FROM customer WHERE cusName=? AND password=?";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, cusName);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String cusID = rs.getString("cusID");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String cusPhone = rs.getString("cusPhone");
                    String role = rs.getString("role");
                    String gender = rs.getString("gender");
                    String loc = rs.getString("loc");
                    float cumulative = rs.getFloat("cumulative");
                    float balance = rs.getFloat("balance");
                    cus = new Customer(cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative, balance);
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
        return cus;
    }

    public Seller checkLoginSE(String sellerName, String password) throws SQLException {
        Seller sel = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT sellerID, sellerName, password , email, avatar, phone, role, gender, loc, profit, status FROM seller WHERE sellerName=? AND password=?";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, sellerName);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String sellerID = rs.getString("sellerID");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String phone = rs.getString("phone");
                    String role = rs.getString("role");
                    String gender = rs.getString("gender");
                    String loc = rs.getString("loc");
                    float profit = rs.getFloat("profit");
                    int status = rs.getInt("status");
                    sel = new Seller(sellerID, sellerName, password, email, avatar, phone, role, gender, loc, profit, status);
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
        return sel;
    }

    public static boolean updateCustomer(Customer cus) {
        String SQL = "UPDATE customer "
                + "SET cusName = ?, email = ?, cusPhone = ?, gender = ?, loc = ? WHERE cusID = ?";
        try {
            Connection cn = DBUtils.makeConnection();
            PreparedStatement ps = cn.prepareStatement(SQL);
            int i = 1;

            ps.setString(i++, cus.getName());
            ps.setString(i++, cus.getEmail());
            ps.setString(i++, cus.getPhone());
            ps.setString(i++, cus.getGender());
            ps.setString(i++, cus.getLocation());
            ps.setString(i++, cus.getId());

            boolean flag = ps.executeUpdate() > 0;

            if (flag) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Querry Error!!");
        }
        return false;
    }

    public static boolean changePassword(String password, String cusID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE customer SET password = ? WHERE cusID = ?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, password);
                pst.setString(2, cusID);
                check = pst.executeUpdate() > 0 ? true : false; // if ptm > 0 => true//
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public static String getCurrentOldPass(String cusID) throws Exception {
        String password = "";
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select password from customer where cusID=?";
            ptm = cn.prepareStatement(sql);
            ptm.setString(1, cusID);
            rs = ptm.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    password = rs.getString("password");
                }
            }
            cn.close();
        }
        return password;
    }
}
