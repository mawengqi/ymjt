package com.ymjt.controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ymjt.commons.Errors;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.User;
import com.ymjt.service.UserService;
import com.ymjt.utils.ValidateUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Map;

/**
 * Created by wenqi on 2019/2/27
 * 用户操作
 */
@Controller
@Scope("prototype")
public class UserController extends ActionSupport {

    public static Logger logger = Logger.getLogger(UserController.class);

    @Autowired
    private UserService userService;
    public User user;

    /**
     * 用户注册
     */
    public String regist() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        Map<String, Object> session = ActionContext.getContext().getSession();
        User userTmp = new User();
        userTmp.setUsername(user.getUsername());
        List<User> userList = userService.findUsers(userTmp, null,null);
        if(userList.isEmpty()) {
            user.setType(UserType.EVERYMAN);
            userService.addUser(user);
            session.put(SessionNames.ISLOGIN, true);
            session.put(SessionNames.USER, user);
            return ResultNames.HOMEPAGE;
        }
        ServletActionContext.getRequest().setAttribute("info", "用户名已被注册");
        return ResultNames.ADMINLOGINPAGE;
    }

    /**
     * 用户登录
     */
    public String login() throws Exception {
        ValidateUtils.check(user,user.getUsername(), user.getPassword());
        Map<String, Object> session = ActionContext.getContext().getSession();
        Boolean isLogin = (Boolean) session.get(SessionNames.ISLOGIN);
        if(!isLogin){
            List<User> userList = userService.findUsers(user, null, null);
            if(!userList.isEmpty()){
                session.put(SessionNames.ISLOGIN, true);
                session.put(SessionNames.USER, userList.get(0));
                return ResultNames.HOMEPAGE;
            }else{
                ServletActionContext.getRequest().setAttribute("info", "用户名或密码错误");
                logger.warn(Errors.LOGINERROR);
                return ResultNames.LOGINPAGE;
            }
        }else{
            return ResultNames.LOGINPAGE;
        }
    }

    /**
     * 用户登出
     */
    public String logout(){
        Map<String, Object> session = ActionContext.getContext().getSession();
        Boolean isLogin = (Boolean) session.get(SessionNames.ISLOGIN);
        if(isLogin)
            ServletActionContext.getRequest().getSession().invalidate();
        return ResultNames.LOGINPAGE;
    }
}
