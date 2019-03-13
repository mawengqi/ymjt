<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>admin</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
    <link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container-fluid" style="padding-top: 30px">
    <div class="col-xs-2">
        <ul class="nav nav-pills nav-stacked">
            <li class="active"><a href="#" style="text-align: center" onclick="change(0)">模块管理</a></li>
            <li><a href="#" style="text-align: center" onclick="change(1)">文章管理</a></li>
            <li><a href="#" style="text-align: center" onclick="change(2)">文件管理</a></li>
            <li><a href="#" style="text-align: center" onclick="change(3)">用户管理</a></li>
        </ul>
    </div>
    <div class="col-xs-10">
        <iframe class="col-xs-12" style="border: none; height: 1000px;" src="${pageContext.request.contextPath}/page/adminModel.jsp"></iframe>
    </div>
</div>
</body>
<script>
    var changeUrls = ["${pageContext.request.contextPath}/page/adminModel.jsp", "${pageContext.request.contextPath}/page/adminArticle.jsp", "${pageContext.request.contextPath}/page/adminFile.jsp", "${pageContext.request.contextPath}/page/adminUser.jsp"];
    function change(index){
        $("iframe").eq(0).attr("src", changeUrls[index]);
    }
</script>
