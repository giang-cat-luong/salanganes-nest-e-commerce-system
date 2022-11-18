/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cartController;

import cart.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import others.OrderDTO;
import others.OrderDetailDTO;
import seller.dto.Seller;

/**
 *
 * @author lequa
 */
@WebServlet(name = "ShowHistoryCheckOutController", urlPatterns = {"/ShowHistoryCheckOutController"})
public class ShowHistoryCheckOutController extends HttpServlet {
    
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "myPurchase.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String cusID = request.getParameter("cusID");
            ArrayList<OrderDTO> orl = CartDAO.getOrderByCusID(cusID);
            ArrayList<OrderDetailDTO> tmpOrdl = new ArrayList<>();
            ArrayList<OrderDetailDTO> ordl = new ArrayList<>();
            OrderDetailDTO ord = null;
            for (int i = 0; i < orl.size(); i++) {
                tmpOrdl = CartDAO.getOrderDetailByOrderID(orl.get(i).getOrderID());
                for (int j = 0; j < tmpOrdl.size(); j++) {
                    ord = new OrderDetailDTO(tmpOrdl.get(j).getOrderDetailID(), tmpOrdl.get(j).getOrderID(), tmpOrdl.get(j).getSellerID(),
                            tmpOrdl.get(j).getProductID(), tmpOrdl.get(j).getProductName(), tmpOrdl.get(j).getImg(), tmpOrdl.get(j).getQuantity(),
                            tmpOrdl.get(j).getStatus(), 0);
                    ordl.add(ord);
                }
            }
            Seller sel = null;
            float price = 0;
            for (int k = 0; k < ordl.size(); k++) {
                sel = CartDAO.getSellerById(ordl.get(k).getSellerID());
                ordl.get(k).setSellerID(sel.getName());
                price = CartDAO.getPriceByProductID(ordl.get(k).getProductID());
                ordl.get(k).setPrice(price);
            }
            request.setAttribute("ORL", orl);
            request.setAttribute("ORDL", ordl);
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at ShowHistoryCheckOutController: " + e.toString());
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