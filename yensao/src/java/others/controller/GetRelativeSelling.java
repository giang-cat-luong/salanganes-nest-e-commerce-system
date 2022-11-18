/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package others.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import others.CommentDTO;
import others.OtherDAO;
import others.Voucher;
import product.dto.Product;
import product.dto.ProductDAO;
import seller.dto.Seller;

/**
 *
 * @author lequa
 */
@WebServlet(name = "GetRelativeSelling", urlPatterns = {"/GetRelativeSelling"})
public class GetRelativeSelling extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "singleProduct.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productID = request.getParameter("productID");
            ProductDAO pdao = new ProductDAO();
            Product pr = pdao.getProductById2(productID);
            double sumRate = OtherDAO.getSumRateProduct(productID);
            Seller sel = OtherDAO.getSellerByProductID(pr.getSellerID());
            int rate = Integer.parseInt(request.getParameter("rate"));
            int totalSell = OtherDAO.getTotalSellProduct(productID);
            ArrayList<CommentDTO> cmt = OtherDAO.getCommentByProductID(productID);
            if (sumRate != 0) {
                request.setAttribute("SUM_RATE", sumRate);
            }

            if (sel != null) {
                request.setAttribute("SELLER_PRODUCT", sel);
            }

            if (cmt != null) {
                ArrayList<CommentDTO> allComment = new ArrayList<>();
                for (int i = 0; i < cmt.size(); i++) {
                    if (rate != 0) {
                        if (cmt.get(i).getRate() == rate) {
                            allComment.add(cmt.get(i));
                        }
                    } else {
                        allComment.add(cmt.get(i));
                    }
                }
                request.setAttribute("ALL_RATE", allComment);
            }
            request.setAttribute("TOTAL_SELL", totalSell);
            request.setAttribute("SINGLE_PRODUCT", pr);
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at GetRelativeSelling: " + e.toString());
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
