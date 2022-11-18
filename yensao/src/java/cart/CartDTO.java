/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cart;

/**
 *
 * @author lequa
 */
public class CartDTO{

    private String productID;
    private String sellerID;
    private String cover;
    private String name;
    private String cateName;
    private int quantity;
    private String description;
    private float price;

    public CartDTO() {
    }

    public CartDTO(String productID, String sellerID, String cover, String name, String cateName, int quantity, String description, float price) {
        this.productID = productID;
        this.sellerID = sellerID;
        this.cover = cover;
        this.name = name;
        this.cateName = cateName;
        this.quantity = quantity;
        this.description = description;
        this.price = price;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

  
}
