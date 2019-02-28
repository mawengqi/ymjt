package com.ymjt.service;

import com.ymjt.entity.Menu;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
public interface MenuService {
    public Menu addMenu(Menu menu) throws Exception;
    public void deleteMenu(Menu menu) throws Exception;
    public void updateMenu(Menu menu) throws Exception;
    public List<Menu> findMenus(Menu menu, Integer start, Integer max) throws Exception;
}
