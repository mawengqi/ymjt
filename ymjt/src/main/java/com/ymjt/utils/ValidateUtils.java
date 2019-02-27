package com.ymjt.utils;

import com.ymjt.commons.Errors;

import java.util.List;

/**
 * Created by wenqi on 2019/2/27
 */
public class ValidateUtils {
    public static void check(Object ...args) throws Exception{
        for (Object obj : args) {
            if(obj == null)
                throw new Exception(Errors.NULLERROR);
        }
    }

    public static void checkListNotEmpty(List<Object> list) throws Exception{
        if(list == null || list.isEmpty())
            throw new Exception(Errors.NULLERROR);
    }
}
