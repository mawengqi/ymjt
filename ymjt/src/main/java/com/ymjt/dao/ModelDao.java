package com.ymjt.dao;

import com.ymjt.entity.Model;

import java.util.List;

/**
 * Created by wenqi on 2019/2/28
 */
public interface ModelDao {
    public Model addModel(Model model) throws Exception;
    public void deleteModel(Model model) throws Exception;
    public void updateModel(Model model) throws Exception;
    public List<Model> findModels(Model model, Integer first, Integer max) throws Exception;
}
