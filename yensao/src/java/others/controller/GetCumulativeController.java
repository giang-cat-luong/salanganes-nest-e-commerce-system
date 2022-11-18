/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package others.controller;

import customer.dto.Customer;
import customer.dto.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import others.Culmulative;
import others.OtherDAO;

/**
 *
 * @author lequa
 */
@WebServlet(name = "GetCumulativeController", urlPatterns = {"/GetCumulativeController"})
public class GetCumulativeController extends HttpServlet {

    public static final String SUCCESS = "cumulative.jsp";
    public static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String cusID = request.getParameter("cusID");
            CustomerDAO cdao = new CustomerDAO();
            Customer cus = cdao.getCusByID(cusID);
            ArrayList<Culmulative> cuList = OtherDAO.getCumulative(cusID);
            if (cuList != null) {
                session.setAttribute("TOTAL_CUMULATIVE", cus.getCumulative());
                request.setAttribute("CUMULATIVE", cuList);
                url = SUCCESS;
            } else {
                session.setAttribute("TOTAL_CUMULATIVE", cus.getCumulative());
                request.setAttribute("CUMULATIVE", "Not Have Yet");
                url = SUCCESS;
            }
        } catch (Exception e) {
            System.out.println("Error at GetCumulativeController: " + e.toString());
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
            Logger.getLogger(GetCumulativeController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GetCumulativeController.class.getName()).log(Level.SEVERE, null, ex);
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
