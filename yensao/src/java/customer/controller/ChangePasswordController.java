/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package customer.controller;

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

/**
 *
 * @author lequa
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/ChangePasswordController"})
public class ChangePasswordController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "changePassword.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String cusID = request.getParameter("cusID");
            CustomerDAO cdao = new CustomerDAO();
            Customer cus = cdao.getCusByID(cusID);
            String password = request.getParameter("password");
            String oldPassword = request.getParameter("oldPassword");
            String confirm = request.getParameter("newPassword");
            if (password.equalsIgnoreCase(confirm)) {
                String oldCurrentPassword = CustomerDAO.getCurrentOldPass(cusID);
                if (oldPassword.equalsIgnoreCase(oldCurrentPassword)) {
                    boolean check = CustomerDAO.changePassword(password, cusID);
                    if (check == true) {
                        request.setAttribute("CHANGE_PASSWORD", "Change password successfull!");
                        session.setAttribute("CUSTOMER_LOGIN", cus);
                        url = SUCCESS;
                    }
                } else {
                    request.setAttribute("CHANGE_PASSWORD", "Old Passwrequest.setAttributeord Inccorrect");
                }
            } else {
                request.setAttribute("CHANGE_PASSWORD", "Incorrect Confirm");
            }

        } catch (Exception e) {
            e.printStackTrace();
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
