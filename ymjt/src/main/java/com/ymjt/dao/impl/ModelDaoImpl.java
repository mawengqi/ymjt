package com.ymjt.dao.impl;

import com.ymjt.dao.ModelDao;
import com.ymjt.entity.Model;
import com.ymjt.utils.ValidateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
@Repository
public class ModelDaoImpl implements ModelDao{

    @Autowired
    private HibernateTemplate template;

    public Model addModel(Model model) throws Exception {
        ValidateUtils.check(model);
        template.save(model);
        return model;
    }

    public void deleteModel(Model model) throws Exception {
        ValidateUtils.check(model);
        template.delete(model);
    }

    public void updateModel(Model model) throws Exception {
        ValidateUtils.check(model);
        template.update(model);
    }

    public List<Model> findModels(Model model, Integer first, Integer max) throws Exception {
        ValidateUtils.check(model);
        List<Model> modelList = template.findByExample(model, first, max);
        return modelList;
    }
}
