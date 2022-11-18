/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

/**
 *
 * @author lequa
 */
public class SellerInforRelative {
    private int totalProduct;
    private int totalSold;
    private float totalFrofit;
    private double averageRate;
    private int totalComment;

    public SellerInforRelative() {
    }

    public SellerInforRelative(int totalProduct, int totalSold, float totalFrofit, double averageRate, int totalComment) {
        this.totalProduct = totalProduct;
        this.totalSold = totalSold;
        this.totalFrofit = totalFrofit;
        this.averageRate = averageRate;
        this.totalComment = totalComment;
    }

    public int getTotalProduct() {
        return totalProduct;
    }

    public void setTotalProduct(int totalProduct) {
        this.totalProduct = totalProduct;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public float getTotalFrofit() {
        return totalFrofit;
    }

    public void setTotalFrofit(float totalFrofit) {
        this.totalFrofit = totalFrofit;
    }

    public double getAverageRate() {
        return averageRate;
    }

    public void setAverageRate(double averageRate) {
        this.averageRate = averageRate;
    }

    public int getTotalComment() {
        return totalComment;
    }

    public void setTotalComment(int totalComment) {
        this.totalComment = totalComment;
    }
    
    
}
