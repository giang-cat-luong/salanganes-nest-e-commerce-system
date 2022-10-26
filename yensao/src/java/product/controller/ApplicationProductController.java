/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.dto.ProductDAO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "ApplicationProductController", urlPatterns = {"/ApplicationProductController"})
public class ApplicationProductController extends HttpServlet {

    private static final String SUCCESS = "newProduct.jsp";

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productID = request.getParameter("ProductID");
            String cateID = request.getParameter("Category");
            String sellerID = request.getParameter("sellerID");
            String productName = request.getParameter("ProductName");
            int quantity = Integer.parseInt(request.getParameter("Quantity"));
            String cover = request.getParameter("Cover");
            float price = Float.parseFloat(request.getParameter("Price"));
            String description = request.getParameter("Description");
            boolean insert = ProductDAO.insertProduct(productID, cateID, sellerID, productName, quantity, cover, price, description);
            if (insert == true) {
                request.setAttribute("SEND_SUCCESS", "Sent request successfully");
                url = SUCCESS;
            } else {
                url = ERROR;
            }
        } catch (Exception e) {
            log("Error at ApplicationProductController: " + e.toString());
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
