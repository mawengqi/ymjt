package com.ymjt.entity;

import java.util.Date;

/**
 * Created by wenqi on 2019/2/28
 */
public class News {
    private Integer id;
    private String title;
    private String content;
    private String images;
    private Date time;
    private Integer columnsId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getColumnsId() {
        return columnsId;
    }

    public void setColumnsId(Integer columnsId) {
        this.columnsId = columnsId;
    }
}
