package com.ymjt.controller;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionContext;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.Article;
import com.ymjt.entity.User;
import com.ymjt.utils.IDS;
import com.ymjt.utils.ValidateUtils;
import com.ymjt.viewEntity.ArticleView;
import com.ymjt.viewEntity.ArticlesView;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@Transactional
public class UserController {
    private static Logger logger = Logger.getLogger(UserController.class);
    @Autowired
    private SessionFactory sessionFactory;
    private User user;

    /**
     * 登录
     */
    public String login() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        Session session = sessionFactory.getCurrentSession();
        Map<String, Object> sessionMap = ActionContext.getContext().getSession();
        List userList = session.createQuery("from User where username = :username and password = :password")
                .setString("username", user.getUsername()).setString("password", user.getPassword()).list();
        if(!userList.isEmpty()) {
            sessionMap.put(SessionNames.ISLOGIN, true);
            sessionMap.put(SessionNames.USER, userList.get(0));
            return ResultNames.SHOWHOME;
        }else {
            ActionContext.getContext().getValueStack().set("info", "用户名或密码输入错误");
            return ResultNames.SHOWLOGIN;
        }
    }

    /**
     * 注册
     */
    public String regist() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        Session session = sessionFactory.getCurrentSession();
        Map<String, Object> sessionMap = ActionContext.getContext().getSession();
        List userList = session.createQuery("from User where username = :username").setString("username", user.getUsername()).list();
        if(userList.isEmpty()) {
            user.setId(IDS.getId());
            user.setType(UserType.EVERYMAN);
            session.save(user);
            sessionMap.put(SessionNames.ISLOGIN, true);
            sessionMap.put(SessionNames.USER, user);
            return ResultNames.SHOWHOME;
        }else {
            ActionContext.getContext().getValueStack().set("info", "用户名已被注册");
            return ResultNames.SHOWLOGIN;
        }
    }

    /**
     * 登出
     */
    public String logout() {
        Map<String, Object> map = ActionContext.getContext().getSession();
        if(map.get(SessionNames.ISLOGIN) != null)
            ServletActionContext.getRequest().getSession().invalidate();
        return ResultNames.SHOWLOGIN;
    }

    /**
     * 渲染home.jsp
     */
    public String showHome() {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request  = ServletActionContext.getRequest();
        //查询模块与栏目
        List modelList = session.createQuery("from Model").list();
        request.setAttribute("modelList", modelList);
        //查询轮播图
        return ResultNames.PAGEHOME;
    }

    /**
     * 首页获取articles (bannerArticle, imageArticle, commonArticle)
     * @return
     */
    public void loadArticles() throws IOException {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        ArticlesView articles = new ArticlesView();
        List bannerArticles = session.createQuery("from Article where imageBanner = 1 order by time desc").setFirstResult(0).setMaxResults(6).list();
        List imageArticles = session.createQuery("from Article where imageBanner = 0 order by time desc").setFirstResult(0).setMaxResults(6).list();
        List commonArticles = session.createQuery("from Article where imageBanner is null").setFirstResult(0).setMaxResults(6).list();
        articles.setBannerArticles(bannerArticles);
        articles.setImageArticles(imageArticles);
        articles.setCommonArticles(commonArticles);
        response.getWriter().write(JSON.toJSONString(articles));
    }

    /**
     * 获取模块
     * @return
     */
    public void loadModel() throws IOException {
        Session session = sessionFactory.getCurrentSession();
        List modelList = session.createQuery("from Model").list();
        HttpServletResponse response = ServletActionContext.getResponse();
        response.getWriter().write(JSON.toJSONString(modelList));
    }

    /**
     * 获取栏目
     * menuId
     * @return
     */
    public void loadMenus() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String menuId = request.getParameter("menuId");
        ValidateUtils.check(menuId);
        List menus = session.createQuery("from Menu where id = :menuId").setParameter("menuId", menuId).list();
        response.getWriter().write(JSON.toJSONString(menus));
    }

    /**
     * 获取文章列表
     * articleId , pageNumber
     * @return
     */
    public void loadArticleList() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String menuId = request.getParameter("menuId");
        String pageNumber = request.getParameter("pageNumber");
        ValidateUtils.check(menuId, pageNumber);
        List articles = session.createQuery("from Article where menuId = :menuId").setParameter("menuId", menuId)
                .setFirstResult(Integer.parseInt(pageNumber) * 5).setMaxResults(5).list();
        response.getWriter().write(JSON.toJSONString(articles));
    }

    /**
     * 加载文章和相应的附件
     * articleId
     * @return
     */
    public void loadArticle() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String articleId = request.getParameter("articleId");
        ValidateUtils.check(articleId);
        ArticleView articleView = new ArticleView();
        articleView.setArticle((Article) session.get(Article.class, articleId));
        List files = session.createQuery("from Attachment where articleId = :articleId").setParameter("articleId", articleId).list();
        articleView.setAttachments(files);
        response.getWriter().write(JSON.toJSONString(articleView));
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
