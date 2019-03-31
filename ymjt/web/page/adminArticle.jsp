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
                <th>附件</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="article in articles">
                <td><span>{{article.title}}</span></td>
                <td><span>{{article.time|dateFilter}}</span></td>
                <td><span style="cursor: pointer" class="text-info" @click="goShowArticle(article)">查看</span></td>
                <td><span style="cursor: pointer" class="text-info" @click="goShowAttachment(article)">附件</span></td>
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
                    <button class="btn btn-info" @click="selectHeadImage">选择封面图</button>
                    <span class="text-info">{{headImageName}}</span>
                    <div class="form-group" style="margin-top: 20px">
                        <label class="control-label text-info">是否作为轮播图</label>
                        <span style="margin-left: 30px;">是 :<input type="radio" value="1" name="isbanner" v-model="isbanner1"/></span>
                        <span style="margin-left: 30px;">否 :<input type="radio" value="0" name="isbanner" v-model="isbanner1"/></span>
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
            <input type="file" style="visibility: hidden" id="headImage" @change = "uploadHeadImage">
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
                    <button class="btn btn-info" @click="selectHeadImage">选择封面图</button>
                    <span class="text-info">{{headImageName}}</span>
                    <div class="form-group" style="margin-top: 20px">
                        <label class="control-label text-info">是否作为轮播图</label>
                        <span style="margin-left: 30px;">是 :<input type="radio" value="1" name="isbanner" v-model="isbanner2"/></span>
                        <span style="margin-left: 30px;">否 :<input type="radio" value="0" name="isbanner" v-model="isbanner2"/></span>
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
                    <span class="text-info pull-left" v-if="article.image != null" @click="downloadAttachment(article.image)" style="cursor: pointer">封面预览</span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div>
            </div><!-- /.modal-content -->
            <!---->展示附件
            <div class="modal-content" v-show="operateId == 3">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        展示附件
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <th>附件名</th>
                                <th>上传时间</th>
                                <th>下载</th>
                                <th>删除</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="attach in attachments">
                                <td><span>{{attach.fileName}}</span></td>
                            <td><span>{{attach.time | dateFilter}}</span></td>
                            <td><span style="cursor: pointer" class="text-info" @click="downloadAttachment(attach.url)">下载</span></td>
                            <td><span style="cursor: pointer" class="text-danger" @click="deleteAttachment(attach.rid)">删除</span></td>
                            </tr>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td><span class="text-warning" style="cursor: pointer" @click="addAttachment">添加附件</span></td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <input type="file" id="file" style="visibility: hidden" @change="uploadAttachment">
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
            //0 为添加文章， 1 修改文章， 2 展示文章, 3 展示附件
            operateId : "",
            editorAdd : "",
            editorChange : "",
            article : "",
            articleContent : "",
            articleTitle : "",
            attachments : [],
            headImageName : "",
            image : null,
            isbanner1 : null,
            isbanner2 : null,
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
                this.image = null
                this.headImageName = null
                this.articleTitle = null
                this.isbanner1 = null
                this.editorAdd.txt.clear()
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
                        data : {title : this.articleTitle, content : this.editorAdd.txt.html(), menuId : this.menuId, image : this.image, imageBanner : this.isbanner1},
                        success : function(data) {
                            let article = {id: data, title: vue.articleTitle, date : new Date().toDateString(), content : vue.editorAdd.txt.html()}
                            vue.articles.push(article)
                        }
                    })
                }
            },
            //查看文章
            goShowArticle : function(article) {
                this.image = null
                this.operateId = 2
                this.isbanner2 = null
                this.article = article
                $("#myModal").modal("show")
            },
            //显示修改文章
            goChangeArticle : function(article) {
                this.image = null
                this.headImageName = null
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
                        data : {title : this.article.title, content : this.editorChange.txt.html(), articleId : this.article.id, image : this.image, imageBanner : this.isbanner2},
                        success : function(data) {
                            $("#myModal").modal("hide")
                            vue.article.content = vue.editorChange.txt.html()
                            vue.article.image = vue.image
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
            },
            goShowAttachment : function(article) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/getAttachments.action?articleId=" + article.id,
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.attachments = data
                        vue.article = article
                        vue.operateId = 3
                        $("#myModal").modal("show")
                    },
                    error : function(err) {
                        alert("请求服务端出错:" + err)
                    }
                })
            },
            addAttachment : function() {
                $("#file").click()
            },
            selectHeadImage : function() {
                $("#headImage").click()
            },
            uploadHeadImage : function() {
                let file = $("#headImage")[0].files[0]
                let formData = new FormData()
                formData.append("file", file);
                $.ajax({
                    url : "${pageContext.request.contextPath}/uploadImage",
                    type : "post",
                    dataType : "json",
                    contentType : false,
                    processData : false,
                    data : formData,
                    success : function(data) {
                        if(data.errno === 0) {
                         vue.image = data.data[0];
                         vue.headImageName = file.name
                        }else {
                            alert("服务器端处理封面图片失败")
                        }
                    },
                    error : function(err) {
                        alert("上传封面图片失败")
                    }
                })
            },
            uploadAttachment : function() {
                let file = $("#file")[0].files[0]
                let formData = new FormData();
                formData.append("file", file)
                //上传文件
                $.ajax({
                    url : "${pageContext.request.contextPath}/uploadAttachment",
                    type : "post",
                    dataType : "json",
                    contentType : false,
                    processData : false,
                    data : formData,
                    success : function(data) {
                        if(data.rid != null) {
                            //上传文件信息到服务端
                            $.ajax({
                                url : "${pageContext.request.contextPath}/rooter/addAttachment.action",
                                type : "post",
                                data : {"attachment.url" : data.url, "attachment.rid" : data.rid, "attachment.fileName" : file.name, "attachment.articleId" : vue.article.id},
                                success : function(result) {
                                    if(result === data.rid) {
                                        vue.attachments.push({rid : data.rid, fileName : file.name, url : data.url, time : new Date()})
                                    }else {
                                        alert("更新文件信息失败")
                                    }
                                },
                                error : function(err) {
                                    alert("更新文件信息失败:" + JSON.stringify(err))
                                }
                            })
                        }else {
                            alert("文件上传失败")
                        }
                    },
                    error : function(err) {
                        alert("上传文件失败:" + JSON.stringify(err))
                    }
                })
            },
            deleteAttachment : function(rid) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/rooter/deleteAttachment.action?rid=" + rid,
                    type : "get",
                    success : function(result) {
                        if(rid === result) {
                            for(let i = 0; i<vue.attachments.length; i++) {
                                if(vue.attachments[i].rid === result) {
                                    vue.attachments.splice(i, 1)
                                    break
                                }
                            }
                        }else {
                            alert("删除附件失败")
                        }
                    },
                    error : function(err) {
                        alert("删除附件失败:" + JSON.stringify(err))
                    }
                })
            },
            downloadAttachment : function(url) {
                window.open(url, "_black")
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
            },
        },
        filters : {
            dateFilter : function(time) {
                return new Date(time).toDateString()
            }
        }
    })
</script>
<script>
    var hooks = {
        before: function (xhr, editor, files) {
            // 图片上传之前触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，files 是选择的图片文件
        },
        success: function (xhr, editor, result) {
            // 图片上传并返回结果，图片插入成功之后触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
        },
        fail: function (xhr, editor, result) {
            alery("服务端处理出错")
        },
        error: function (xhr, editor) {
            alert("上传图片失败")

        },
        timeout: function (xhr, editor) {
            alert("上传超时")
        },
    }

    var E = window.wangEditor
    vue.editorAdd = new E('#editorAdd')
    vue.editorAdd.customConfig.showLinkImg = false
    vue.editorAdd.customConfig.uploadImgServer = "${pageContext.request.contextPath}/uploadImage"
    vue.editorAdd.create()
    vue.editorAdd.customConfig.uploadImgHooks = hooks;

    vue.editorChange = new E("#editorChange")
    vue.editorChange.customConfig.showLinkImg = false
    vue.editorChange.customConfig.uploadImgServer = "${pageContext.request.contextPath}/uploadImage"
    vue.editorChange.create()
    vue.editorChange.customConfig.uploadImgHooks = hooks;
</script>
</html>
