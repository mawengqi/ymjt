package com.ymjt.entity;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
public class Model {
    private String id;
    private String name;
    List<Menu> menuList;

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

    public List<Menu> getMenuList() {
        return menuList;
    }

    public void setMenuList(List<Menu> menuList) {
        this.menuList = menuList;
    }
}
