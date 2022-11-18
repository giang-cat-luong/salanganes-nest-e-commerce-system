/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cart;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.naming.NamingException;
import others.OrderDTO;
import others.OrderDetailDTO;
import others.Voucher;
import others.VoucherStoreDTO;
import seller.dto.Seller;
import utils.DBUtils;

/**
 *
 * @author lequa
 */
public class CartDAO {

    public static boolean CompareAndUpdateCurentQuantiy(String productID, int quantity) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT quantity FROM product WHERE productID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int currentQuantity = rs.getInt("quantity");
                    if (currentQuantity < quantity) {
                        check = false;
                    } else {
                        int newQuantity = currentQuantity - quantity;
                        SQL = "UPDATE product SET quantity = ? WHERE productID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setInt(1, newQuantity);
                        ptm.setString(2, productID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }
                    }
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

    public static String getKeyVoucher(int voucherID) throws SQLException {
        String keyCode = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT keyCode FROM codeStore code INNER JOIN voucher vou ON code.codeID = vou.codeID WHERE voucherID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setInt(1, voucherID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    keyCode = rs.getString("keyCode");
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
        return keyCode;
    }

    public static float getPriceByProductID(String productID) throws SQLException {
        float price = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT price FROM product WHERE productID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    price = rs.getFloat("price");
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
        return price;
    }

    public static boolean compareAndUpdateCurrentBalance(String cusID, float total, float cumulativeUse, float cumulativeEarn) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT balance FROM customer WHERE cusID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    float balance = rs.getFloat("balance");
                    if (balance < total) {
                        check = false;
                    } else {
                        float newBalance = balance - total;
                        SQL = "UPDATE customer SET balance = ? WHERE cusID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setFloat(1, newBalance);
                        ptm.setString(2, cusID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }

                        SQL = "SELECT cumulative FROM customer WHERE cusID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setString(1, cusID);
                        rs = ptm.executeQuery();
                        if (rs.next()) {
                            float currentCumulative = rs.getFloat("cumulative");
                            float newCumulative = 0;
                            if (cumulativeUse != 0) {
                                newCumulative = currentCumulative - cumulativeUse + cumulativeEarn;
                            } else {
                                newCumulative = currentCumulative + cumulativeEarn;
                            }

                            SQL = "UPDATE customer SET cumulative = ? WHERE cusID = ?";
                            ptm = conn.prepareStatement(SQL);
                            ptm.setFloat(1, newCumulative);
                            ptm.setString(2, cusID);
                            if (ptm.executeUpdate() < 0) {
                                check = false;
                            }
                        }
                    }
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

    public static boolean inSertCumulativeEarn(String detail, String cusID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "INSERT INTO saveCumulative(cusID, infor, time) VALUES (?, ?, ?)";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                ptm.setString(2, detail);
                long millis = System.currentTimeMillis();
                java.sql.Date date = new java.sql.Date(millis);
                ptm.setDate(3, date);
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

    public static String getCountTotal() throws SQLException {
        int orderCount = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT COUNT (orderID) AS orderCount FROM orders";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    orderCount = rs.getInt("orderCount");
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
        String tmp = Integer.toString(orderCount);
        return tmp;
    }

    public static boolean insertOrder(String orderID, String cusID, float cumulativeUse, float cumulativeEarn, float total) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT cusName, cusPhone, loc FROM customer WHERE cusID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String cusName = rs.getString("cusName");
                    String cusPhone = rs.getString("cusPhone");
                    String loc = rs.getString("loc");

                    SQL = " INSERT INTO orders(orderID, cusID, cusName, cusPhone, loc, ordDate, cumulativeUse, cumulativeEarn, total) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, orderID);
                    ptm.setString(2, cusID);
                    ptm.setString(3, cusName);
                    ptm.setString(4, cusPhone);
                    ptm.setString(5, loc);
                    long millis = System.currentTimeMillis();
                    java.sql.Date date = new java.sql.Date(millis);
                    ptm.setDate(6, date);
                    ptm.setFloat(7, cumulativeUse);
                    ptm.setFloat(8, cumulativeEarn);
                    ptm.setFloat(9, total);
                    if (ptm.executeUpdate() > 0) {
                        check = true;
                    }
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

    public static boolean insertOrderDetail(String orderID, String sellerID, String productID, String productName, String img, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "INSERT INTO orderDetail(orderDetailID, orderID, sellerID, productID, productName, img, quantity) VALUES(?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, "");
                ptm.setString(2, orderID);
                ptm.setString(3, sellerID);
                ptm.setString(4, productID);
                ptm.setString(5, productName);
                ptm.setString(6, img);
                ptm.setInt(7, quantity);
                if (ptm.executeUpdate() > 0) {
                    check = true;
                }

                int sumsold = 0;
                SQL = "SELECT sumsold FROM product WHERE productID = ? ";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    sumsold = rs.getInt("sumsold");
                }
                int newSumsold = sumsold + quantity;
                SQL = "UPDATE product SET sumsold = ? WHERE productID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setInt(1, newSumsold);
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

    public static boolean deleteVoucher(int voucherID) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT quantity FROM voucher WHERE voucherID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setInt(1, voucherID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int quantity = rs.getInt("quantity");
                    if (quantity == 1) {
                        SQL = "DELETE voucher WHERE voucherID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setInt(1, voucherID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }
                    } else {
                        int newQuantity = quantity - 1;
                        SQL = "UPDATE voucher SET quantity = ? WHERE voucherID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setInt(1, newQuantity);
                        ptm.setInt(2, voucherID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }
                    }
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

    public static ArrayList<Voucher> getVoucherCustomer(String cusID) throws SQLException {
        ArrayList<Voucher> vl = new ArrayList<>();
        Voucher v = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT voucherID, name, codeID, quantity FROM voucher WHERE cusID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int voucherID = rs.getInt("voucherID");
                    String name = rs.getString("name");
                    String codeID = rs.getString("codeID");
                    int quantity = rs.getInt("quantity");

                    v = new Voucher(voucherID, name, codeID, cusID, quantity);
                    vl.add(v);
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

        return vl;
    }

    public static boolean updateOrder(String orderID) throws SQLException {
        boolean check = true;
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
                if (ptm.executeUpdate() < 0) {
                    check = false;
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

    public static boolean getBackTransaction(String orderID) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT cusID, voucherID, cumulativeUse, cumulativeEarn, total FROM orders  WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String cusID = rs.getString("cusID");
                    int voucherID = rs.getInt("voucherID");
                    float cumulativeUse = rs.getFloat("cumulativeUse");
                    float cumulativeEarn = rs.getFloat("cumulativeEarn");
                    float total = rs.getFloat("total");

                    float balance = 0;
                    float cumulative = 0;

                    SQL = "SELECT balance, cumulative FROM customer WHERE cusID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, cusID);
                    ResultSet rs2 = ptm.executeQuery();
                    while (rs2.next()) {
                        balance = rs2.getFloat("balance");
                        cumulative = rs2.getFloat("cumulative");
                    }

                    if (cumulativeUse != 0) {
                        float newCumulative = cumulative - cumulativeEarn + cumulativeUse;
                        float newBalance = balance + total;
                        SQL = "UPDATE customer SET balance = ? , cumulative = ? WHERE cusID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setFloat(1, newBalance);
                        ptm.setFloat(2, newCumulative);
                        ptm.setString(3, cusID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }
                    } else {
                        float newCumulative = cumulative - cumulativeEarn;
                        float newBalance = balance + total;
                        SQL = "UPDATE customer SET balance = ? , cumulative = ? WHERE cusID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setFloat(1, newBalance);
                        ptm.setFloat(2, newCumulative);
                        ptm.setString(3, cusID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }
                    }
                    SQL = "SELECT quantity FROM voucher WHERE voucherID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setInt(1, voucherID);
                    ResultSet rs4 = ptm.executeQuery();
                    if (rs4.next()) {
                        int quantity = rs4.getInt("quantity");
                        int newQuantity = quantity + 1;
                        SQL = "UPDATE voucher SET quantity = ? WHERE voucherID = ?";
                        ptm = conn.prepareStatement(SQL);
                        ptm.setInt(1, newQuantity);
                        ptm.setInt(2, voucherID);
                        if (ptm.executeUpdate() < 0) {
                            check = false;
                        }
                    }
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

    public static boolean getBackQuantity(String orderID) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT productID, quantity  FROM orderDetail WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    int quantity = rs.getInt("quantity");

                    int tmpQuantity = 0, sumsold = 0;

                    SQL = "SELECT quantity, sumSold FROM product WHERE productID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, productID);
                    ResultSet rs2 = ptm.executeQuery();
                    if (rs2.next()) {
                        tmpQuantity = rs.getInt("quantity");
                        sumsold = rs.getInt("sumSold");
                    }

                    int newQuantity = tmpQuantity + quantity;
                    int newSumsold = sumsold - quantity;
                    SQL = "UPDATE product SET quantity = ?, sumSold = ? WHERE productID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setInt(1, newQuantity);
                    ptm.setInt(2, newSumsold);
                    ptm.setString(3, productID);
                    ResultSet rs3 = ptm.executeQuery();
                    if (ptm.executeUpdate() < 0) {
                        check = false;
                    }
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

    public static boolean cancelOrder(String orderID) throws SQLException {
        ArrayList<String> ordIdl = new ArrayList<>();
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT orderDetailID  FROM orderDetail WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String orderDetailID = rs.getString("orderDetailID");
                    ordIdl.add(orderDetailID);
                }
                for (int i = 0; i < ordIdl.size(); i++) {
                    SQL = "UPDATE orderDetail SET status = 4 WHERE orderDetailID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, ordIdl.get(i));
                    if (ptm.executeUpdate() < 0) {
                        check = false;
                        break;
                    }
                }

                SQL = "UPDATE orders SET status = 4 WHERE orderID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                if (ptm.executeUpdate() < 0) {
                    check = false;
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

    public static Seller getSellerById(String sellerID) throws SQLException {
        Seller s = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT sellerName, avatar FROM seller WHERE sellerID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, sellerID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String sellerName = rs.getString("sellerName");
                    String avatar = rs.getString("avatar");
                    s = new Seller("", sellerName, avatar);
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
        return s;
    }

    public static boolean updateOrderDetail(String orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "UPDATE orderDetail SET status = 4 WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (ptm.executeUpdate() > 0) {
                    check = true;
                }

                SQL = "UPDATE orders SET status = 4 WHERE orderID = ?";
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

    public static float getCumulative(String cusID) throws SQLException {
        float cumulative = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT cumulative FROM customer WHERE cusID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    cumulative = rs.getFloat("cumulative");
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
        return cumulative;
    }

    public static ArrayList<OrderDetailDTO> getOrderDetailByOrderID(String orderID) throws SQLException {
        ArrayList<OrderDetailDTO> ordl = new ArrayList<>();
        OrderDetailDTO ord = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM orderDetail WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String orderDetailID = rs.getString("orderDetailID");
                    String orderID2 = rs.getString("orderID");
                    String sellerID = rs.getString("sellerID");
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String img = rs.getString("img");
                    int quantity = rs.getInt("quantity");
                    int status = rs.getInt("status");
                    ord = new OrderDetailDTO(orderDetailID, orderID2, sellerID, productID, productName, img, quantity, status);
                    ordl.add(ord);
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
        return ordl;
    }

    public static ArrayList<OrderDTO> getOrderByCusID(String cusID) throws SQLException {
        OrderDTO or = null;
        ArrayList<OrderDTO> orl = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM orders WHERE cusID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String orderID = rs.getString("orderID");
                    String cusID2 = rs.getString("cusID");
                    String cusName = rs.getString("cusName");
                    String cusPhone = rs.getString("cusPhone");
                    String loc = rs.getString("loc");
                    Date date = rs.getDate("ordDate");
                    int status = rs.getInt("status");
                    int voucherID = rs.getInt("voucherID");
                    float cumulativeUse = rs.getFloat("cumulativeUse");
                    float cumulativeEarn = rs.getFloat("cumulativeEarn");
                    float total = rs.getFloat("total");
                    or = new OrderDTO(orderID, cusID2, cusName, cusPhone, loc, date, status, voucherID, cumulativeUse, cumulativeEarn, total);
                    orl.add(or);
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
        return orl;
    }

    public static OrderDTO getOrderByOrderID(String orderID) throws SQLException {
        OrderDTO or = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT * FROM orders WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String orderID2 = rs.getString("orderID");
                    String cusID = rs.getString("cusID");
                    String cusName = rs.getString("cusName");
                    String cusPhone = rs.getString("cusPhone");
                    String loc = rs.getString("loc");
                    Date date = rs.getDate("ordDate");
                    int status = rs.getInt("status");
                    int voucherID = rs.getInt("voucherID");
                    float cumulativeUse = rs.getFloat("cumulativeUse");
                    float cumulativeEarn = rs.getFloat("cumulativeEarn");
                    float total = rs.getFloat("total");
                    or = new OrderDTO(orderID2, cusID, cusName, cusPhone, loc, date, status, voucherID, cumulativeUse, cumulativeEarn, total);
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
        return or;
    }

    public static ArrayList<OrderDetailDTO> updateAndGetOrderDetail(String orderID) throws SQLException, Exception {
        ArrayList<OrderDetailDTO> ordl = new ArrayList<>();
        OrderDetailDTO ord = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT orderDetailID, sellerID, productID , quantity FROM OrderDetail WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String orderDetailID = rs.getString("orderDetailID");
                    String sellerID = rs.getString("sellerID");
                    String productID = rs.getString("productID");
                    int quantity = rs.getInt("quantity");
                    ord = new OrderDetailDTO(orderDetailID, sellerID, productID, quantity);
                    ordl.add(ord);
                }

                SQL = "UPDATE orders SET status = 2 WHERE orderID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (ptm.executeUpdate() < 0) {
                    throw (new Exception());
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
        return ordl;
    }

    public static boolean updateOrder2(String orderID) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "UPDATE orders SET status = 3 WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (ptm.executeUpdate() < 0) {
                    check = false;
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

    public static boolean insertComment(String cusID, String productID, String detail, String img, int rate) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "INSERT INTO comment( cusID, productID, detail, img, rate) VALUES(?, ?, ?, ?, ?)";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                ptm.setString(2, productID);
                ptm.setString(3, detail);
                ptm.setString(4, img);
                ptm.setInt(5, rate);
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

    public static boolean checkVoucher(String voucherID, String codeID, String name, String cusID) throws SQLException {
        int quantity = 0;
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT quantity FROM voucher WHERE voucherID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, voucherID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
                if (quantity != 0) {
                    int newQuantity = quantity + 1;
                    SQL = "UPDATE voucher SET quantity = ? WHERE voucherID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, voucherID);
                    ptm.setInt(2, newQuantity);
                    rs = ptm.executeQuery();
                    if (ptm.executeUpdate() < 0) {
                        check = false;
                    }
                } else {
                    SQL = "INSERT INTO voucher(  name, codeID, cusID, quantity) VALUES(?, ?, ?, ?)";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, name);
                    ptm.setString(2, codeID);
                    ptm.setString(3, cusID);
                    ptm.setInt(4, 1);
                    check = ptm.executeUpdate() > 0;
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

    public static boolean updateCumulative(String codeID, String cusID) throws SQLException {
        float tradingPoint = 0, cumulative = 0;
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT tradingPoint FROM codeStore WHERE codeID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, codeID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    tradingPoint = rs.getFloat("tradingPoint");
                }
                SQL = "SELECT cumulative FROM customer WHERE cusID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, cusID);
                ResultSet rs2 = ptm.executeQuery();
                while (rs2.next()) {
                    cumulative = rs.getFloat("cumulative");
                }
                if (cumulative >= tradingPoint) {
                    float newCumulative = cumulative - tradingPoint;
                    SQL = "UPDATE customer SET cumulative = ? WHERE cusID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, cusID);
                    ptm.setFloat(2, newCumulative);
                    rs = ptm.executeQuery();
                    if (ptm.executeUpdate() < 0) {
                        check = false;
                    }
                } else {
                    check = false;
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

    public static ArrayList<VoucherStoreDTO> getAllVoucher() throws SQLException {
        ArrayList<VoucherStoreDTO> vsl = new ArrayList<>();
        VoucherStoreDTO vs = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT voucherID, name, codeID FROM voucher";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int voucherID = rs.getInt("voucherID");
                    String name = rs.getString("name");
                    String codeID = rs.getString("codeID");

                    SQL = "SELECT tradingPoint FROM codeStore WHERE codeID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, codeID);
                    ResultSet rs2 = ptm.executeQuery();
                    while (rs.next()) {
                        float tradingPoint = rs.getFloat("tradingPoint");
                        vs = new VoucherStoreDTO(voucherID, name, codeID, tradingPoint);
                        vsl.add(vs);
                    }
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
        return vsl;
    }

    public static boolean tranferProfit(String orderDetailID, String sellerID, String productID, int quantity, String orderID, float cumulativeUse) throws SQLException {
        boolean check = true;
        float price = 0, total = 0;
        int voucherID = 0;
        String codeID = "", keyCode = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT voucherID FROM orders WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    voucherID = rs.getInt("voucherID");
                }
                if (voucherID != 0) {
                    SQL = "SELECT codeID FROM voucher WHERE voucherID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setInt(1, voucherID);
                    rs = ptm.executeQuery();
                    while (rs.next()) {
                        codeID = rs.getString("codeID");
                    }
                }

                if (!codeID.equals("")) {
                    SQL = "SELECT keyCode FROM codeStore WHERE codeID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, codeID);
                    rs = ptm.executeQuery();
                    if (rs.next()) {
                        keyCode = rs.getString("keyCode");
                    }
                }

                SQL = "SELECT price FROM product WHERE productID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    price = rs.getFloat("price");
                }

                total = price * quantity;
                if (!keyCode.equals("")) {
                    if (keyCode.equalsIgnoreCase("RD10PT")) {
                        total = total - (total * (1 / 10));
                    } else if (keyCode.equalsIgnoreCase("RD20PT")) {
                        total = total - (total * (2 / 10));
                    } else if (keyCode.equalsIgnoreCase("RD30PT")) {
                        total = total - (total * (3 / 10));
                    }
                }
                if (cumulativeUse != 0) {
                    total = total - cumulativeUse;
                }

                SQL = "UPDATE seller SET profit = ? WHERE sellerID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setFloat(1, total);
                ptm.setString(2, sellerID);
                if (ptm.executeUpdate() < 0) {
                    check = false;
                }

                SQL = "UPDATE orderDetail SET status = 2 WHERE orderDetailID = ?";
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderDetailID);
                if (ptm.executeUpdate() < 0) {
                    check = false;
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

    public static float getCumulativeUseByOrderID(String orderID) throws SQLException {
        float cumulativeUse = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT cumulativeUse FROM orders WHERE orderID = ?";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    cumulativeUse = rs.getFloat("cumulativeUse");
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
        return cumulativeUse / 100;
    }

    public static boolean updateAndCheckOrderDetail(String orderDetailID) throws SQLException {
        ArrayList<Integer> statuss = new ArrayList<>();
        boolean check = true, check2 = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String SQL = "SELECT orderID FROM orderDetail WHERE orderDetailID = ?";
        String orderID = "";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SQL);
                ptm.setString(1, orderDetailID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    orderID = rs.getString("orderID");

                    SQL = "UPDATE orderDetail SET status = 3 WHERE orderDetailID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, orderDetailID);
                    if (ptm.executeUpdate() < 0) {
                        check = false;
                    }

                    SQL = "SELECT status FROM orderDetail WHERE orderID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, orderID);
                    ResultSet rs3 = ptm.executeQuery();
                    while (rs3.next()) {
                        int status = rs3.getInt("status");
                        statuss.add(status);
                    }
                }

                for (int i = 0; i < statuss.size(); i++) {
                    if (statuss.get(i) == 2) {
                        check2 = false;
                        break;
                    }
                }
                if (check2 == true) {
                    SQL = "UPDATE orders SET status = 3 WHERE orderID = ?";
                    ptm = conn.prepareStatement(SQL);
                    ptm.setString(1, orderID);
                    if (ptm.executeUpdate() < 0) {
                        check = false;
                    }
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
}
