package com.ymjt.service.impl;

import com.ymjt.dao.UserDao;
import com.ymjt.dao.impl.UserDaoImpl;
import com.ymjt.entity.User;
import com.ymjt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wenqi on 2019/2/27
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDaoImpl userDao;


    public User addUser(User user) throws Exception {
        userDao.addUser(user);
        return user;
    }

    public void deleteUser(User user) throws Exception {
        userDao.deleteUser(user);
    }

    public void updateUser(User user) throws Exception {
        userDao.updateUser(user);
    }

    public List<User> findUsers(User user, Integer start, Integer max) throws Exception {
        return userDao.findUsers(user, start, max);
    }

}
