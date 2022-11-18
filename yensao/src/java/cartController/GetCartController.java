package cartController;

import cart.Cart;
import cart.CartDAO;
import cart.CartDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import others.Voucher;
import seller.dto.Seller;

/**
 *
 * @author lequa
 */
@WebServlet(name = "GetCartController", urlPatterns = {"/GetCartController"})
public class GetCartController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String cusID = request.getParameter("cusID");
            if (session != null) {
                Cart cart = (Cart) session.getAttribute("CART");
                ArrayList<String> tmpSellerIdList = new ArrayList<>();
                ArrayList<String> sellerIdList = new ArrayList<>();
                ArrayList<Seller> sellerList = new ArrayList<>();
                Seller tmpSeller = null;
                Seller seller = null;
                String tmpSellerID = null;
                boolean check = true;
                for (CartDTO c : cart.getCart().values()) {
                    tmpSellerIdList.add(c.getSellerID());
                }

                tmpSellerID = tmpSellerIdList.get(0);
                sellerIdList.add(tmpSellerID);

                for (int i = 1; i < tmpSellerIdList.size(); i++) {
                    for (int j = 0; j < sellerIdList.size(); j++) {
                        if (sellerIdList.get(j).equalsIgnoreCase(tmpSellerIdList.get(i))) {
                            check = false;
                        }
                    }
                    if (check == true) {
                        sellerIdList.add(tmpSellerIdList.get(i));
                    }
                }

                for (int k = 0; k < sellerIdList.size(); k++) {
                    tmpSeller = CartDAO.getSellerById(sellerIdList.get(k));
                    seller = new Seller(sellerIdList.get(k), tmpSeller.getName(), tmpSeller.getAvatar());
                    sellerList.add(seller);
                }

                float cumulative = CartDAO.getCumulative(cusID);
                ArrayList<Voucher> vl = CartDAO.getVoucherCustomer(cusID);
                request.setAttribute("SELLER_LIST", sellerList);
                request.setAttribute("CUMULATIVE", cumulative);
                request.setAttribute("VOUCHER_LIST", vl);
                url = SUCCESS;
            }
        } catch (SQLException e) {
            log("Error at GetCartController: " + e.toString());
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
