/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package others;

import java.sql.Timestamp;

/**
 *
 * @author lequa
 */
public class Culmulative {

    private int saveID;
    private String cusID;
    private String infor;
    private Timestamp time;

    public Culmulative() {
    }

    public Culmulative(int saveID, String cusID, String infor, Timestamp time) {
        this.saveID = saveID;
        this.cusID = cusID;
        this.infor = infor;
        this.time = time;
    }

    public int getSaveID() {
        return saveID;
    }

    public void setSaveID(int saveID) {
        this.saveID = saveID;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public String getInfor() {
        return infor;
    }

    public void setInfor(String infor) {
        this.infor = infor;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

}
