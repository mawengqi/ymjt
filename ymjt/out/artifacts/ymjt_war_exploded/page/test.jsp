<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="HandheldFriendly" content="true">

    <title>阳煤集团</title>
    <link rel="shortcut icon" href="http://www.jzxy.edu.cn/image/fav.ico">
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
        {{models}}
    </div>
</body>
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
                    dataTYpe : "json",
                    success : function(data) {
                        vue.bannerArticles = data.bannerArticles
                        vue.imageArticles = data.imageArticles
                        vue.commonArticles = data.commonArticles
                    }
                })
            }
        }
    })
</script>
</html>
