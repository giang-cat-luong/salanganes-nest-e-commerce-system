/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manager.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import others.ReportDTO;
import product.dto.Product;
import utils.DBUtils;

/**
 *
 * @author lequa
 */
public class ManagerDAO {

    private static final String GET_REPORT_LIST = "SELECT reportID, cusID, productID, dateReport, description, img FROM reportProduct";
    private static final String GET_PRODUCT_LIST = "SELECT productID, cateID, sellerID, productName, cateName, quantity, cover, price, description FROM product WHERE status = 1";
    private static final String UPDATE_REQUEST = "UPDATE request SET status = 2 WHERE requestID = ?";
    private static final String SELECT_CUSTOMER = "SELECT cusName, password, email, avatar, cusPhone, gender, loc, balance FROM customer WHERE cusID = ?";
    private static final String INSERT_SELLER = "INSERT INTO  seller(sellerID, sellerName, password, email, avatar, phone, role, gender, loc, balance) VALUES (?, ?, ?, ?, ? ,?, ?, ?, ?)";
    private static final String UPDATE_ROLE_CUSTOMER = "UPDATE customer SET role = ? WHERE cusID = ?";

    public boolean updateRequest(int requestID, String cusID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_REQUEST);
                ptm.setInt(1, requestID);
                check = ptm.executeUpdate() > 0 ? true : false;
                if (check == true) {
                    ptm = conn.prepareStatement(SELECT_CUSTOMER);
                    ptm.setString(1, cusID);
                    rs = ptm.executeQuery();
                    if (rs.next()) {
                        String cusName = rs.getString("cusName");
                        String password = rs.getString("password");
                        String email = rs.getString("email");
                        String avatar = rs.getString("avatar");
                        String cusPhone = rs.getString("cusPhone");
                        String gender = rs.getString("gender");
                        String loc = rs.getString("loc");
                        float balance = rs.getFloat("balance");

                        ptm = conn.prepareStatement(INSERT_SELLER);
                        ptm.setString(1, "");
                        ptm.setString(2, cusName);
                        ptm.setString(3, password);
                        ptm.setString(4, email);
                        ptm.setString(5, avatar);
                        ptm.setString(6, cusPhone);
                        ptm.setString(7, "SE");
                        ptm.setString(8, gender);
                        ptm.setString(9, loc);
                        ptm.setFloat(10, balance);
                        if (ptm.executeUpdate() > 0) {
                            check = true;
                        } else {
                            check = false;
                        }
                    }
                }
                if (check == true) {
                    ptm = conn.prepareStatement(UPDATE_ROLE_CUSTOMER);
                    ptm.setString(1, "ERROR");
                    ptm.setString(2, cusID);
                    check = ptm.executeUpdate() > 0 ? true : false; // if ptm > 0 => true//
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
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

    public static ArrayList<ReportDTO> getReportList() throws SQLException, Exception {
        try {
            Connection conn = DBUtils.makeConnection();
            PreparedStatement ps = conn.prepareStatement(GET_REPORT_LIST);
            ResultSet rs = ps.executeQuery();
            ArrayList<ReportDTO> list = new ArrayList<>();
            while (rs.next()) {
                ReportDTO rep = new ReportDTO(rs.getInt("reportID"), rs.getString("cusID"),
                        rs.getString("productID"), rs.getTimestamp("dateReport"),
                        rs.getString("description"),
                        rs.getString("img"));
                list.add(rep);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getAllBook Query Error!" + ex.getMessage());
        }
        return null;
    }

    public static ArrayList<Product> getProductList() throws SQLException, Exception {
        try {
            Connection conn = DBUtils.makeConnection();
            PreparedStatement ps = conn.prepareStatement(GET_PRODUCT_LIST);
            ResultSet rs = ps.executeQuery();
            ArrayList<Product> list = new ArrayList<>();
            while (rs.next()) {
                Product pro = new Product(rs.getString("productID"), rs.getString("cateID"),
                        rs.getString("sellerID"), rs.getString("productName"),
                        rs.getString("cateName"), rs.getInt("quantity"),
                        rs.getString("cover"),
                        rs.getFloat("price"), rs.getString("description"), 0, 1);
                list.add(pro);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getAllBook Query Error!" + ex.getMessage());
        }
        return null;
    }

    public boolean addNewUser(String name, String password, String email,
            String avatar, int phone, String role, String gender, String loc) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (role.equalsIgnoreCase("US")) {
                    String sql = "INSERT INTO customer( cusID, cusName, password, email, avatar, cusPhone, role, gender, loc)"
                            + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ptm = conn.prepareStatement(sql);
                    ptm.setString(1, "");
                    ptm.setString(2, name);
                    ptm.setString(3, password);
                    ptm.setString(4, email);
                    ptm.setString(5, avatar);
                    ptm.setInt(6, phone);
                    ptm.setString(7, role);
                    ptm.setString(8, gender);
                    ptm.setString(9, loc);
                    check = ptm.executeUpdate() > 0 ? true : false; // if ptm > 0 => true//
                }
                if (role.equalsIgnoreCase("SE")) {
                    String sql = "INSERT INTO seller( sellerID ,sellerName, password, email, avatar, phone, role, gender, loc)"
                            + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ptm = conn.prepareStatement(sql);
                    ptm.setString(1, "");
                    ptm.setString(2, name);
                    ptm.setString(3, password);
                    ptm.setString(4, email);
                    ptm.setString(5, avatar);
                    ptm.setInt(6, phone);
                    ptm.setString(7, role);
                    ptm.setString(8, gender);
                    ptm.setString(9, loc);
                    check = ptm.executeUpdate() > 0 ? true : false; // if ptm > 0 => true//
                }
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
}
