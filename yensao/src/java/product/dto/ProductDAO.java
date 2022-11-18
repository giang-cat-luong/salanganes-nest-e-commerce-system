/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import others.CategoryDTO;
import utils.DBUtils;

/**
 *
 * @author lequa
 */
public class ProductDAO {

    private static final String GET_HIGH_PRODUCT = "SELECT TOP 10 productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status "
            + "FROM product WHERE status = 2 OR status = 3 "
            + "ORDER BY sumSold DESC";

    private static final String SELECT_PRODUCT_SQL = "SELECT TOP 12 productID, cateID, sellerID, productName, "
            + "quantity, cover, price, description,status "
            + "FROM product"
            + "Where status = 2";
    private static final String SELECT_ALL_PRODUCT_SQL = SELECT_PRODUCT_SQL.replace("TOP 12", "");
    private static final String SEARCH_PRODUCT_SQL = SELECT_ALL_PRODUCT_SQL + " AND productName LIKE ?";
    private static final String INSERT_PRODUCT_SQL = "INSERT INTO product(productID, cateID, sellerID, productName, cateName, quantity, cover, price, description)"
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_CATE_NAME = "SELECT cateName FROM category WHERE cateID = ?";
    private static final String GET_PRODUCT_BY_ID = "select * from product where cateID = ? and status = 3";
    private static final String GET_PRODUCT_BY_ID_2 = "select * from product where productID = ?";

    //this function is used to get Product detail Controller based on sellerID
    public static boolean addNewProduct(String productID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update product\n"
                    + "set status = 3\n"
                    + "where productID=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, productID);
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

    public static ArrayList<Product> getProductSeller(String sellerID) throws Exception {
        ArrayList<Product> list = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String sql = "select productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status\n"
                    + "from product\n"
                    + "where sellerID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, sellerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String cateID = rs.getString("cateID");
                    sellerID = rs.getString("sellerID");
                    String productName = rs.getString("productName");
                    String cateName = rs.getString("cateName");
                    int quantity = rs.getInt("quantity");
                    String cover = rs.getString("cover");
                    float price = rs.getFloat("price");
                    String description = rs.getString("description");
                    int sumSold = rs.getInt("sumSold");
                    int status = rs.getInt("status");
                    Product p = new Product(productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status);
                    list.add(p);
                }
            }
            cn.close();
        }

        return list;
    }

    // KIET WORK 
    public static boolean insertProduct(String productID, String cateID, String sellerID, String productName, int quantity, String cover, float price, String description) {
        boolean check = false;
        try {
            Product p = new Product();
            Connection conn = DBUtils.makeConnection();
            PreparedStatement ps = conn.prepareStatement(GET_CATE_NAME);
            ps.setString(1, cateID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String cateName = rs.getString("cateName");
                ps = conn.prepareStatement(INSERT_PRODUCT_SQL);
                ps.setString(1, productID);
                ps.setString(2, cateID);
                ps.setString(3, sellerID);
                ps.setString(4, productName);
                ps.setString(5, cateName);
                ps.setInt(6, quantity);
                ps.setString(7, cover);
                ps.setFloat(8, price);
                ps.setString(9, description);
                if (check = ps.executeUpdate() > 0) {
                    check = true;
                }
            }

        } catch (Exception e) {
            System.out.println("Querry error");
        }
        return check;
    }
    //END OF KIET WORK

    public static ArrayList<Product> getHighProductList() throws Exception {
        try {
            Connection conn = DBUtils.makeConnection();
            PreparedStatement ps = conn.prepareStatement(GET_HIGH_PRODUCT);
            ResultSet rs = ps.executeQuery();
            ArrayList<Product> list = new ArrayList<>();
            while (rs.next()) {
                Product product = new Product(rs.getString("productID"), rs.getString("cateID"),
                        rs.getString("sellerID"), rs.getString("productName"),
                        rs.getString("cateName"),
                        rs.getInt("quantity"), rs.getString("cover"),
                        rs.getFloat("price"), rs.getString("description"),
                        rs.getInt("sumSold"), rs.getInt("status"));
                list.add(product);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getAllBook Query Error!" + ex.getMessage());
        }
        return null;
    }

    /*    public static List<Product> getAllProduct() throws Exception {
        try {
            Connection conn = DBUtils.makeConnection();
            PreparedStatement ps = conn.prepareStatement(SELECT_ALL_PRODUCT_SQL);
            ResultSet rs = ps.executeQuery();
            List<Product> list = new ArrayList<Product>();
            while (rs.next()) {
                Product product = new Product(rs.getString("productID"), rs.getString("cateID"),
                        rs.getString("sellerID"), rs.getString("productName"),
                        rs.getInt("quantity"), rs.getString("cover"),
                        rs.getFloat("price"), rs.getString("description"),
                        rs.getInt("status"));
                list.add(product);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getAllBook Query Error!" + ex.getMessage());
        }
        return null;
    }

    public static Product getProductByID(String productID) {
        String query = "SELECT * from Product "
                + " WHERE productID = ?";
        try {
            Connection conn = DBUtils.makeConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getString("productID"), rs.getString("cateID"),
                        rs.getString("sellerID"), rs.getString("productName"),
                        rs.getInt("quantity"), rs.getString("cover"),
                        rs.getFloat("price"), rs.getString("description"),
                        rs.getInt("status"));
            }
        } catch (Exception ex) {
            System.out.println("Query Get Book By ID error!" + ex.getMessage());
        }
        return null;
    }
     */
    public static boolean deleteProduct(String productID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "delete from product\n"
                    + "where productID=?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, productID);
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

    public static boolean convertProduct(String productID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update product\n"
                    + "set status = 3\n"
                    + "where productID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, productID);
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

    public static boolean removeProduct(String productID) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            String sql = "update product\n"
                    + "set status = 2\n"
                    + "where productID = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, productID);
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

    public static boolean updateProduct(String productID, String productName, String cateID, String cover, int quantity, float price, String description) throws Exception {
        Connection cn = DBUtils.makeConnection();
        boolean flag = false;
        if (cn != null) {
            PreparedStatement ps = cn.prepareStatement(GET_CATE_NAME);
            ps.setString(1, cateID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String cateName = rs.getString("cateName");
                String sql = "update product\n"
                        + "set cateID = ?, productName = ?, cateName = ?, cover = ?, quantity = ?, price = ?, description = ?\n"
                        + "where productID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, cateID);
                pst.setString(2, productName);
                pst.setString(3, cateName);
                pst.setString(4, cover);
                pst.setInt(5, quantity);
                pst.setFloat(6, price);
                pst.setString(7, description);
                pst.setString(8, productID);
                int table = pst.executeUpdate();
                if (table == 1) {
                    flag = true;
                }
            }
            cn.close();
        }

        return flag;
    }

    public static ArrayList<Product> getAllProductSelling() throws Exception {
        ArrayList<Product> list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "SELECT productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status FROM product WHERE status = 3";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs != null) {
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String cateID = rs.getString("cateID");
                    String sellerID = rs.getString("sellerID");
                    String productName = rs.getString("productName");
                    String cateName = rs.getString("cateName");
                    int quantity = rs.getInt("quantity");
                    String cover = rs.getString("cover");
                    float price = rs.getFloat("price");
                    String description = rs.getString("description");
                    int sumSold = rs.getInt("sumSold");
                    int status = rs.getInt("status");
                    Product p = new Product(productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status);
                    list.add(p);
                }
            }
            cn.close();
        }
        return list;
    }

    public static ArrayList<Product> getProductById(String cateID) throws Exception {
        Connection conn = null;
        PreparedStatement pt = null;
        ResultSet rs = null;
        ArrayList<Product> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                pt = conn.prepareStatement(GET_PRODUCT_BY_ID);
                pt.setString(1, cateID);
                rs = pt.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String productID = rs.getString("productID");
                        String sellerID = rs.getString("sellerID");
                        String productName = rs.getString("productName");
                        String cateName = rs.getString("catename");
                        int quantity = rs.getInt("quantity");
                        String cover = rs.getString("cover");
                        float price = rs.getFloat("price");
                        String description = rs.getString("description");
                        int sumSold = rs.getInt("sumSold");
                        int status = rs.getInt("status");
                        Product p = new Product(productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status);
                        list.add(p);
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

    public Product getProductById2(String productID) throws Exception {
        Connection conn = null;
        PreparedStatement pt = null;
        ResultSet rs = null;
        Product pr = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                pt = conn.prepareStatement(GET_PRODUCT_BY_ID_2);
                pt.setString(1, productID);
                rs = pt.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        productID = rs.getString("productID");
                        String cateID = rs.getString("cateID");
                        String sellerID = rs.getString("sellerID");
                        String productName = rs.getString("productName");
                        String cateName = rs.getString("catename");
                        int quantity = rs.getInt("quantity");
                        String cover = rs.getString("cover");
                        float price = rs.getFloat("price");
                        String description = rs.getString("description");
                        int sumSold = rs.getInt("sumSold");
                        int status = rs.getInt("status");
                        pr = new Product(productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status);
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
        return pr;
    }
}
