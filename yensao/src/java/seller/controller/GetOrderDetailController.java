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
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import others.OrderDTO;
import others.OrderDetailDTO;
import seller.dto.SellerDAO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "GetOrderDetailController", urlPatterns = {"/GetOrderDetailController"})
public class GetOrderDetailController extends HttpServlet {

    private static final String ERROR = "showOrderDetail.jsp";
    private static final String SUCCESS = "showOrderDetail.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String sellerID = request.getParameter("sellerID");
            ArrayList<OrderDetailDTO> ordl = SellerDAO.getOrderDetailList(sellerID);
            ArrayList<String> tmpOrIdList = new ArrayList<>();
            ArrayList<String> orIdList = new ArrayList<>();
            ArrayList<OrderDTO> orl = new ArrayList<>();
            OrderDTO or = null;
            String tmpOrId = "";
            if (ordl != null) {
                for (int i = 0; i < ordl.size(); i++) {
                    tmpOrIdList.add(ordl.get(i).getOrderID());
                }
                tmpOrId = tmpOrIdList.get(0);
                orIdList.add(tmpOrId);

                for (int j = 1; j < tmpOrIdList.size(); j++) {
                    for (int k = 0; k < orIdList.size(); k++) {
                        if (!orIdList.get(k).equalsIgnoreCase(tmpOrIdList.get(j))) {
                            orIdList.add(tmpOrIdList.get(j));
                        }
                    }
                }
                for (int m = 0; m < orIdList.size(); m++) {
                    or = CartDAO.getOrderByOrderID(orIdList.get(m));
                    orl.add(or);
                }
                for (int t = 0; t < ordl.size(); t++) {
                    float price = CartDAO.getPriceByProductID(ordl.get(t).getProductID());
                    ordl.get(t).setPrice(price);
                }
                request.setAttribute("ORDER_LIST", orl);
                request.setAttribute("ORDER_DETAIL_LIST", ordl);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at GetOrderDetailController: " + e.toString());
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