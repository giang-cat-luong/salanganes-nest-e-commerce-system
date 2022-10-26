/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package others;

/**
 *
 * @author lequa
 */
public class BlogDTO {

    private String blogID;
    private String title;
    private String sumary;
    private String detail;
    private String cover;

    public BlogDTO() {
    }

    public BlogDTO(String blogID, String title, String sumary, String detail, String cover) {
        this.blogID = blogID;
        this.title = title;
        this.sumary = sumary;
        this.detail = detail;
        this.cover = cover;
    }

    public String getBlogID() {
        return blogID;
    }

    public void setBlogID(String blogID) {
        this.blogID = blogID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSumary() {
        return sumary;
    }

    public void setSumary(String sumary) {
        this.sumary = sumary;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }
}
