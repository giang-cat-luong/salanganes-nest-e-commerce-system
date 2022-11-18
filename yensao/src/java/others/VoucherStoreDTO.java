/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

/**
 *
 * @author lequa
 */
public class VoucherStoreDTO {
    private int voucherID;
    private String name;
    private String codeID;
    private float tradingPoint;

    public VoucherStoreDTO() {
    }

    public VoucherStoreDTO(int voucherID, String name, String codeID, float tradingPoint) {
        this.voucherID = voucherID;
        this.name = name;
        this.codeID = codeID;
        this.tradingPoint = tradingPoint;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
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

    public float getTradingPoint() {
        return tradingPoint;
    }

    public void setTradingPoint(float tradingPoint) {
        this.tradingPoint = tradingPoint;
    }
    
    
}
