/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import customer.dto.Customer;
import customer.dto.CustomerDAO;
import customer.dto.CustomerError;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author lequa
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "customerPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean check = false;
            CustomerDAO cdao = new CustomerDAO();
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            HttpSession session = request.getSession();
            CustomerError cusError = new CustomerError();
            int checkVadiation = 0;
            if (name.length() > 20) {
                cusError.setName("No more than 10 character");
                checkVadiation++;
            }
            if (password.length() > 20) {
                cusError.setPassword("No more than 10 character");
                checkVadiation++;
            }
            if (!password.equalsIgnoreCase(confirm)) {
                cusError.setEmail("Password Not Same!");
                checkVadiation++;
            }
            if (checkVadiation == 0) {
                name.replaceAll(" ", "");
                password.replaceAll(" ", "");
                check = cdao.registerCustomer(name, password, email, gender);
                if (check == true) {
                    Customer cus = cdao.checkLoginUS(name, password);
                    session.setAttribute("CUSTOMER_REGISTER", cus);
                    url = SUCCESS;
                }
            }
            session.setAttribute("CUS_ERROR", cusError);
        } catch (Exception e) {
            log("Error at createPdController: " + e.toString());
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
