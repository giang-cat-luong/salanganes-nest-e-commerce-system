/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package manager.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import others.OtherDAO;
import others.RequestDTO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "AddRequestController", urlPatterns = {"/AddRequestController"})
public class AddRequestController extends HttpServlet {

    public static final String SUCCESS = "requestSeller.jsp";
    public static final String ERROR = "requestSeller.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String cusID = request.getParameter("cusID");
            String detail = request.getParameter("detail");
            String checkbox = request.getParameter("checkbox");
            if (checkbox != null) {
                RequestDTO req = new RequestDTO(0, cusID, detail, 0);
                if (OtherDAO.insertRequest(req) == true) {
                    request.setAttribute("REQUEST_INFOR", "Request Successful");
                    url = SUCCESS;
                } else {
                    request.setAttribute("REQUEST_INFOR", "You Already Have Sent A Request!");
                    url = ERROR;
                }
            } else {
                request.setAttribute("REQUEST_INFOR", "Please agree to all the terms and conditions before submitting your request");
                url = SUCCESS;
            }

        } catch (Exception e) {
            System.out.println("Error at AddRequestController: " + e.toString());
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddRequestController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddRequestController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
