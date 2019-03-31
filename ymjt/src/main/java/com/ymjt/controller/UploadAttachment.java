package com.ymjt.controller;

import com.alibaba.fastjson.JSON;
import com.ymjt.commons.FileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UploadAttachment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        try {
            resp.getWriter().write(JSON.toJSONString(FileUpload.uploadAttachment(req)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
