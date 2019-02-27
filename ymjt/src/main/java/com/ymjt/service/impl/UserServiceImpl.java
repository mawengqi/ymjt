package com.ymjt.service.impl;

import com.ymjt.dao.UserDao;
import com.ymjt.entity.User;
import com.ymjt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wenqi on 2019/2/27
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    public User addUser(User user) throws Exception {
        return userDao.addUser(user);
    }

    public User findUser(Integer id) throws Exception {
        return userDao.findUser(id);
    }
}
