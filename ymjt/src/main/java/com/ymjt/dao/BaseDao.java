package com.ymjt.dao;

/**
 * Created by wenqi on 2019/2/28
 */
public interface BaseDao<T> {
    public T find(Integer id) throws Exception;
    public void update(T t) throws Exception;
    public void delete(T t) throws Exception;
    public T add(T t) throws Exception;
}
