package com.ymjt.controller;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionContext;
import com.sun.xml.internal.bind.v2.model.core.ID;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.Article;
import com.ymjt.entity.Menu;
import com.ymjt.entity.Model;
import com.ymjt.entity.User;
import com.ymjt.utils.IDS;
import com.ymjt.utils.ValidateUtils;
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
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@Transactional
public class RooterController {
    private static Logger logger = Logger.getLogger(RooterController.class);
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
        List userList = session.createQuery("from User where username = :username and password = :password and type = :type")
                .setString("username", user.getUsername()).setString("password", user.getPassword()).setInteger("type", UserType.ROOTER).list();
        if(!userList.isEmpty()) {
            sessionMap.put(SessionNames.ISLOGIN, true);
            sessionMap.put(SessionNames.USER, userList.get(0));
            return ResultNames.SHOWADMINHOME;
        }else {
            ActionContext.getContext().getValueStack().set("info", "用户名或密码输入错误");
            return ResultNames.SHOWADMINLOGIN;
        }
    }

    /**
     * 注册
     */
    public String regist() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        Session session = sessionFactory.getCurrentSession();
//        Transaction transaction = session.beginTransaction();
        Map<String, Object> sessionMap = ActionContext.getContext().getSession();
        List userList = session.createQuery("from User where username = :username").setString("username", user.getUsername()).list();
        if(userList.isEmpty()) {
            user.setId(IDS.getId());
            user.setType(UserType.ROOTER);
            session.save(user);
            sessionMap.put(SessionNames.ISLOGIN, true);
            sessionMap.put(SessionNames.USER, user);
//            transaction.commit();
//            session.flush();
            return ResultNames.SHOWADMINHOME;
        }else {
            ActionContext.getContext().getValueStack().set("info", "用户名已被注册");
            return ResultNames.SHOWADMINLOGIN;
        }
    }

    /**
     * 登出
     */
    public String logout() {
        Map<String, Object> map = ActionContext.getContext().getSession();
        if(map.get(SessionNames.ISLOGIN) != null)
            ServletActionContext.getRequest().getSession().invalidate();
        return ResultNames.SHOWADMINLOGIN;
    }

    /**
     * 加载 model
     * @return modelList
     */
    public void loadModel() throws IOException {
        Session session = sessionFactory.getCurrentSession();
        List modelList = session.createQuery("from Model").list();
        HttpServletResponse response = ServletActionContext.getResponse();
        response.getWriter().write(JSON.toJSONString(modelList));
    }

    /**
     * 添加模块
     * name
     * @return modelId
     */
    public void addModel() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        String name = request.getParameter("name");
        HttpServletResponse response = ServletActionContext.getResponse();
        ValidateUtils.check(name);
        Model model = new Model();
        model.setId(IDS.getId());
        model.setName(name);
        session.save(model);
        String directoryPath = ServletActionContext.getServletContext().getRealPath("/static/image/news/" + model.getId());
        File file = new File(directoryPath);
        if(!file.exists())
            file.mkdir();
        response.getWriter().write(model.getId());
    }

    /**
     * 删除模块
     * modelId
     * @return modelId
     */
    public void deleteModel() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String modelId = request.getParameter("modelId");
        ValidateUtils.check(modelId);
        //删除model,删除model下的栏目，栏目下的文章,包括文章的图片
        session.createQuery("delete Model where id = :id").setString("id", modelId).executeUpdate();
        List<Menu> menuList = session.createQuery("from Menu where modelid = :modelid").setString("modelid", modelId).list();
        for(Menu menu : menuList) {
            session.createQuery("delete article where menuid = :menuid").setString("menuid", menu.getId()).executeUpdate();
            session.createQuery("delete Menu where id = :id").setString("id", menu.getId()).executeUpdate();
        }
        String directoryPath = ServletActionContext.getServletContext().getRealPath("/static/image/news/" + modelId);
        File file = new File(directoryPath);
        if(file.exists())
            file.delete();
        response.getWriter().write(modelId);
    }

    /**
     * 添加栏目
     * modelId, name
     * @return menuId
     */
    public void addMenu() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String modelId = request.getParameter("modelId");
        String name = request.getParameter("name");
        ValidateUtils.check(modelId, name);
        Menu menu = new Menu();
        menu.setId(IDS.getId());
        menu.setName(name);
        menu.setModelId(modelId);
        session.save(menu);
        String directoryPath = ServletActionContext.getServletContext().getRealPath("/static/image/news/" + modelId + "/" + menu.getId());
        File file = new File(directoryPath);
        if(!file.exists())
            file.mkdir();
        response.getWriter().write(menu.getId());
    }

    /**
     * 删除栏目
     * modelId, menuId
     * @return id
     */
    public void deleteMenu() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String modelId = request.getParameter("modelId");
        String menuId = request.getParameter("menuId");
        ValidateUtils.check(modelId, menuId);
        session.createQuery("delete Menu where id = :id").setString("id", menuId).executeUpdate();
        session.createQuery("delete Article where menuid = :menuid").setString("menuid", menuId).executeUpdate();
        String directoryPath = ServletActionContext.getServletContext().getRealPath("/static/image/news/" + modelId + "/" + menuId);
        File file = new File(directoryPath);
        if(file.exists())
            file.delete();
        response.getWriter().write(menuId);
    }

//*********************文章管理*******************************************
    /**
     * 加载文章列表
     *  menuId
     * @return articleList
     */
    public void loadArticle() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String menuId = request.getParameter("menuId");
        ValidateUtils.check(menuId);
        List articleList = session.createQuery("select id, title, time from Article where menuid = :menuid").setString("menuid", menuId).list();
        response.getWriter().write(JSON.toJSONString(articleList));
    }

    /**
     * 查找指定文章
     * articleId
     * @return article
     */
    public void findArticle() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String articleId = request.getParameter("articleId");
        ValidateUtils.check(articleId);
        List articleList = session.createQuery("from Article where id = :id").setString("id", articleId).list();
        if(!articleList.isEmpty())
            response.getWriter().write(JSON.toJSONString(articleList.get(0)));
    }




    /**
     * 添加文章
     * title, content, menuId
     * @return id
     */
    public void addArticle() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String menuId = request.getParameter("menuId");
        ValidateUtils.check(title, content, menuId);
        Article article = new Article();
        article.setId(IDS.getId());
        article.setTitle(title);
        article.setContent(content);
        article.setMenuId(menuId);
        session.save(article);
        response.getWriter().write(article.getId());
    }

    /**
     * 修改文章
     * title, content, articleId
     * @return articleId
     */
    public void changeArticle() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String articleId = request.getParameter("articleId");
        ValidateUtils.check(title, content, articleId);
        session.createQuery("update Article set title = :title and content = :content where id = :id")
                .setString("title", title).setString("content", content).setString("id", articleId).executeUpdate();
        response.getWriter().write(articleId);
    }

    /**
     * 删除文章
     * articleId
     * @return articleId
     */
    public void deleteArticle() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String articleId = request.getParameter("articleId");
        ValidateUtils.check(articleId);
        session.createQuery("delete Article where id = :id").setString("id", articleId).executeUpdate();
        response.getWriter().write(articleId);
    }



    public String showHome() {
        return ResultNames.PAGEADMINHOME;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
