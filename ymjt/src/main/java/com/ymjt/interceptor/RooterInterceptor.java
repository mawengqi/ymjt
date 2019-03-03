package com.ymjt.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.User;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

@Component
public class RooterInterceptor extends AbstractInterceptor {
    private static Logger logger = Logger.getLogger(RooterInterceptor.class);

    public String intercept(ActionInvocation actionInvocation) throws Exception {
        String s = actionInvocation.getProxy().getMethod();
        if ("login".equals(s)) {
            if (ActionContext.getContext().getSession().get(SessionNames.ISLOGIN) != null &&
                    UserType.ROOTER == ((User)ActionContext.getContext().getSession().get(SessionNames.USER)).getType())
                return ResultNames.SHOWADMINHOME;
            else
                return actionInvocation.invoke();
        }else {
            if(ActionContext.getContext().getSession().get(SessionNames.ISLOGIN) != null &&
                    UserType.ROOTER == ((User)ActionContext.getContext().getSession().get(SessionNames.USER)).getType())
                return actionInvocation.invoke();
            else
                return ResultNames.SHOWADMINLOGIN;
        }
    }
}
