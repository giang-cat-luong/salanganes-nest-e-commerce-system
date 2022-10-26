/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package customer.dto;

/**
 *
 * @author lequa
 */
public class Customer {
    private String id;
    private String name;
    private String password;
    private String email;
    private String avatar;
    private String phone;
    private String role;
    private String gender;
    private String location;
    private float cumulative;
     private float balance;
    
    public Customer(){
        
    }

    public Customer(String id, String name, String password, String email, String avatar, String phone, String role, String gender, String location, float cumulative, 
            float balance) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.phone = phone;
        this.role = role;
        this.gender = gender;
        this.location = location;
        this.cumulative = cumulative;
        this.balance = balance;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
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

    public float getCumulative() {
        return cumulative;
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

    public void setCumulative(float cumulative) {
        this.cumulative = cumulative;
    }

    @Override
    public String toString() {
        return "Customer{" + "id=" + id + ", name=" + name + ", password=" + password + ", email=" + email + ", avatar=" + avatar + ", phone=" + phone + ", role=" + role + ", gender=" + gender + ", location=" + location + ", cumulative=" + cumulative + '}';
    }
}
