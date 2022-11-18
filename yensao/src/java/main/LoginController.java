/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import customer.dto.Customer;
import customer.dto.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import others.SellerInforRelative;
import seller.dto.Seller;
import seller.dto.SellerDAO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private final String ERROR = "login.jsp";
    private final String SUCCESSUS = "customerPage.jsp";
    private final String SUCCESSSE = "sellerPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            CustomerDAO cdao = new CustomerDAO();
            Customer cus = cdao.checkLoginUS(name, password);
            Seller sell = cdao.checkLoginSE(name, password);
            HttpSession session = request.getSession();
            if (cus != null) {
                if (cus.getRole().equalsIgnoreCase("ERROR")) {
                    request.setAttribute("ERROR_ROLE", "Welcome Join In First Time!");
                } else if (!cus.getRole().equalsIgnoreCase("US")) {
                    request.setAttribute("ERROR_ROLE", "Soory Your Role Is Not Valid!");
                } else {
                    session.setAttribute("CUSTOMER_LOGIN", cus);
                    url = SUCCESSUS;
                }
            } else if (sell != null) {
                if (!sell.getRole().equalsIgnoreCase("SE")) {
                    request.setAttribute("ERROR_ROLE", "Soory Your Role Is Not Valid!");
                } else {
                    if (sell.getStatus() == 2) {
                        request.setAttribute("ERROR_BAN", "Your account is banned!");
                        url = ERROR;
                    } else {
                        session.setAttribute("SELLER_LOGIN", sell);
                        SellerInforRelative sir = SellerDAO.getSellerInfor(sell.getId());
                        session.setAttribute("SELLER_INFOR_RELATIVE", sir);
                        url = SUCCESSSE;
                    }
                }
            } else {
                request.setAttribute("ERROR_LOGIN", "Incorrect Name Or Password!");
            }

        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
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
