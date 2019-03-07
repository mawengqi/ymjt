<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>模块管理</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="../plugins/vue/dist/vue.js"></script>
    <link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div id="vue" class="container-fluid">
    <table class="table table-condensed">
        <thead>
        <tr>
            <th>名称</th>
            <th>展示栏目</th>
            <th>添加栏目</th>
            <th>删除栏目</th>
            <th>删除</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="model in models">
            <td><span>{{model.name}}</span></td>
            <td><span class="text-info" style="cursor: pointer" @click="goShowMenu(model.id)">展示栏目</span></td>
            <td><span class="text-info" style="cursor: pointer" @click="goAddMenu(model.id)">添加栏目</span></td>
            <td><span class="text-danger" style="cursor: pointer" @click="goDeleteMenu(model.id)">删除栏目</span></td>
            <td><span class="text-danger" style="cursor: pointer" @click="deleteModel(model.id)">删除</span></td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <td><span class="text-warning" style="cursor: pointer" @click="goAddModel">添加模块</span></td>
        </tr>
        </tfoot>
    </table>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!--添加模块-->
            <div class="modal-content" v-show="operateId == 0">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        添加模块
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">模块名</label>
                        <div>
                            <input type="text" class="form-control" placeholder="请输入模块名" maxlength="20" v-model="modelName">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" @click="addModel">
                        提交更改
                    </button>
                </div>
            </div><!-- /.modal-content -->
            <!--添加栏目-->
            <div class="modal-content" v-show="operateId == 1">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        添加栏目
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">栏目名</label>
                        <div>
                            <input type="text" class="form-control" placeholder="请输入栏目名" maxlength="20" v-model="menuName">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" @click="addMenu">
                        提交更改
                    </button>
                </div>
            </div><!-- /.modal-content -->
            <!--删除栏目-->
            <div class="modal-content" v-show="operateId == 2">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        删除栏目
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-condensed">
                        <thead>
                        <tr>
                            <th>id</th>
                            <th>栏目名称</th>
                            <th>删除栏目</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="menu in menuList">
                            <template v-if="menu != null">
                                <td><span>{{menu.id}}</span></td>
                                <td><span>{{menu.name}}</span></td>
                                <td><span class="text-danger" style="cursor: pointer" @click="deleteMenu(menu.id)">删除栏目</span></td>
                            </template>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div>
            </div><!-- /.modal-content -->
            <!--展示栏目-->
            <div class="modal-content" v-show="operateId == 3">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        展示栏目
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-condensed">
                        <thead>
                        <tr>
                            <th>栏目名称</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="menu in menuList">
                            <template v-if="menu != null">
                                <td><span>{{menu.name}}</span></td>
                            </template>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div>
            </div><!-- /.modal-content -->

        </div><!-- /.modal -->
    </div>
</div>
</body>
<script>
    var vue = new Vue({
        el : "#vue",
        created : function() {
            //加载模块
            this.loadModel();
        },
        data : {
            models : [],
            //0 为添加模块， 1 增加栏目，2 删除栏目, 3 展示栏目
            operateId : "",
            modelName : "",
            modelId : "",
            menuName : "",
            menuList : [],
        },
        methods : {
            loadModel : function() {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/loadModel.action",
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.models = data
                    }
                })
            },
            //done
            goAddModel : function() {
                this.operateId = 0
                $("#myModal").modal("show")
            },
            //done
            addModel : function() {
                if(/[\u4e00-\u9fa5\w]{1,20}/.test(this.modelName)) {
                    $("#myModal").modal("hide")
                    //发送ajax请求, 返回这条新添加的model,并放到models中
                    $.ajax({
                        url : "${pageContext.request.contextPath}/rooter/addModel.action",
                        type : "post",
                        data : {name : this.modelName},
                        success : function (data) {
                            let id = data
                            vue.models.push({id: id, name: vue.modelName, menuList : []}),
                            vue.modelName = ""
                        }
                    })
                }
            },
            //done
            deleteModel : function(modelId) {
                for(var i = 0; i < this.models.length; i++) {
                    if(this.models[i].id == modelId) {
                        let index = i;
                        //这里需要请求后台,后台确认删除后，前端再执行删除
                        $.ajax({
                            url : "${pageContext.request.contextPath}/rooter/deleteModel.action",
                            type : "get",
                            data : {modelId : modelId},
                            success : function(data) {
                                let id = data
                                if(id == modelId) {
                                    vue.models.splice(index, 1);
                                    return
                                }
                            }
                        })
                    }
                }
            },
            //done
            addMenu : function() {
                if(/[\u4e00-\u9fa5\w]{1,20}/.test(this.menuName)) {
                    $("#myModal").modal("hide")
                    //发送ajax请求, 返回这条新添加的menu,并放到对应的model中
                    for(var i = 0; i < this.models.length; i++) {
                        if(this.models[i].id == this.modelId) {
                            let index = i;
                            $.ajax({
                                url : "${pageContext.request.contextPath}/rooter/addMenu.action",
                                type : "post",
                                data : {modelId : vue.modelId, name : vue.menuName},
                                success : function(data) {
                                    let menuId = data
                                    vue.models[index].menuList.push({id : menuId, name : vue.menuName})
                                    vue.menuName = ""
                                }
                            })
                        }
                    }
                }
            },
            //done
            deleteMenu : function(menuId) {
                //根据modelId, id 删除menu
                $("#myModal").modal("hide")
                //发送ajax请求到服务器，服务器删除menu 后，前端再删除
                for(var i=0;i<this.menuList.length;i++){
                    if(this.menuList[i] == null)
                        continue
                    if(this.menuList[i].id == menuId){
                        let index = i
                        $.ajax({
                            url : "${pageContext.request.contextPath}/rooter/deleteMenu.action",
                            type : "get",
                            data : {modelId : this.modelId, menuId : menuId},
                            success : function (data) {
                                let id = data
                                if(id == menuId){
                                    vue.menuList.splice(index, 1)
                                    $("#myModal").modal("hide")
                                    return
                                }
                            }
                        })
                    }
                }
            },
            //done
            goDeleteMenu : function(modelId) {
                this.operateId = 2
                this.modelId = modelId
                for(var i = 0; i < this.models.length; i++) {
                    if(this.models[i].id == modelId) {
                        this.menuList = this.models[i].menuList
                        $("#myModal").modal("show")
                        return
                    }
                }
            },
            goAddMenu : function(modelId) {
                this.modelId = modelId;
                this.operateId = 1
                $("#myModal").modal("show")
            },
            goShowMenu : function(modelId) {
                this.operateId = 3
                this.modelId = modelId
                for(var i = 0; i < this.models.length; i++) {
                    if(this.models[i].id == modelId) {
                        this.menuList = this.models[i].menuList
                        $("#myModal").modal("show")
                        return
                    }
                }
            }
        }
    })
</script>
</html>
