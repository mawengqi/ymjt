<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns:data-iview="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="HandheldFriendly" content="true">

    <title>阳煤集团</title>
    <link rel="shortcut icon" href="../static/image/logo.ico">
    <link rel="stylesheet" type="text/css" href="./home_files/common.css">
    <link rel="stylesheet" type="text/css" href="./home_files/iconfont.css">
    <link rel="stylesheet" type="text/css" href="./home_files/infomation.css">
    <link rel="stylesheet" type="text/css" href="./home_files/slide.css">
    <link rel="stylesheet" type="text/css" href="./home_files/index.css">
    <link rel="stylesheet" type="text/css" href="../plugins/jquerylbt/css/shutter.css"/>

    <script src="../plugins/vue/dist/vue.js"></script>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <script src="../plugins/jquerylbt/js/shutter.js"></script>
    <script src="../plugins/jquerylbt/js/velocity.js"></script>
</head>

<body>
<div id="vue">
<!-- topLogo -->
    <div class="topLogo">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/page/home.jsp">
                <img src="../static/image/logo.png">
            </a>
        </div>
    </div>

    <div class="clearfix"></div>

<!-- mainNav -->
    <div class="mainNav">
        <div class="content">
            <ul class="mainNavList">
                <li class="dropdown" v-for="model in models">
                    <a @click="goMenu(model.id)" :title="model.name">
                        {{model.name}}
                    </a>
                    <ul>
                        <li v-for="menu in model.menuList">
                            <a @click="goArticleList(menu.id)">{{menu.name}}</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

    <div class="clearfix"></div>
    <!--slider-->
    <div class="shutter" style="border-radius: 0px">
        <div class="shutter-img">
            <template v-for="bannerArticle in bannerArticles">
                <a href="#" :data-shutter-title="bannerArticle.title">
                    <img :src="bannerArticle.image" alt="#">
                </a>
            </template>
        </div>
        <ul class="shutter-btn">
            <li class="prev"></li>
            <li class="next"></li>
        </ul>
        <div class="shutter-desc">
            <p>{{bannerArticles[0].title}}</p>
        </div>
        <script>
            $(function () {
                $('.shutter').shutter({
                    // shutterW: 1000,
                    shutterH: 500, // 容器高度
                    isAutoPlay: true, // 是否自动播放
                    playInterval: 3000, // 自动播放时间
                    curDisplay: 3, // 当前显示页
                    fullPage: false // 是否全屏展示
                });
            });
        </script>
    </div>



    <div class="clearfix"></div>
    <!-- news -->
    <div class="information">
        <div class="content">
            <div class="news">
                <div class="newsBox">
                    <div class="headTitle">
                        <h3>
                            <a onclick="return false" class="main">
                                新闻中心
                            </a>
                        </h3>
                    </div>
                    <div class="headlines" v-if="imageArticles.length != 0">
                        <a :href="goArticle(imageArticles[0].id)">
                            <div class="imgBox">
                                <img :src="imageArticles[0].image" alt="imageArticles[0].title">
                            </div>
                            <div class="infos">
                                <h3 class="mainTitle">
                                    {{imageArticles[0].title}}
                                </h3>
                                <p class="subTitle" v-html="imageArticles[0].content.substr(0,100)">
                                    <%--{{imageArticles[0].content.substr(0,100)}}--%>
                                </p>
                                <div class="data">
                                    <p class="visitTimes">
                                        <span class="iconfont"></span>
                                        <span id="clickclickresult" style="font-size:12px;"> 2921</span>
                                    </p>
                                    <p class="time">{{imageArticles[0].time | dateFormat}}</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="newsList">
                        <ul>
                            <li v-for="(imageArticle,index) in imageArticles">
                                <template v-if="index != 0">
                                    <a href="#" @click="goArticle(imageArticle.id)">
                                        <p>
                                        <span class="text">
                                            {{imageArticle.title}}
                                        </span>
                                            <span class="time">{{imageArticle.time | dateFormat}}</span>
                                        </p>
                                    </a>
                                </template>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>


            <div class="news">
                <div class="newsBox">
                    <div class="headTitle">
                        <h3>
                            <a onclick="return false" class="main">
                                近期动态
                            </a>
                        </h3>
                    </div>

                    <div class="newsList">
                        <ul>
                            <li v-for="(commonArticle,index) in commonArticles">
                                <a href="#" @click="goArticle(commonArticle.id)">
                                    <p>
                                    <span class="text">
                                        {{commonArticle.title}}
                                    </span>
                                        <span class="time">{{commonArticle.time | dateFormat}}</span>
                                    </p>
                                </a>
                            </li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="clearfix"></div>
    <%--<!-- footer -->--%>
    <div class="footer">
        <div class="copyInfo">
            <div class="content" style="height: 50%">
                <div class="infoTop">
                    <a href="${pageContext.request.contextPath}/page/home.jsp">
                        <img src="../static/image/logo.png">
                    </a>
                </div>
                <div class="infoLeft">
                    <ul class="infoList">
                        <li>
                            <p>办公电话:0353-7073112</p>
                        </li>
                        <li>
                            <p>招办电话:7073914</p>
                        </li>
                    </ul>
                </div>
                <div class="infoMid">
                    <a href="${pageContext.request.contextPath}/page/home.jsp">
                        <img src="../static/image/logo.png" width="50%">
                    </a>
                </div>
                <div class="infoRight">
                    <ul class="infoList">
                        <li>
                            <p>邮编:045000</p>
                        </li>
                        <li>
                            <p>官网:www.ymjt.com.cn</p>
                        </li>
                        <li>
                            <p>地址:山西阳泉市北大街5号</p>
                        </li>
                    </ul>
                </div>
                <div class="infoBottom">
                    <ul class="infoList">
                        <li>
                            <p>友情链接&nbsp; :</p>
                        </li>
                        <li>
                            <a href="http://www.people.com.cn/" target="_blank">人民网</a>
                        </li>
                        <li>
                            <a href="http://www.xinhuanet.com/" target="_blank">新华网</a>
                        </li>
                        <li>
                            <a href="http://www.cnki.net/" target="_blank">中国知网</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>
    var vue = new Vue({
        el : "#vue",
        data : {
            name : "mawenqi",
            models : [],
            bannerArticles : [],
            imageArticles : [],
            commonArticles : [],
        },
        created : function(){
            this.loadModels()
            this.loadArticles()
        },
        methods : {
            loadModels : function() {
                $.ajax({
                    url : "${pageContext.request.contextPath}/user/loadModel.action",
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.models = data
                    }
                })
            },
            loadArticles : function() {
                $.ajax({
                    url : "${pageContext.request.contextPath}/user/loadArticles.action",
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.bannerArticles = data.bannerArticles
                        vue.imageArticles = data.imageArticles
                        vue.commonArticles = data.commonArticles
                    }
                })
            },
            goMenu : function(modelId) {
                window.open("${pageContext.request.contextPath}/page/menuHome.jsp?modelId=" + modelId)
            },
            goArticleList : function(menuId) {
                window.open("${pageContext.request.contextPath}/page/articleList.jsp?menuId=" + menuId)
            },
            goArticle : function(articleId) {
                window.open("${pageContext.request.contextPath}/page/article.jsp?articleId=" + articleId)
            },

        },
        filters : {
            dateFormat : function(time) {
                let date = new Date(time)
                return date.getMonth() + "-" + date.getDate()
            }
        }
    })
</script>