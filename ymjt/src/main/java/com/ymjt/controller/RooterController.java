package com.ymjt.controller;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionContext;
import com.ymjt.commons.FileUpload;
import com.ymjt.commons.ResultNames;
import com.ymjt.commons.SessionNames;
import com.ymjt.commons.UserType;
import com.ymjt.entity.*;
import com.ymjt.utils.IDS;
import com.ymjt.utils.ValidateUtils;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.Validate;
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
import java.rmi.server.ServerCloneException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@Scope("prototype")
@Transactional
public class RooterController {
    private static Logger logger = Logger.getLogger(RooterController.class);
    @Autowired
    private SessionFactory sessionFactory;
    private User user;
    private Attachment attachment;

    /**
     * 登录
     */
    public String login() throws Exception {
        ValidateUtils.check(user, user.getUsername(), user.getPassword());
        System.out.println(user.getUsername());
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
            session.createQuery("delete Article where menuid = :menuid").setString("menuid", menu.getId()).executeUpdate();
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
        String imageUrl = request.getParameter("imageUrl");
        ValidateUtils.check(modelId, name, imageUrl);
        Menu menu = new Menu();
        menu.setId(IDS.getId());
        menu.setName(name);
        menu.setModelId(modelId);
        menu.setImageUrl(imageUrl);
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

    /**
     * 修改栏目图片
     * imageUrl
     */
    public void changeMenuImage() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String imageUrl = request.getParameter("imageUrl");
        String menuId = request.getParameter("menuId");
        ValidateUtils.check(imageUrl, menuId);
        session.createQuery("update Menu set imageUrl = :imageUrl where id = :menuId")
                .setParameter("imageUrl", imageUrl).setParameter("menuId", menuId).executeUpdate();
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
        List articleList = session.createQuery("from Article where menuid = :menuid").setString("menuid", menuId).list();
        response.getWriter().write(JSON.toJSONString(articleList));
    }

    /**
     * 查找指定文章
     * articleId
     * @return article
     */
//    public void findArticle() throws Exception {
//        Session session = sessionFactory.getCurrentSession();
//        HttpServletRequest request = ServletActionContext.getRequest();
//        HttpServletResponse response = ServletActionContext.getResponse();
//        String articleId = request.getParameter("articleId");
//        ValidateUtils.check(articleId);
//        List articleList = session.createQuery("from Article where id = :id").setString("id", articleId).list();
//        if(!articleList.isEmpty())
//            response.getWriter().write(JSON.toJSONString(articleList.get(0)));
//    }




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
        String image = request.getParameter("image");
        ValidateUtils.check(title, content, menuId);
        Article article = new Article();
        article.setId(IDS.getId());
        article.setTitle(title);
        article.setContent(content);
        article.setMenuId(menuId);
        if(image != null && !"".equals(image)) {
            article.setImage(image);
            article.setImageBanner(Integer.parseInt(request.getParameter("imageBanner")));
        }
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
        String image  = request.getParameter("image");
        ValidateUtils.check(title, content, articleId);
    if(image != null|| !"".equals(image)){
            Integer imageBanner = Integer.parseInt(request.getParameter("imageBanner"));
            session.createQuery("update Article set title = :title, content = :content, image = :image, imageBanner = :imageBanner where id = :id")
                    .setString("title", title).setString("content", content).setString("id", articleId).setString("image", image).setInteger("imageBanner", imageBanner).executeUpdate();
        }
        else
            session.createQuery("update Article set title = :title, content = :content, image = :image where id = :id")
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

    /**
     * *******************用户管理*********************
     */

    /**
     * 加载用户列表
     */
    public void loadUsers() throws IOException {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        List userList = session.createQuery("from User").list();
        response.getWriter().write(JSON.toJSONString(userList));
    }

    /**
     * 删除用户
     * userId
     * @return userId
     */

    public void deleteUser() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String userId = request.getParameter("userId");
        ValidateUtils.check(userId);
        session.createQuery("delete from User where id = :id").setString("id", userId).executeUpdate();
        response.getWriter().write(userId);
    }

    /**
     * 添加用户
     * username, type, password
     * @return userId
     */
    public void addUser() throws IOException {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String username = request.getParameter("username");
        Integer type = Integer.parseInt(request.getParameter("type"));
        String password = request.getParameter("password");
        List users = session.createQuery("from User where username = :username").setString("username", username).list();
        if(users.isEmpty()) {
            User user = new User();
            user.setId(IDS.getId());
            user.setUsername(username);
            user.setPassword(password);
            user.setType(type);
            session.save(user);
            response.getWriter().write(user.getId());
        } else {
            response.getWriter().write("用户名已存在");
        }
    }

    /**
     *  附件管理
     */

    //添加附件信息
    public void addAttachment() throws Exception {
        ValidateUtils.check(attachment, attachment.getArticleId(), attachment.getFileName(), attachment.getRid(), attachment.getUrl());
        Session session = sessionFactory.getCurrentSession();
        HttpServletResponse response = ServletActionContext.getResponse();
        session.save(attachment);
        response.getWriter().write(attachment.getRid());
    }

    //删除附件信息
    public void deleteAttachment() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String rid = request.getParameter("rid");
        ValidateUtils.check(rid);
        session.createQuery("delete from Attachment where rid = :rid").setParameter("rid", rid).executeUpdate();
        response.getWriter().write(rid);
    }

    //根据 articleId 获取 attachment
    public void getAttachments() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String articleId = request.getParameter("articleId");
        ValidateUtils.check(articleId);
        List attachments = session.createQuery("from Attachment where articleId = :articleId").setParameter("articleId", articleId).list();
        response.getWriter().write(JSON.toJSONString(attachments));
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

    public Attachment getAttachment() {
        return attachment;
    }

    public void setAttachment(Attachment attachment) {
        this.attachment = attachment;
    }
}
