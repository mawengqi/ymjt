package com.ymjt.controller;

import com.alibaba.fastjson.JSON;
import com.ymjt.commons.FileUpload;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UploadImage extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            resp.getWriter().write(JSON.toJSONString(FileUpload.uploadImage(req)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
