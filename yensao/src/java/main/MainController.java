/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String ERROR = "error.jsp";

    private static final String LOGINGOOGLE = "LoginGoogle";
    private static final String GOOGLE_CONTROLLER = "GoogleController";

    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";

    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";

    private static final String REGISTER = "Register";
    private static final String REGISTER_CONTROLLER = "RegisterController";

    private static final String ADD = "Add";
    private static final String ADDUSER_CONTROLLER = "AddUserController";

    private static final String BAN = "Ban";
    private static final String BANSELLER_CONTROLLER = "BanSellerController";

    private static final String REQUEST = "Request";
    private static final String GETLISTREQUEST_CONTROLLER = "GetListRequestController";

    private static final String CHECK = "Check";
    private static final String GETPRODUCTLIST_CONTROLLER = "GetProductListController";

    private static final String ADDPRODUCT = "AddProduct";
    private static final String ADDPRODUCT_CONTROLLER = "AddNewProductController";

    private static final String REFUSE = "Refuse";
    private static final String DELETEPRODUCT_CONTROLLER = "DeleteProductController";

    private static final String HIGH = "High";
    private static final String GETHIGHTPRODUCT_CONTROLLER = "GetHighProductController";

    private static final String SHOW = "Show";
    private static final String GETSELLERLIST_CONTROLLER = "GetSellerListController";

    private static final String REPORT = "Report";
    private static final String GETREPORT_CONTROLLER = "GetReportController";

    private static final String APPROVALREQUEST = "ApprovalRequest";
    private static final String APPROVALREQUEST_CONTROLLER = "ApprovalRequestController";

    private static final String BLOG = "Blog";
    private static final String GETBLOGLIST_CONTROLLER = "GetBlogListController";

    private static final String PRODUCT_APPLICATION = "ProductApplication";
    private static final String GETINFORIN_PRODUCT = "GetInformationSellerController";

    private static final String REQUEST_PRODUCT = "RequestProduct";
    private static final String APPLICATION_PRODUCT_CONTROLLER = "ApplicationProductController";

    private static final String EDIT_PROFILE_SELLER = "EditProfile";
    private static final String GETINFORIN_SELLER = "GetInformationSellerController";

    private static final String FINISH_INPUT_SELLER = "Finish";
    private static final String UPDATE_SELLER_CONTROLLER = "UpdateSellerController";

    private static final String REMOVE_SELLER = "Remove";
    private static final String REMOVE_SELLER_CONTROLLER = "RemoveSellerController";

    private static final String SHOW_ORDER = "ShowOrders";
    private static final String GET_ORDERDETAIL_CONTROLLER = "GetOrderDetailController";

    private static final String SELLING_PAGE = "SellingPage";
    private static final String GET_PRODUCT_SELLER_CONTROLLER = "GetProductSellerController";

    private static final String REMOVE_PRODUCT = "RemoveProduct";
    private static final String REMOVE_PRODUCT_CONTROLLER = "RemoveProductController";

    private static final String CONVERT_PRODUCT = "AddSelling";
    private static final String CONVERT_PRODUCT_CONTROLLER = "ConvertProductController";

    private static final String EDIT_PRODUCT = "EditProduct";
    private static final String UPDATE_PRODUCT_CONTROLLER = "UpdateProductController";

    private static final String DELIVERY_PRODUCT = "Delivery";
    private static final String UPDATE_ORDER_DETAIL_CONTROLLER = "UpdateOrderDetailController";

    private static final String UN_BAN = "Unban";
    private static final String UNBAN_SELLER_CONTROLLER = "UnBanSellerController";
    
    private static final String SHOPPING = "Shopping";
    private static final String GET_ALL_PRODUCT_CONTROLLER = "GetAllProductController";
    
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String tmp = request.getParameter("action");
            String action = tmp.replaceAll(" ", "");
            if (null != action) {
                switch (action) {
                    case LOGINGOOGLE:
                        url = GOOGLE_CONTROLLER;
                        break;
                    case REGISTER:
                        url = REGISTER_CONTROLLER;
                        break;
                    case ADD:
                        url = ADDUSER_CONTROLLER;
                        break;
                    case LOGIN:
                        url = LOGIN_CONTROLLER;
                        break;
                    case LOGOUT:
                        url = LOGOUT_CONTROLLER;
                        break;
                    case BAN:
                        url = BANSELLER_CONTROLLER;
                        break;
                    case REQUEST:
                        url = GETLISTREQUEST_CONTROLLER;
                        break;
                    case CHECK:
                        url = GETPRODUCTLIST_CONTROLLER;
                        break;
                    case ADDPRODUCT:
                        url = ADDPRODUCT_CONTROLLER;
                        break;
                    case REFUSE:
                        url = DELETEPRODUCT_CONTROLLER;
                        break;
                    case HIGH:
                        url = GETHIGHTPRODUCT_CONTROLLER;
                        break;
                    case SHOW:
                        url = GETSELLERLIST_CONTROLLER;
                        break;
                    case REPORT:
                        url = GETREPORT_CONTROLLER;
                        break;
                    case APPROVALREQUEST:
                        url = APPROVALREQUEST_CONTROLLER;
                        break;
                    case BLOG:
                        url = GETBLOGLIST_CONTROLLER;
                        break;
                    case PRODUCT_APPLICATION:
                        url = GETINFORIN_PRODUCT;
                        break;
                    case REQUEST_PRODUCT:
                        url = APPLICATION_PRODUCT_CONTROLLER;
                        break;
                    case EDIT_PROFILE_SELLER:
                        url = GETINFORIN_SELLER;
                        break;
                    case FINISH_INPUT_SELLER:
                        url = UPDATE_SELLER_CONTROLLER;
                        break;
                    case REMOVE_SELLER:
                        url = REMOVE_SELLER_CONTROLLER;
                        break;
                    case SHOW_ORDER:
                        url = GET_ORDERDETAIL_CONTROLLER;
                        break;
                    case SELLING_PAGE:
                        url = GET_PRODUCT_SELLER_CONTROLLER;
                        break;
                    case REMOVE_PRODUCT:
                        url = REMOVE_PRODUCT_CONTROLLER;
                        break;
                    case EDIT_PRODUCT:
                        url = UPDATE_PRODUCT_CONTROLLER;
                        break;
                    case DELIVERY_PRODUCT:
                        url = UPDATE_ORDER_DETAIL_CONTROLLER;
                        break;
                    case CONVERT_PRODUCT:
                        url = CONVERT_PRODUCT_CONTROLLER;
                        break;
                    case UN_BAN:
                        url = UNBAN_SELLER_CONTROLLER;
                        break;
                    case SHOPPING:
                        url = GET_ALL_PRODUCT_CONTROLLER;
                        break;
                    
                    default:
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
