package com.ymjt.service;

import com.ymjt.entity.New;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
public interface NewService {
    public New addNew(New news) throws Exception;
    public void deleteNew(New news) throws Exception;
    public void updateNew(New news) throws Exception;
    public List<New> findNews(New news, Integer start, Integer max) throws Exception;
}
