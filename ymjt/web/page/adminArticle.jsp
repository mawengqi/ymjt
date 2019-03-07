<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>文章管理</title>
    <script src="../plugins/jquery/jquery.min.js"></script>
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="../plugins/vue/dist/vue.js"></script>
    <link rel="stylesheet" href="../plugins/editor/release/wangEditor.min.css"/>
    <script src="../plugins/editor/release/wangEditor.min.js"></script>
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
                <th>标题</th>
                <th>时间</th>
                <th>查看</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="article in articles">
                <td><span>{{article.title}}</span></td>
                <td><span>{{article.time|dataFilter}}</span></td>
                <td><span style="cursor: pointer" class="text-info" @click="goShowArticle(article)">查看</span></td>
                <td><span style="cursor: pointer" class="text-info" @click="goChangeArticle(article)">修改</span></td>
                <td><span style="cursor: pointer" class="text-danger" @click="deleteArticle(article)">删除</span></td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
                <td><span class="text-warning" style="cursor: pointer" @click="goAddArticle">添加文章</span></td>
            </tr>
            </tfoot>
        </table>
    </div>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!--添加文章-->
            <div class="modal-content" v-show="operateId == 0">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        添加文章
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">标题</label>
                        <div>
                            <input type="text" class="form-control" placeholder="请输入标题" maxlength="20" v-model="articleTitle">
                        </div>
                    </div>
                    <!--富文本编辑-->
                    <div class="form-group">
                        <label class="control-label">内容</label>
                        <div id="editorAdd">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" @click="addArticle">
                        提交更改
                    </button>
                </div>
            </div><!-- /.modal-content -->
            <!--修改文章-->
            <div class="modal-content" v-show="operateId == 1">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        修改文章
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">标题</label>
                        <div>
                            <input type="text" class="form-control" placeholder="请输入标题" maxlength="20" v-model="article.title">
                        </div>
                    </div>
                    <!--富文本编辑-->
                    <div class="form-group">
                        <label class="control-label">内容</label>
                        <div id="editorChange">
                            <div v-html="article.content"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" @click="changeArticle">
                        提交更改
                    </button>
                </div>
            </div><!-- /.modal-content -->
            <!--展示文章-->
            <div class="modal-content" v-show="operateId == 2">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        展示文章
                    </h4>
                </div>
                <div class="modal-body" id="show">
                    <div v-html="article.content"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div>
            </div><!-- /.modal-content -->

        </div>
    </div>

</div>
</body>
<script>
    var vue = new Vue({
        el : "#vue",
        created : function() {
            this.loadModel()
            // this.loadArticles()
        },
        data : {
            articles : [],
            models : [],
            menus : [],
            modelId : 0,
            menuId : 0,
            articleId : "",
            //0 为添加文章， 1 修改文章， 2 展示文章
            operateId : "",
            editorAdd : "",
            editorChange : "",
            article : "",
            articleContent : "",
            articleTitle : "",
        },
        methods : {
            //初始化model
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
            //显示添加文章
            goAddArticle : function() {
                this.operateId = 0
                $("#myModal").modal("show")
            },
            addArticle : function() {
                if(/[\u4e00-\u9fa5\w]{1,20}/.test(this.articleTitle)) {
                    //发送ajax请求, 返回这条新添加的article,并放到articles中
                    $("#myModal").modal("hide")
                    $.ajax({
                        url : "${pageContext.request.contextPath}/rooter/addArticle.action",
                        type : "post",
                        data : {title : this.articleTitle, content : this.editorAdd.txt.html(), menuId : this.menuId},
                        success : function(data) {
                            let article = {id: data, title: vue.articleTitle, title : new Date().toDateString()}
                            vue.articles.push(article)
                        }
                    })
                }
            },
            //查看文章
            goShowArticle : function(article) {
                this.operateId = 2
                this.article = article
                $("#myModal").modal("show")
            },
            //显示修改文章
            goChangeArticle : function(article) {
                this.operateId = 1
                $("#myModal").modal("show")
                this.article = article
            },
            //修改文章
            changeArticle : function() {
                if(/[\u4e00-\u9fa5\w]{1,20}/.test(this.article.title)) {
                    $.ajax({
                        url : "${pageContext.request.contextPath}/rooter/changeArticle.action",
                        type : "post",
                        data : {title : this.article.title, content : this.editorChange.txt.html(), articleId : this.article.id},
                        success : function(data) {
                            $("#myModal").modal("hide")
                            vue.article.content = vue.editorChange.txt.html()
                        }
                    })
                }
            },
            //删除文章
            deleteArticle : function(article) {
                let articleId = article.id
                for(var i = 0; i < this.articles.length; i++) {
                    if(this.articles[i].id == articleId) {
                        //这里需要请求后台,后台确认删除后，前端再执行删除
                        let index = i;
                        $.ajax({
                            url : "${pageContext.request.contextPath}/rooter/deleteArticle.action",
                            type : "get",
                            data : {articleId : articleId},
                            success : function(data) {
                                if(articleId == data) {
                                    vue.articles.splice(index, 1);
                                    return
                                }
                            }
                        })
                    }
                }
            }
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
                    url : "${pageContext.request.contextPath}/rooter/loadArticle.action",
                    type: "get",
                    dataType : "json",
                    data : {menuId : newMenuId},
                    success : function(data) {
                        vue.articles = data
                    }
                })
            }
        },
        filters : {
            dataFilter : function(time) {
                return new Date(time).toDateString()
            }
        }
    })
</script>
<script>
    var E = window.wangEditor
    vue.editorAdd = new E('#editorAdd')
    vue.editorAdd.create()

    vue.editorChange = new E("#editorChange")
    vue.editorChange.create()
</script>
</html>
