/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

import java.sql.Date;

/**
 *
 * @author lequa
 */
public class OrderDTO {
    private String orderID;
    private String cusID;
    private String cusName;
    private String cusPhone;
    private String loc;
    private Date   ordDate;
    private int    status;
    private int voucherID;
    private float  cumulativeUse;
    private float  cumulativeEarn;
    private float  total;

    public OrderDTO(String orderID, String cusName, int status) {
        this.orderID = orderID;
        this.cusName = cusName;
        this.status = status;
    }

    public OrderDTO() {
    }

    public OrderDTO(String orderID, String cusID, String cusName, String cusPhone, String loc, Date ordDate, int status, int voucherID, float cumulativeUse, float cumulativeEarn, float total) {
        this.orderID = orderID;
        this.cusID = cusID;
        this.cusName = cusName;
        this.cusPhone = cusPhone;
        this.loc = loc;
        this.ordDate = ordDate;
        this.status = status;
        this.voucherID = voucherID;
        this.cumulativeUse = cumulativeUse;
        this.cumulativeEarn = cumulativeEarn;
        this.total = total;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getCusPhone() {
        return cusPhone;
    }

    public void setCusPhone(String cusPhone) {
        this.cusPhone = cusPhone;
    }

    public String getLoc() {
        return loc;
    }

    public void setLoc(String loc) {
        this.loc = loc;
    }

    public Date getOrdDate() {
        return ordDate;
    }

    public void setOrdDate(Date ordDate) {
        this.ordDate = ordDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public float getCumulativeUse() {
        return cumulativeUse;
    }

    public void setCumulativeUse(float cumulativeUse) {
        this.cumulativeUse = cumulativeUse;
    }

    public float getCumulativeEarn() {
        return cumulativeEarn;
    }

    public void setCumulativeEarn(float cumulativeEarn) {
        this.cumulativeEarn = cumulativeEarn;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }
   
    
}
