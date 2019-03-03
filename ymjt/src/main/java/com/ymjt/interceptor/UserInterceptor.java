package com.ymjt.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

@Component
public class UserInterceptor extends AbstractInterceptor {
    private static Logger logger = Logger.getLogger(UserInterceptor.class);

    public String intercept(ActionInvocation actionInvocation) throws Exception {
        String s = actionInvocation.getProxy().getMethod();
        if ("login".equals(s) || "regist".equals(s)) {
            if (ActionContext.getContext().getSession().get(SessionNames.ISLOGIN) != null)
                return ResultNames.SHOWHOME;
            else
                return actionInvocation.invoke();
        }else {
            if(ActionContext.getContext().getSession().get(SessionNames.ISLOGIN) != null)
                return actionInvocation.invoke();
            else
                return ResultNames.SHOWLOGIN;
        }
    }
}
