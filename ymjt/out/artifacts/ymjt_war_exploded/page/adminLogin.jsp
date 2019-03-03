<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/2
  Time: 0:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" class=" -webkit-">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Form</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <link rel="stylesheet" href="../static/css/login.css">
</head>
<body>
<div class="login">
    <h1>系统管理员登录</h1>
    <form method="post" action="${pageContext.request.contextPath}/rooter/login.action" id="login">
        <input type="text" name="user.username" placeholder="用户名" required="required" maxlength="10">
        <input type="password" name="user.password" placeholder="密码" required="required" maxlength="30">
    </form>
    <button class="btn btn-primary btn-block btn-large" onclick="login()">提交</button>
    <p id="loginInfo" style="font-weight: bold; color: red; font-size: 14px;">${requestScope.get("info")}</p>
</div>
</body>
<script>
    function commit() {
        var usernameReg = /[\u4e00-\u9fa5\w]{1,10}/
        var passwordReg = /\w{6,20}/
        var username = $("input[type='text']").eq(0).val().trim()
        var password = $("input[type='password']").eq(0).val()
        var button = $("input[type='button']").eq(0)
        var info = $("#info")
        if(usernameReg.test(username) == false) {
            info.text("用户名输入格式错误")
            return
        }
        if(passwordReg.test(password) == false) {
            info.text("密码输入格式错误")
            return
        }
        submit.submit()
    }

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
</script>
</html>
