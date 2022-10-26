/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package google;

import customer.dto.Customer;
import customer.dto.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import seller.dto.Seller;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GoogleController", urlPatterns = {"/GoogleController"})
public class GoogleController extends HttpServlet {

     private static final String ERROR = "error.jsp";
    private static final String SUCCESSUS = "customerPage.jsp";
    private static final String SUCCESSSE = "sellerPage.jsp";


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String code = request.getParameter("code");
            CustomerDAO cdao = new CustomerDAO();
            List<Customer> CustomerList = cdao.getAllCus();
            List<Seller> SellerList = cdao.getAllSell();
            Customer customer = new Customer();
            Seller seller = new Seller();
            if (!code.isEmpty()) {
                HttpSession session = request.getSession();
                int flag = 0;
                String accessToken = GoogleAPI.getToken(code);
                GoogleDTO user = GoogleAPI.getUserInfo(accessToken);
                for (Customer cus : CustomerList) {
                    if (cus.getEmail().equalsIgnoreCase(user.getEmail())) {
                        customer = cdao.getCusByID(cus.getId());
                        flag = 1;
                        break;
                    }
                }
                for (Seller sel : SellerList) {
                    if (sel.getEmail().equalsIgnoreCase(user.getEmail())) {
                        seller = cdao.getSellByID(sel.getId());
                        flag = 2;
                        break;
                    }
                }
                switch (flag) {
                    case 1:
                        session.setAttribute("GOOGLE_LOGIN", customer);
                        url = SUCCESSUS;
                        break;
                    case 2:
                        session.setAttribute("GOOGLE_LOGIN", seller);
                        url = SUCCESSSE;
                        break;
                    case 0:
                        boolean check = cdao.insertGoogleUser(user);
                        if (check == true) {
                            session.setAttribute("GOOGLE_REGISTER", user);
                            url = SUCCESSUS;
                        } else {
                            url = ERROR;
                        }   break;
                    default:
                        break;
                }
            }
        } catch (IOException | SQLException e) {
            log("Error at LoginGoogleController: " + e.toString());
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
