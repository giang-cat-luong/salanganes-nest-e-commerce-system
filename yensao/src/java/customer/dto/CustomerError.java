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
public class CustomerError {

    private String id;
    private String name;
    private String password;
    private String email;
    private String avatar;
    private int phone;
    private String role;
    private String gender;
    private String location;
    private float cumulative;

    public CustomerError() {

    }

    public CustomerError(String id, String name, String password, String email, String avatar, int phone, String role, String gender, String location, float cumulative) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.phone = phone;
        this.role = role;
        this.gender = gender;
        this.location = location;
        this.cumulative = 0;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public float getCumulative() {
        return cumulative;
    }

    public void setCumulative(float cumulative) {
        this.cumulative = cumulative;
    }

}
