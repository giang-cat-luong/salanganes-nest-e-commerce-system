/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manager.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import manager.dto.ManagerDAO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "AddUserController", urlPatterns = {"/AddUserController"})
public class AddUserController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "MainController?action=Show";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean vadiation = true;
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String avatar = request.getParameter("avatar");
            int phone = Integer.parseInt(request.getParameter("phone"));
            String role = request.getParameter("role");
            String gender = request.getParameter("gender");
            String loc = request.getParameter("loc");

            HttpSession session = request.getSession();
            ManagerDAO mdao = new ManagerDAO();

            if (name.length() > 20) {
                session.setAttribute("ERROR_CREATE", "Only 10 Character");
                vadiation = false;
            }
            if (password.length() > 20) {
                session.setAttribute("ERROR_CREATE", "Only 10 Character");
                vadiation = false;
            }
            if (vadiation == true) {
                boolean result = mdao.addNewUser(name.replaceAll(" ", ""), password.replaceAll(" ", ""), email,
                        avatar, phone, role, gender, loc);
                if (result == true) {
                    session.setAttribute("INSERT_SUCCESS", "New User Added");
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            log("Error at AddUserController: " + e.toString());
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
