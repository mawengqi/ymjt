<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="../plugins/vue/dist/vue.js"></script>
    <link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
    <div class="container-fluid" id="vue">
        <div>
            <table class="table table-condensed">
                <thead>
                <tr>
                    <th>用户名</th>
                    <th>用户类型</th>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="user in users">
                    <td><span>{{user.username}}</span></td>
                    <td><span>{{user.type|userTypeFilter}}</span></td>
                    <td><span style="cursor: pointer" class="text-danger" @click="deleteUser(user)">删除</span></td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <td><span class="text-warning" style="cursor: pointer" @click="goAddUser">添加用户</span></td>
                </tr>
                </tfoot>
            </table>
        </div>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <!--添加文章-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title">
                            添加用户
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" placeholder="用户名" class="form-control" maxlength="10" v-model="username"/>
                        </div>
                        <div class="form-group">
                            <label>密码</label>
                            <input type="password" placeholder="密码" class="form-control" maxlength="20" v-model="password"/>
                        </div>
                        <div class="form-group">
                            <label>用户类型</label>
                            <select class="form-control" v-model="userType">
                                <option value="1">用户</option>
                                <option value="0">管理员</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="button" class="btn btn-primary" @click="addUser">
                            提交更改
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var vue = new Vue({
        el : "#vue",
        created : function() {
            this.loadUsers()
        },
        data : {
            users : [],
            username : "",
            userType : 1,
            password : "",
        },
        methods : {
            loadUsers : function() {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/loadUsers.action",
                    type : "get",
                    dataType : "json",
                    success : (users) => {
                        this.users = users
                    }
                })
            },

            deleteUser : function(user) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/deleteUser.action",
                    type : "get",
                    data : {userId : user.id},
                    success : (userId) => {
                        if(userId === user.id) {
                            for(let i = 0; i<this.users.length; i++) {
                                if(this.users[i].id === userId) {
                                    this.users.splice(i, 1)
                                    return
                                }
                            }
                        }
                    }
                })
            },

            goAddUser : function() {
                $("#myModal").modal("show")
            },

            addUser : function() {
                var usernameReg = /[\u4e00-\u9fa5\w]{1,10}/
                var passwordReg = /\w{6,20}/
                if(usernameReg.test(this.username) && passwordReg.test(this.password)) {
                    $.ajax({
                        url : "${pageContext.request.contextPath}/rooter/addUser.action",
                        type : "post",
                        data : {type : this.userType, username : this.username, password : this.password},
                        success :  (userId) => {
                            this.$set(this.users, this.users.length, {
                                username : this.username,
                                type : this.type,
                                id : userId
                            })
                            this.username = ""
                            this.password = ""
                            this.type = 1
                        }
                    })
                    $("#myModal").modal("hide")
                } else {
                    alert("用户名或者密码格式错误")
                }
            }
        },
        filters : {
            userTypeFilter : function(type) {
                return type === 0 ? "管理员" : "用户"
            }
        }
    })
</script>
</html>
