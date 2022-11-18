/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cartController;

import cart.CartDAO;
import cart.Cart;
import cart.CartDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import product.dto.Product;

/**
 *
 * @author lequa
 */
@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    private static final String ERROR = "MainController?action=ViewCart";
    private static final String SUCCESS = "MainController?action=ViewCart";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean checkQuantity = true, checkBalance = true, checkVoucher = true, check = false;
            String[] productID = request.getParameterValues("yes");
            if (productID != null) {
                String cusID = request.getParameter("cusID");
                int voucherID = Integer.parseInt(request.getParameter("voucherID"));
                float cumulativeUse = Float.parseFloat(request.getParameter("cumulative"));
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("CART");
                ArrayList<Product> pl = new ArrayList<>();
                //Kiem tra cart co rong hay ko
                if (cart != null) {
                    //Lay phan tu dang duoc chon thanh toan
                    for (CartDTO c : cart.getCart().values()) {
                        for (String s : productID) {
                            if (c.getProductID().equalsIgnoreCase(s)) {
                                Product p = new Product(c.getProductID(), c.getSellerID(), c.getName(), c.getCateName(),
                                        c.getQuantity(), c.getCover(), c.getPrice(), c.getDescription());
                                pl.add(p);
                            }
                        }
                    }
                    //Kiem tra so luong tung san pham dc thanh toan va cap nhap so luong
                    for (int j = 0; j < pl.size(); j++) {
                        checkQuantity = CartDAO.CompareAndUpdateCurentQuantiy(pl.get(j).getProductID(), pl.get(j).getQuantity());
                        if (checkQuantity == false) {
                            request.setAttribute("ERRORR_CHECK_OUT", "Sorry We Not Have Enough Quantity Of " + pl.get(j).getProductName());
                            break;
                        }
                    }
                    //Lay lai tong gia
                    float total = 0;
                    for (int k = 0; k < pl.size(); k++) {
                        total += pl.get(k).getPrice() * pl.get(k).getQuantity();
                    }
                    //Kiem tra loai voucher duoc su dung
                    String keyCode = "";
                    if (voucherID != 0) {
                        keyCode = CartDAO.getKeyVoucher(voucherID);
                    }
                    float cumulativeEarn = total;
                    if (!keyCode.equals("")) {
                        switch (keyCode) {
                            case "RD10PT":
                                total = total - (total * (10 / 100));
                                break;
                            case "RD20PT":
                                total = total - (total * (20 / 100));
                                break;
                            case "RD30PT":
                                total = total - (total * (30 / 100));
                                break;
                            case "EX15CU":
                                cumulativeEarn = cumulativeEarn * (3 / 2);
                                break;
                            case "EX20CU":
                                cumulativeEarn = cumulativeEarn * 2;
                                break;
                            case "EX30CU":
                                cumulativeEarn = cumulativeEarn * 3;
                                break;
                            default:
                                break;
                        }
                    }
                    //xoa voucher 
                    if (voucherID != 0) {
                        checkVoucher = CartDAO.deleteVoucher(voucherID);
                    }
                    //Tru diem tich luy vao tong tien neu co
                    if (cumulativeUse != 0) {
                        float tmpCumulative = cumulativeUse / 100;
                        if (tmpCumulative > total) {
                            total = tmpCumulative - total;
                            cumulativeUse = (tmpCumulative - total) * 100;
                            total = 0;
                        } else {
                            total = total - tmpCumulative;
                        }
                    }
                    //kiem tra so du tai khoan va cap nhap so dung voi diem tich luy
                    checkBalance = CartDAO.compareAndUpdateCurrentBalance(cusID, total, cumulativeUse, cumulativeEarn);
                    if (checkBalance == false) {
                        request.setAttribute("ERRORR_CHECK_OUT", "Sorry Your Balance Is Not Enought");
                    } else {
                        //Create primary key order 
                        String orderID = cusID + "CK" + CartDAO.getCountTotal();
                        //Insert Order 
                        check = CartDAO.insertOrder(orderID, cusID, cumulativeUse, cumulativeEarn, total);
                        if (check == true) {
                            //Insert OrderDetail
                            for (int l = 0; l < pl.size(); l++) {
                                check = CartDAO.insertOrderDetail(orderID, pl.get(l).getSellerID(),
                                        pl.get(l).getProductID(), pl.get(l).getProductName(),
                                        pl.get(l).getCover(), pl.get(l).getQuantity());
                                if (check == false) {
                                    break;
                                }
                            }
                        }
                    }

                    //xoa san pham khoi cart
                    if (checkQuantity == true && checkBalance == true && check == true) {
                        for (int m = 0; m < pl.size(); m++) {
                            cart.remove(pl.get(m).getProductID());
                        }
                        request.setAttribute("ERRORR_CHECK_OUT", "Your Product Have Been Order!");
                        url = SUCCESS;
                    }
                    //kiem tra neu k con san pham trong cart thi xoa cart
                    if (cart.getCart().isEmpty()) {
                        cart = null;
                    }
                    session.setAttribute("CART", cart);
                }
            } else {
                request.setAttribute("ERRORR_CHECK_OUT", "You Can't Check Out With Empty Product");
            }
        } catch (NumberFormatException | SQLException e) {
            log("Error at CheckOutController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
