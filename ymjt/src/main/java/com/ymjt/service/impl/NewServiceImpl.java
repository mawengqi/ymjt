package com.ymjt.service.impl;

import com.ymjt.dao.NewDao;
import com.ymjt.entity.New;
import com.ymjt.service.NewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
@Service
public class NewServiceImpl implements NewService {

    @Autowired
    private NewDao newDao;

    public New addNew(New news) throws Exception {
        newDao.addNew(news);
        return news;
    }

    public void deleteNew(New news) throws Exception {
        newDao.deleteNew(news);
    }

    public void updateNew(New news) throws Exception {
        newDao.updateNew(news);
    }

    public List<New> findNews(New news, Integer start, Integer max) throws Exception {
        return newDao.findNews(news, start, max);
    }

}
