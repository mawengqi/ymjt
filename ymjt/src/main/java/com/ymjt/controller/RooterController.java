package com.ymjt.controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.ymjt.commons.Errors;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
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
 * Created by wenqi on 2019/2/28
 */
@Controller
@Scope("prototype")
public class RooterController extends ActionSupport {
    public static Logger logger = Logger.getLogger(RooterController.class);

    @Autowired
    private UserService userService;
    public User user;

    /**
     * 管理员登录
     */
    public String login() throws Exception {
        ValidateUtils.check(user,user.getUsername(), user.getPassword());
        Map<String, Object> session = ActionContext.getContext().getSession();
        Boolean isLogin = (Boolean) session.get(SessionNames.ISLOGIN);
        if(!isLogin){
            user.setId(null);
            List<User> userList = userService.findUsers(user, null, null);
            if(!userList.isEmpty()){
                session.put(SessionNames.ISLOGIN, true);
                session.put(SessionNames.USER, userList.get(0));
                return ResultNames.ADMINPAGE;
            }else{
                ServletActionContext.getRequest().setAttribute("info", "用户名或密码错误");
                logger.warn(Errors.LOGINERROR);
                return ResultNames.ADMINLOGINPAGE;
            }
        }else{
            return ResultNames.ADMINLOGINPAGE;
        }
    }

    /**
     * 管理员登出
     */
    public String logout(){
        Map<String, Object> session = ActionContext.getContext().getSession();
        Boolean isLogin = (Boolean) session.get(SessionNames.ISLOGIN);
        if(isLogin)
            ServletActionContext.getRequest().getSession().invalidate();
        return ResultNames.ADMINLOGINPAGE;
    }
}
