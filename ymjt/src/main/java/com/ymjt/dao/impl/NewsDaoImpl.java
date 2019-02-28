package com.ymjt.dao.impl;

import com.ymjt.dao.NewsDao;
import com.ymjt.entity.News;
import com.ymjt.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

/**
 * Created by wenqi on 2019/2/28
 */
@Repository
public class NewsDaoImpl<T> extends BaseDaoImpl<News> implements NewsDao {

}
