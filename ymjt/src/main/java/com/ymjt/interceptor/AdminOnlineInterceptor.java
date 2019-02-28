package com.ymjt.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.User;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by wenqi on 2019/2/28
 */
@Component
public class AdminOnlineInterceptor extends AbstractInterceptor {

    public String intercept(ActionInvocation actionInvocation) throws Exception {
        Map session = actionInvocation.getInvocationContext().getSession();
        Boolean isLogin = (Boolean) session.get(SessionNames.ISLOGIN);
        User user = (User) session.get(SessionNames.USER);
        if(!isLogin && UserType.ROOTER.equals(user.getType()))
            return ResultNames.ADMINLOGINPAGE;
        return actionInvocation.invoke();
    }
}
