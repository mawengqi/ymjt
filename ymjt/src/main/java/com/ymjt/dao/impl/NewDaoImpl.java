package com.ymjt.dao.impl;

import com.ymjt.dao.NewDao;
import com.ymjt.entity.New;
import com.ymjt.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
@Repository
public class NewDaoImpl implements NewDao {

    @Autowired
    private HibernateTemplate template;

    public New addNew(New news) throws Exception {
        ValidateUtils.check(news);
        template.save(news);
        return news;
    }

    public void deleteNew(New news) throws Exception {
        ValidateUtils.check(news);
        template.delete(news);
    }

    public void updateNew(New news) throws Exception {
        ValidateUtils.check(news);
        template.update(news);
    }

    public List<New> findNews(New news, Integer first, Integer max) throws Exception {
        ValidateUtils.check(news);
        List<New> newList = template.findByExample(news, first, max);
        return newList;
    }
}
