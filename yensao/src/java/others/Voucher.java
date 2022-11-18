/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

/**
 *
 * @author lequa
 */
public class Voucher {
    private int voucherID;
    private String name;
    private String codeID;
    private String cusID;
    private int quantity;

    public Voucher() {
    }

    public Voucher(int voucherID, String name, String codeID, String cusID, int quantity) {
        this.voucherID = voucherID;
        this.name = name;
        this.codeID = codeID;
        this.cusID = cusID;
        this.quantity = quantity;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

   
    
    
}
