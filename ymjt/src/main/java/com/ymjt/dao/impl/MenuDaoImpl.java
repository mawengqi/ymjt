package com.ymjt.dao.impl;

import com.ymjt.dao.MenueDao;
import com.ymjt.entity.Menu;
import com.ymjt.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
@Repository
public class MenuDaoImpl implements MenueDao {

    @Autowired
    private HibernateTemplate template;

    public Menu addMenu(Menu menu) throws Exception {
        ValidateUtils.check(menu);
        template.save(menu);
        return menu;
    }

    public void deleteMenu(Menu menu) throws Exception {
        ValidateUtils.check(menu);
        template.delete(menu);
    }

    public void updateMenu(Menu menu) throws Exception {
        ValidateUtils.check(menu);
        template.delete(menu);
    }

    public List<Menu> findMenus(Menu menu, Integer first, Integer max) throws Exception {
        ValidateUtils.check(menu);
        List<Menu> menuList = template.findByExample(menu, first, max);
        return menuList;
    }
}
