<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<html lang="en" class=" -webkit-">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录注册中心</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <link rel="stylesheet" href="../static/css/login.css">
</head>
<body>
<div class="login">
    <h1>登录</h1>
    <form method="post" action="${pageContext.request.contextPath}/user/login.action" id="login">
        <input type="text" name="user.username" placeholder="用户名" required="required" maxlength="10">
        <input type="password" name="user.password" placeholder="密码" required="required" maxlength="30">
    </form>
    <button class="btn btn-primary btn-block btn-large" onclick="login()">提交</button>
    <button class="btn btn-primary btn-block btn-large" onclick="change()" style="margin-top: 10px">新用户,去注册</button>
    <p id="loginInfo" style="font-weight: bold; color: red; font-size: 14px;">${requestScope.get("info")}</p>
</div>
<div class="login" style="display: none">
    <h1>注册</h1>
    <form method="post" action="${pageContext.request.contextPath}/user/regist.action" id="regist">
        <input type="text" name="user.username" placeholder="用户名" required="required" maxlength="10">
        <input type="password" name="user.password" placeholder="密码" required="required" maxlength="30">
        <input type="password" name="user.password" placeholder="确认密码" required="required" maxlength="30">
    </form>
    <button class="btn btn-primary btn-block btn-large" onclick="regist()">提交</button>
    <button class="btn btn-primary btn-block btn-large" onclick="change()" style="margin-top: 10px">已有账号,去登陆</button>
    <p id="registInfo" style="font-weight: bold; color: red; font-size: 14px;">${requestScope.get("info")}</p>
</div>
</body>
<script>
    var usernameReg = /[\u4e00-\u9fa5\w]{1,10}/
    var passwordReg = /\w{6,20}/
    //登录信息验证和提交
    function login() {
        var username = $("#login input").eq(0).val().trim()
        var password = $("#login input").eq(1).val()
        var info = $("#loginInfo")
        if(usernameReg.test(username) == false) {
            info.text("用户名输入格式错误")
            return
        }
        if(passwordReg.test(password) == false) {
            info.text("密码输入格式错误")
            return
        }
        $("#login").submit()
    }

    // 注册信息验证与表单提交
    function regist() {
        var username = $("#regist input").eq(0).val().trim()
        var password = $("#regist input").eq(1).val()
        var repassword = $("#regist input").eq(2).val();
        var info = $("#registInfo")
        if(usernameReg.test(username) == false) {
            info.text("用户名输入格式错误")
            return
        }
        if(passwordReg.test(password) == false) {
            info.text("密码输入格式错误")
            return
        }
        if(password != repassword) {
            info.text("密码输入不一致")
        }
        $("#regist").submit()
    }


     // 注册与登录切换
    function change() {
        var logins = $(".login")
        for(var i=0;i<logins.size(); i++) {
            if(logins.eq(i).css("display")=="none")
                logins.eq(i).css("display", "block")
            else
                logins.eq(i).css("display", "none")
        }
    }

</script>
</html>
