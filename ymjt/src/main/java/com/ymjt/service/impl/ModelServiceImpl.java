package com.ymjt.service.impl;

import com.ymjt.dao.ModelDao;
import com.ymjt.entity.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
@Service
public class ModelServiceImpl implements ModelDao {

    @Autowired
    private ModelDao modelDao;

    public Model addModel(Model model) throws Exception {
        modelDao.addModel(model);
        return model;
    }

    public void deleteModel(Model model) throws Exception {
        modelDao.deleteModel(model);
    }

    public void updateModel(Model model) throws Exception {
        modelDao.updateModel(model);
    }

    public List<Model> findModels(Model model, Integer first, Integer max) throws Exception {
        return modelDao.findModels(model, first, max);
    }


}
