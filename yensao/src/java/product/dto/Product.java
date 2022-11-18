/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product.dto;

/**
 *
 * @author lequa
 */
public class Product {

    private String productID;
    private String cateID;
    private String sellerID;
    private String productName;
    private String cateName;
    private int quantity;
    private String cover;
    private float price;
    private String description;
    private int sumSold;
    private int status;

    public Product() {
    }

    public Product(String productID, String sellerID, String productName, String cateName, int quantity, String cover, float price, String description) {
        this.productID = productID;
        this.sellerID = sellerID;
        this.productName = productName;
        this.cateName = cateName;
        this.quantity = quantity;
        this.cover = cover;
        this.price = price;
        this.description = description;
    }

    
    public Product(String productID, String cateID, String sellerID, String productName, String cateName, int quantity, String cover, float price, String description, int sumSold, int status) {
        this.productID = productID;
        this.cateID = cateID;
        this.sellerID = sellerID;
        this.productName = productName;
        this.cateName = cateName;
        this.quantity = quantity;
        this.cover = cover;
        this.price = price;
        this.description = description;
        this.sumSold = sumSold;
        this.status = status;
    }

    public int getSumSold() {
        return sumSold;
    }

    public void setSumSold(int sumSold) {
        this.sumSold = sumSold;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
