package com.ymjt.viewEntity;

import com.ymjt.entity.Article;
import com.ymjt.entity.Attachment;

import java.util.List;

public class ArticleView {
    private Article article;
    private List<Attachment> attachments;

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public List<Attachment> getAttachments() {
        return attachments;
    }

    public void setAttachments(List<Attachment> attachments) {
        this.attachments = attachments;
    }
}
