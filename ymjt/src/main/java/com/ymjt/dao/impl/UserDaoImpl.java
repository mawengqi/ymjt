package com.ymjt.dao.impl;

import com.ymjt.dao.UserDao;
import com.ymjt.entity.User;
import com.ymjt.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wenqi on 2019/2/27
 */
@Repository
public class UserDaoImpl implements UserDao{

    @Autowired
    private HibernateTemplate template;

    public User addUser(User user) throws Exception {
        ValidateUtils.check(user);
        template.save(user);
        return user;
    }

    public void deleteUser(User user) throws Exception {
        ValidateUtils.check(user);
        template.delete(user);
    }

    public void updateUser(User user) throws Exception {
        ValidateUtils.check(user);
        template.update(user);
    }

    public List<User> findUsers(User user, Integer first, Integer max) throws Exception {
        ValidateUtils.check(user);
        List<User> userList = template.findByExample(user, first, max);
        return userList;
    }
}
