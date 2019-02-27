package com.ymjt.dao;

import com.ymjt.entity.User;

/**
 * Created by wenqi on 2019/2/27
 */
public interface UserDao {
    User addUser(User user) throws Exception;
    User findUser(Integer id) throws Exception;
}
