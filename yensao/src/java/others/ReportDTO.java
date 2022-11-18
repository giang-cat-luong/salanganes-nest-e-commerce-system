/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author lequa
 */
public class ReportDTO {

    private int reportID;
    private String cusID;
    private String productID;
    private Timestamp dateReport;
    private String description;
    private String img;

    public ReportDTO() {
    }

    public ReportDTO(int reportID, String cusID, String productID, Timestamp dateReport, String description, String img) {
        this.reportID = reportID;
        this.cusID = cusID;
        this.productID = productID;
        this.dateReport = dateReport;
        this.description = description;
        this.img = img;
       
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
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

    public Timestamp getDateReport() {
        return dateReport;
    }

    public void setDateReport(Timestamp dateReport) {
        this.dateReport = dateReport;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

 

}
