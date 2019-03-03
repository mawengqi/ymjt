package com.ymjt.controller;

import com.opensymphony.xwork2.ActionContext;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.User;
import com.ymjt.utils.IDS;
import com.ymjt.utils.ValidateUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@Transactional
public class UserController {
    private static Logger logger = Logger.getLogger(UserController.class);
    @Autowired
    private SessionFactory sessionFactory;
    private User user;

    /**
     * 登录
     */
    public String login() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        Session session = sessionFactory.getCurrentSession();
        Map<String, Object> sessionMap = ActionContext.getContext().getSession();
        List userList = session.createQuery("from User where username = :username and password = :password")
                .setString("username", user.getUsername()).setString("password", user.getPassword()).list();
        if(!userList.isEmpty()) {
            sessionMap.put(SessionNames.ISLOGIN, true);
            sessionMap.put(SessionNames.USER, userList.get(0));
            return ResultNames.SHOWHOME;
        }else {
            ActionContext.getContext().getValueStack().set("info", "用户名或密码输入错误");
            return ResultNames.SHOWLOGIN;
        }
    }

    /**
     * 注册
     */
    public String regist() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        Session session = sessionFactory.getCurrentSession();
        Map<String, Object> sessionMap = ActionContext.getContext().getSession();
        List userList = session.createQuery("from User where username = :username").setString("username", user.getUsername()).list();
        if(userList.isEmpty()) {
            user.setId(IDS.getId());
            user.setType(UserType.EVERYMAN);
            session.save(user);
            sessionMap.put(SessionNames.ISLOGIN, true);
            sessionMap.put(SessionNames.USER, user);
            return ResultNames.SHOWHOME;
        }else {
            ActionContext.getContext().getValueStack().set("info", "用户名已被注册");
            return ResultNames.SHOWLOGIN;
        }
    }

    /**
     * 登出
     */
    public String logout() {
        Map<String, Object> map = ActionContext.getContext().getSession();
        if(map.get(SessionNames.ISLOGIN) != null)
            ServletActionContext.getRequest().getSession().invalidate();
        return ResultNames.SHOWLOGIN;
    }

    /**
     * 渲染home.jsp
     */
    public String showHome() {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request  = ServletActionContext.getRequest();
        //查询模块与栏目
        List modelList = session.createQuery("from Model").list();
        request.setAttribute("modelList", modelList);
        //查询轮播图
        return ResultNames.PAGEHOME;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
