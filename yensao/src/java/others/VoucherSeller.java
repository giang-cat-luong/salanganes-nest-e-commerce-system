/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

/**
 *
 * @author lequa
 */
public class VoucherSeller {
    private String voucherID;
    private String name;
    private String codeID;
    private String sellerID;
    private float priceAffect;

    public VoucherSeller() {
    }

    public VoucherSeller(String voucherID, String name, String codeID, String sellerID, float priceAffect) {
        this.voucherID = voucherID;
        this.name = name;
        this.codeID = codeID;
        this.sellerID = sellerID;
        this.priceAffect = priceAffect;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCodeID() {
        return codeID;
    }

    public void setCodeID(String codeID) {
        this.codeID = codeID;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
    }

    public float getPriceAffect() {
        return priceAffect;
    }

    public void setPriceAffect(float priceAffect) {
        this.priceAffect = priceAffect;
    }
    
    
}
