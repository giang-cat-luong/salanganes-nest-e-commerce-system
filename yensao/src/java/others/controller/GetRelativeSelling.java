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
import others.VoucherSeller;
import seller.dto.Seller;

/**
 *
 * @author lequa
 */
@WebServlet(name = "GetRelativeSelling", urlPatterns = {"/GetRelativeSelling"})
public class GetRelativeSelling extends HttpServlet {

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productID = request.getParameter("productID");
            double sumRate = OtherDAO.getSumRateProduct(productID);
            Seller sel = OtherDAO.getSellerByProductID(productID);
            ArrayList<CommentDTO> cmt = OtherDAO.getCommentByProductID(productID);
            if (sumRate != 0) {
                if (sumRate > 0 || sumRate < 1.9) {
                    sumRate = 1;
                } else if (sumRate > 1.5 || sumRate < 2.49) {
                    sumRate = 2;
                } else if (sumRate > 2.5 || sumRate < 3.49) {
                    sumRate = 3;
                } else if (sumRate > 3.5 || sumRate < 4.49) {
                    sumRate = 4;
                } else if (sumRate > 4.5) {
                    sumRate = 5;
                }
                request.setAttribute("SUM_RATE", sumRate);
            }

            if (sel != null) {
                request.setAttribute("SELLER_PRODUCT", sel);
                ArrayList<VoucherSeller> vou = OtherDAO.getVoucherList(productID, sel.getId());
                request.setAttribute("VOUCHER_SELLER", vou);
            }

            if (cmt != null) {
                ArrayList<CommentDTO> oneStar = new ArrayList<>();
                ArrayList<CommentDTO> twoStar = new ArrayList<>();
                ArrayList<CommentDTO> threeStar = new ArrayList<>();
                ArrayList<CommentDTO> fourStar = new ArrayList<>();
                ArrayList<CommentDTO> fiveStar = new ArrayList<>();
                for (int i = 0; i < cmt.size(); i++) {
                    switch (cmt.get(i).getRate()) {
                        case 1:
                            oneStar.add(cmt.get(i));
                            break;
                        case 2:
                            twoStar.add(cmt.get(i));
                            break;
                        case 3:
                            threeStar.add(cmt.get(i));
                            break;
                        case 4:
                            fourStar.add(cmt.get(i));
                            break;
                        case 5:
                            fiveStar.add(cmt.get(i));
                            break;
                        default:
                            break;
                    }
                }
                request.setAttribute("ONE_STAR", oneStar);
                request.setAttribute("TWO_STAR", twoStar);
                request.setAttribute("THREE_STAR", threeStar);
                request.setAttribute("FOUR_STAR", fourStar);
                request.setAttribute("FIVE_STAR", fiveStar);
            }

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
