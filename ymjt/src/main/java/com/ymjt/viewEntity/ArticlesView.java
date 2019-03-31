package com.ymjt.viewEntity;

import com.ymjt.entity.Article;

import java.util.List;

public class ArticlesView {
    private List<Article> bannerArticles;
    private List<Article> imageArticles;
    private List<Article> commonArticles;

    public List<Article> getBannerArticles() {
        return bannerArticles;
    }

    public void setBannerArticles(List<Article> bannerArticles) {
        this.bannerArticles = bannerArticles;
    }

    public List<Article> getImageArticles() {
        return imageArticles;
    }

    public void setImageArticles(List<Article> imageArticles) {
        this.imageArticles = imageArticles;
    }

    public List<Article> getCommonArticles() {
        return commonArticles;
    }

    public void setCommonArticles(List<Article> commonArticles) {
        this.commonArticles = commonArticles;
    }
}
