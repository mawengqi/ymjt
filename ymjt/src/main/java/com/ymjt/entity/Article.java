package com.ymjt.entity;

import java.util.Date;

/**
 * Created by wenqi on 2019/2/28
 */
public class Article {
    private String  id;
    private String title;
    private String content;
    private String image;
    private Date time;
    private String menuId;
    private Integer imageBanner;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public Integer getImageBanner() {
        return imageBanner;
    }

    public void setImageBanner(Integer imageBanner) {
        this.imageBanner = imageBanner;
    }
}
