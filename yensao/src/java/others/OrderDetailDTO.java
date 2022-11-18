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
    private String orderID;
    private String sellerID;
    private String productID;
    private String productName;
    private String img;
    private int quantity;
    private int status;
    private float price;

    public OrderDetailDTO(String orderDetailID, String orderID, String sellerID, String productID, String productName, String img, int quantity, int status, float price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.sellerID = sellerID;
        this.productID = productID;
        this.productName = productName;
        this.img = img;
        this.quantity = quantity;
        this.status = status;
        this.price = price;
    }

    public OrderDetailDTO(String orderDetailID, String sellerID, String productID, int quantity) {
        this.orderDetailID = orderDetailID;
        this.sellerID = sellerID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String orderDetailID, String orderID, String sellerID, String productID, String productName, String img, int quantity, int status) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.sellerID = sellerID;
        this.productID = productID;
        this.productName = productName;
        this.img = img;
        this.quantity = quantity;
        this.status = status;
    }

    public String getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(String orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
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

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
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

}
