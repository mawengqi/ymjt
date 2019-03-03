package com.ymjt.entity;

import java.util.List;
import java.util.Set;

/**
 * Created by wenqi on 2019/2/28
 */
public class Model {
    private String id;
    private String name;
    Set<Menu> menuList;

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

    public Set<Menu> getMenuList() {
        return menuList;
    }

    public void setMenuList(Set<Menu> menuList) {
        this.menuList = menuList;
    }
}
