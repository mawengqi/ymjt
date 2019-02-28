package com.ymjt.dao.impl;

import com.ymjt.dao.BaseDao;
import com.ymjt.utils.ValidateUtils;
import org.apache.commons.lang3.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;

/**
 * Created by wenqi on 2019/2/28
 */
public class BaseDaoImpl<T> implements BaseDao<T> {

    @Autowired
    protected HibernateTemplate template;

    private Class<T> clz;

    public T add(T t) throws Exception {
        ValidateUtils.check(t);
        template.save(t);
        return t;
    }
    public void delete(T t) throws Exception {
        ValidateUtils.check(t);
        template.delete(t);
    }
    public void update(T t) throws Exception {
        ValidateUtils.check(t);
        template.update(t);
    }
    public T find(Integer id) throws Exception {
        ValidateUtils.check(id);
        return template.get(clz, id);
    }

}
