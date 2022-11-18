/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

/**
 *
 * @author lequa
 */
public class WishList {

    private int wishID;
    private String cusID;
    private String productID;
    private String cateID;
    private String sellerID;
    private String productName;
    private int quantity;
    private String cover;
    private float price;
    private String description;

    public WishList() {
    }

    public WishList(int wishID, String cusID, String productID, String cateID, String sellerID, String productName, int quantity, String cover, float price, String description) {
        this.wishID = wishID;
        this.cusID = cusID;
        this.productID = productID;
        this.cateID = cateID;
        this.sellerID = sellerID;
        this.productName = productName;
        this.quantity = quantity;
        this.cover = cover;
        this.price = price;
        this.description = description;
    }

    public int getWishID() {
        return wishID;
    }

    public void setWishID(int wishID) {
        this.wishID = wishID;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getCateID() {
        return cateID;
    }

    public void setCateID(String cateID) {
        this.cateID = cateID;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
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

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
