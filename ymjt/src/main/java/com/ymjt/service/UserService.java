package com.ymjt.service;

import com.ymjt.entity.User;

import java.util.List;

/**
 * Created by wenqi on 2019/2/27
 */
public interface UserService {
    public User addUser(User user) throws Exception;
    public void deleteUser(User user) throws Exception;
    public void updateUser(User user) throws Exception;
    public List<User> findUsers(User user, Integer start, Integer max) throws Exception;
}
