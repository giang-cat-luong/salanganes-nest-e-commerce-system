/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cartController;

import cart.Cart;
import cart.CartDAO;
import cart.CartDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import product.dto.Product;

/**
 *
 * @author Truong Giang
 */
@WebServlet(name = "StepOneCheckOutController", urlPatterns = {"/StepOneCheckOutController"})
public class StepOneCheckOutController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "checkout.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String[] productID = request.getParameterValues("yes");
            if (productID != null) {
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
                    float total = 0;
                    for (int k = 0; k < pl.size(); k++) {
                        total += pl.get(k).getPrice() * pl.get(k).getQuantity();
                    }

                    request.setAttribute("TOTAL", total);
                    request.setAttribute("VOUCHER_ID", voucherID);
                    request.setAttribute("CUMULATIVE", cumulativeUse);
                    request.setAttribute("PRODUCT_ID_LIST", productID);
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            log("Error at StepOneCheckOutController: " + e.toString());
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(StepOneCheckOutController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(StepOneCheckOutController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
