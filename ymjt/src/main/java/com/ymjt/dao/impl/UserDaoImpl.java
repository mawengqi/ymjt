package com.ymjt.dao.impl;

import com.ymjt.dao.UserDao;
import com.ymjt.entity.User;
import com.ymjt.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

/**
 * Created by wenqi on 2019/2/27
 */
@Component
public class UserDaoImpl implements UserDao{
    @Autowired
    private HibernateTemplate template;

    public User addUser(User user) throws Exception {
        ValidateUtils.check(user);
        template.save(user);
        return user;
    }

    public User findUser(Integer id) throws Exception {
        ValidateUtils.check(id);
        User user = template.get(User.class, id);
        return user;
    }
}
