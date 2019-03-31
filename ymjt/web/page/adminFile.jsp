<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AdminFile</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="../plugins/vue/dist/vue.js"></script>
    <link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container-fluid" id="vue">
    <div class="row">
        <!--选择模块-->
        <div class="form-group col-xs-4">
            <label>选择模块</label>
            <select class="form-control" v-model="modelId">
                <template  v-for="model in models">
                    <option v-if="model != null" :value="model.id">{{model.name}}</option>
                </template>
            </select>
        </div>
        <!--选择栏目-->
        <div class="form-group col-xs-4">
            <label>选择栏目</label>
            <select class="form-control" v-model="menuId">
                <template v-for="menu in menus">
                    <option v-if="menu != null" :value="menu.id">{{menu.name}}</option>
                </template>
            </select>
        </div>
    </div>

    <!--文章展示-->
    <div class="row">
        <table class="table table-condensed">
            <thead>
            <tr>
                <th>文件名</th>
                <th>上传时间</th>
                <th>下载</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <tr>

            </tr>
            </tbody>
            <tfoot>
            <tr>
                <td><span class="text-warning" style="cursor: pointer" @click="">上传文件</span></td>
            </tr>
            </tfoot>
        </table>
    </div>

</div>
</body>
<script>
    var vue = new Vue({
        el : "#vue",
        created : function() {
            this.loadModel()
        },
        data : {
            models : [],
            modelId : "",
        },
        methods : {
            loadModel : function() {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/loadModel.action",
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.models = data
                        vue.modelId = vue.models[0].id
                    }
                })
            },
        },
        filters : {

        },
        watch : {
            modelId : function(newModelId, oldModelId) {
                for(var i=0; i<this.models.length; i++) {
                    if(this.models[i].id == newModelId) {
                        this.menus = this.models[i].menuList
                        this.menuId = this.models[i].menuList[0].id
                        return
                    }
                }
            },
            //menuId改变，加载相应的文章
            menuId : function(newMenuId, oldMenuId) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/loadFiles.action",
                    type: "get",
                    dataType : "json",
                    data : {menuId : newMenuId},
                    success : function(data) {
                        vue.articles = data
                    }
                })
            }
        }
    })
</script>
</html>
