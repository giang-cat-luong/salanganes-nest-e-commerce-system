/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package seller.dto;

/**
 *
 * @author lequa
 */
public class Seller {

    private String id;
    private String name;
    private String password;
    private String email;
    private String avatar;
    private String phone;
    private String role;
    private String gender;
    private String location;
    private float profit;
    private int status;

    public Seller() {

    }

    public Seller(String id, String name, String avatar) {
        this.id = id;
        this.name = name;
        this.avatar = avatar;
    }

    public Seller(String id, String name, String password, String email, String avatar, String phone, String role, String gender,
            String location, float profit, int status) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.phone = phone;
        this.role = role;
        this.gender = gender;
        this.location = location;
        this.profit = profit;
        this.status = status;

    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getAvatar() {
        return avatar;
    }

    public String getRole() {
        return role;
    }

    public String getGender() {
        return gender;
    }

    public String getLocation() {
        return location;
    }

    public int getStatus() {
        return status;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public float getProfit() {
        return profit;
    }

    public void setProfit(float profit) {
        this.profit = profit;
    }

    @Override
    public String toString() {
        return "Seller{" + "id=" + id + ", name=" + name + ", password=" + password + ", email=" + email + ", avatar=" + avatar + ", phone=" + phone + ", role=" + role + ", gender=" + gender + ", location=" + location + ", status=" + status + '}';
    }
}
