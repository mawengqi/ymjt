package com.ymjt.service.impl;

import com.ymjt.dao.MenueDao;
import com.ymjt.entity.Menu;
import com.ymjt.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenueDao menueDao;

    public Menu addMenu(Menu menu) throws Exception {
        menueDao.addMenu(menu);
        return menu;
    }

    public void deleteMenu(Menu menu) throws Exception {
        menueDao.deleteMenu(menu);
    }

    public void updateMenu(Menu menu) throws Exception {
        menueDao.updateMenu(menu);
    }

    public List<Menu> findMenus(Menu menu, Integer start, Integer max) throws Exception {
        return menueDao.findMenus(menu, start, max);
    }

}
