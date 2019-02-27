package com.ymjt.controller;

import com.opensymphony.xwork2.ActionSupport;
import com.ymjt.entity.User;
import com.ymjt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

/**
 * Created by wenqi on 2019/2/27
 */
@Controller
@Scope("prototype")
public class UserController extends ActionSupport {
    @Autowired
    private UserService userService;

    public String findUser() throws Exception {
        User user = userService.findUser(1);
        return SUCCESS;
    }
}
