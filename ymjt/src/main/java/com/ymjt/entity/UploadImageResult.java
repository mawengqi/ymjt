package com.ymjt.entity;

import java.util.ArrayList;
import java.util.List;

public class UploadImageResult {
    private Integer errno;
    private List<String> data = new ArrayList<String>();

    public Integer getErrno() {
        return errno;
    }

    public void setErrno(Integer errno) {
        this.errno = errno;
    }

    public List<String> getData() {
        return data;
    }

    public void setData(List<String> data) {
        this.data = data;
    }
}
