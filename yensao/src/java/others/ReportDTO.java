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
public class ReportDTO {
    private int reportID;
    private String cusID;
    private String productID;
    private Date  dateReport;
    private String description;
    private String img;
    private int status;

    public ReportDTO() {
    }

    public ReportDTO(int reportID, String cusID, String productID, Date dateReport, String description, String img, int status) {
        this.reportID = reportID;
        this.cusID = cusID;
        this.productID = productID;
        this.dateReport = dateReport;
        this.description = description;
        this.img = img;
        this.status = status;
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

    public Date getDateReport() {
        return dateReport;
    }

    public void setDateReport(Date dateReport) {
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
}
