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

    private static final String UPDATE_CUSTOMER = "SaveChanges";
    private static final String UPDATE_CUSTOMER_CONTROLLER = "UpdateCustomerController";

    private static final String CHANGE_PASSWORD = "UpdatePassword";
    private static final String CHANGE_PASSWORD_CONTROLLER = "ChangePasswordController";

    private static final String GET_WISH_LIST = "WishList";
    private static final String GET_WISH_LIST_CONTROLLER = "GetWishListController";

    private static final String ADD_WISH_LIST = "AddWishList";
    private static final String ADD_WISH_LIST_CONTROLLER = "AddWishListController";

    private static final String REMOVE_WISH_LIST = "RemoveWishList";
    private static final String REMOVE_WISH_LIST_CONTROLLER = "RemoveProductWishListController";

    private static final String SINGLE_PRODUCT = "SingleProduct";
    private static final String GET_RELATIVE = "GetRelativeSelling";

    private static final String CUMULATIVE = "Cumulative";
    private static final String GET_CUMULATIVE = "GetCumulativeController";

    private static final String GETPROBYID = "GetProById";
    private static final String GET_PRODUCT_BY_ID_CONTROLLER = "GetProductById";

    private static final String SHOPPING = "Shopping";
    private static final String GET_ALL_PRODUCT_CONTROLLER = "GetAllProductController";

    private static final String ADD_REQUEST = "AddRequest";
    private static final String ADD_REQUEST_CONTROLLER = "AddRequestController";

    private static final String ADD_TO_CART = "AddToCart";
    private static final String ADD_CART_CONTROLLER = "AddCartController";

    private static final String VIEW_CART = "ViewCart";
    private static final String GET_CART_CONTROLLER = "GetCartController";

    private static final String REMOVE_CART = "RemoveCart";
    private static final String REMOVE_CART_CONTROLLER = "RemoveCartController";

    private static final String CHECK_OUT = "CheckOut";
    private static final String CHECK_OUT_CONTROLLER = "CheckOutController";

    private static final String STEP_ONE_CHECK_OUT = "Step1CheckOut";
    private static final String STEP_ONE_CHECK_OUT_CONTROLLER = "StepOneCheckOutController";

    private static final String VIEW_PURCHASE = "ViewPurchase";
    private static final String SHOW_HISTORY_CHECK_OUT_CONTROLLER = "ShowHistoryCheckOutController";

    private static final String COMMENT_PRODUCT = "CommentProduct";
    private static final String COMMENT_PRODUCT_CONTROLLER = "CommentProductController";

    private static final String CANCEL_ORDER = "CancelOrder";
    private static final String CANCEL_CHECK_OUT_CONTROLLER = "CancelCheckOutController";

    private static final String REPORT_PRODUCT = "ReportProduct";
    private static final String ADD_REPORT_CONTROLLER = "AddReportController";

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
                    case CHANGE_PASSWORD:
                        url = CHANGE_PASSWORD_CONTROLLER;
                        break;
                    case UPDATE_CUSTOMER:
                        url = UPDATE_CUSTOMER_CONTROLLER;
                        break;
                    case GET_WISH_LIST:
                        url = GET_WISH_LIST_CONTROLLER;
                        break;
                    case ADD_WISH_LIST:
                        url = ADD_WISH_LIST_CONTROLLER;
                        break;
                    case REMOVE_WISH_LIST:
                        url = REMOVE_WISH_LIST_CONTROLLER;
                        break;
                    case SINGLE_PRODUCT:
                        url = GET_RELATIVE;
                        break;
                    case CUMULATIVE:
                        url = GET_CUMULATIVE;
                        break;
                    case GETPROBYID:
                        url = GET_PRODUCT_BY_ID_CONTROLLER;
                        break;
                    case SHOPPING:
                        url = GET_ALL_PRODUCT_CONTROLLER;
                        break;
                    case ADD_REQUEST:
                        url = ADD_REQUEST_CONTROLLER;
                        break;
                    case ADD_TO_CART:
                        url = ADD_CART_CONTROLLER;
                        break;
                    case VIEW_CART:
                        url = GET_CART_CONTROLLER;
                        break;
                    case REMOVE_CART:
                        url = REMOVE_CART_CONTROLLER;
                        break;
                    case CHECK_OUT:
                        url = CHECK_OUT_CONTROLLER;
                        break;
                    case VIEW_PURCHASE:
                        url = SHOW_HISTORY_CHECK_OUT_CONTROLLER;
                        break;
                    case COMMENT_PRODUCT:
                        url = COMMENT_PRODUCT_CONTROLLER;
                        break;
                    case CANCEL_ORDER:
                        url = CANCEL_CHECK_OUT_CONTROLLER;
                        break;
                    case STEP_ONE_CHECK_OUT:
                        url = STEP_ONE_CHECK_OUT_CONTROLLER;
                        break;
                    case REPORT_PRODUCT:
                        url = REMOVE_PRODUCT_CONTROLLER;
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
