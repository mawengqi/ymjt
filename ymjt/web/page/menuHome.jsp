<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="HandheldFriendly" content="true">

    <title>阳煤集团</title>
    <link rel="shortcut icon" href="../static/image/logo.ico">
    <link rel="stylesheet" type="text/css" href="./menuHome_files/common.css">
    <link rel="stylesheet" type="text/css" href="./menuHome_files/iconfont.css">
    <link rel="stylesheet" type="text/css" href="./menuHome_files/navPage.css">

    <script src="../plugins/vue/dist/vue.js"></script>
    <script src="../plugins/jquery/jquery.min.js"></script>
</head>
<body>
<div id="vue">
    <div class="clearfix"></div>
    <!-- bgImg -->
    <div class="bgImg">
        <div class="imgBox">
            <i class="mask"></i>
        </div>
        <h1 class="headerTitle">{{modelName}}</h1>
    </div>

    <div class="clearfix"></div>

    <!-- navPage -->
    <div class="navPage">
        <div class="content" style="overflow: visible">
            <ul>
                <li class="navPageItem" v-for="menu in menus">
                    <a href="#" @click="goArticleList(menu.id)">
                        <div class="topImg">
                            <img :src="menu.imageUrl">
                        </div>
                        <div class="tags">
                            <h3>{{menu.name}}</h3>
                            <p>{{menu.name}}</p>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="clearfix"></div>


    <!-- footer -->
    <div class="footer" style="margin-top: 100px;">
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
                        <img src="../static/image/logo.png" width="40%">
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
                        <li>
                            <a href="http://www.moe.gov.cn/" target="_blank">教育部</a>
                        </li>
                        <li>
                            <a href="http://www.sxedu.gov.cn/" target="_blank">山西省教育厅</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="headroom mainNav_fixed" style="height: 60px; overflow: visible;">
        <div class="home">
            <a href="${pageContext.request.contextPath}/page/home.jsp"><img src="../static/image/logo.png"></a>
        </div>
        <div class="topBarNav">
            <ul>
                <li v-for="model in models">
                    <a href="#" @click="goMenu(model.id)" :title="model.name">{{model.name}}</a>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var vue = new Vue({
        el : "#vue",
        created : function () {
            this.loadModels()
            // this.loadMenus()
        },
        data : {
            models : [],
            menus : [],
            modelName : null,
        },
        methods : {
            loadModels : function() {
                [key, value] = window.location.search.substr(1).split("=")
                $.ajax({
                    url : "${pageContext.request.contextPath}/user/loadModel.action",
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.models = data
                        for(let model of data)
                            if(model.id === value) {
                                vue.modelName = model.name
                                vue.menus = model.menuList
                                break
                            }
                    }
                })
            },
            goMenu : function(modelId) {
                window.open("${pageContext.request.contextPath}/page/menuHome.jsp?modelId=" + modelId)
            },
            goArticleList : function(menuId) {
                window.open("${pageContext.request.contextPath}/page/articleList.jsp?menuId=" + menuId)
            }
        }
    })
</script>