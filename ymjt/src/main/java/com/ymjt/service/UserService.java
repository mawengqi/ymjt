package com.ymjt.service;

import com.ymjt.entity.User;

/**
 * Created by wenqi on 2019/2/27
 */
public interface UserService {
    public User addUser(User user) throws Exception;
    public User findUser(Integer id) throws Exception;
}
