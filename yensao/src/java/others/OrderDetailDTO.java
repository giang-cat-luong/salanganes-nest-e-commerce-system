/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

/**
 *
 * @author lequa
 */
public class OrderDetailDTO {

    private String orderDetailID;
    private int orderID;
    private String sellerID;
    private String productID;
    private String productName;
    private String img;
    private int quantity;
    private int status;
    private String voucherID;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String orderDetailID, int orderID, String sellerID, String productID,
            String productName, String img, int quantity, int status, String voucherID) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.sellerID = sellerID;
        this.productID = productID;
        this.productName = productName;
        this.img = img;
        this.quantity = quantity;
        this.status = status;
        this.voucherID = voucherID;
    }

    public String getOrderDetailID() {
        return orderDetailID;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public void setOrderDetailID(String orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
    }

}
