/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package seller.controller;

import cart.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import others.OrderDetailDTO;
import seller.dto.SellerDAO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "UpdateOrderDetailController", urlPatterns = {"/UpdateOrderDetailController"})
public class UpdateOrderDetailController extends HttpServlet {

    private static final String ERROR = "MainController?action=ShowOrders";
    private static final String SUCCESS = "MainController?action=ShowOrders";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String orderID = request.getParameter("orderID");
            String sellerID = request.getParameter("sellerID");
            ArrayList<OrderDetailDTO> ordl = CartDAO.updateAndGetOrderDetail(orderID);
            ArrayList<String> sellerIdList = new ArrayList<>();
            boolean check = true;
            int count = 1, allCount = 0;
            float cumulativeUse = 0;
            sellerIdList.add(ordl.get(0).getSellerID());
            for (int i = 1; i < ordl.size(); i++) {
                for (int j = 0; j < sellerIdList.size(); j++) {
                    if (!sellerIdList.get(j).equalsIgnoreCase(ordl.get(i).getSellerID())) {
                        count++;
                    }
                }
            }
            for (int u = 0; u < ordl.size(); u++) {
                if (ordl.get(u).getSellerID().equalsIgnoreCase(sellerID)) {
                    allCount++;
                }
            }
            float tmpCumulativeUse = CartDAO.getCumulativeUseByOrderID(orderID);
            if (tmpCumulativeUse != 0) {
                cumulativeUse = (tmpCumulativeUse / count) / allCount;
            }
            for (int k = 0; k < ordl.size(); k++) {
                if (ordl.get(k).getSellerID().equalsIgnoreCase(sellerID)) {
                    check = CartDAO.tranferProfit(ordl.get(k).getOrderDetailID(),
                            sellerID, ordl.get(k).getProductID(),
                            ordl.get(k).getQuantity(), orderID, cumulativeUse);
                }
                if (check == false) {
                    break;
                }
            }
            if (check == true) {
                request.setAttribute("DELEVERI_SUCCESS", "You Product Have Deleveri");
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at UpdateOrderDetailController: " + e.toString());
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
