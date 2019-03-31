<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="HandheldFriendly" content="true">

	<title>阳煤集团</title>
	<link rel="shortcut icon" href="../static/image/logo.ico">
	<link rel="stylesheet" type="text/css" href="./articleList_files/common.css">
	<link rel="stylesheet" type="text/css" href="./articleList_files/iconfont.css">
	<link rel="stylesheet" type="text/css" href="./articleList_files/cultural.css">
	<link rel="stylesheet" type="text/css" href="./articleList_files/slideProjector__function.css">
	<script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
	<link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

	<script src="../plugins/vue/dist/vue.js"></script>
	<script src="../plugins/jquery/jquery.min.js"></script>

	<script src="../plugins/toast/js/toast.js"></script>
	<link rel="stylesheet" type="text/css" href="../plugins/toast/css/toast.css"/>
</head>
<body>

<div id="vue">
	<div class="clearfix"></div>
	<!-- newsCenter -->
	<div class="content" style="margin-top:100px">
		<div class="col-xs-8">
			<h3 style="text-align: center">{{article.title}}</h3>
			<div style="margin-top: 40px;" v-html="article.content">
			</div>
		</div>
		<div class="col-xs-3 col-xs-offset-1">
			<table class="table table-striped">
				<tbody>
				<tr v-for="file in files">
					<td style="cursor: pointer" class="text-info" @click="downLoad(file.url)">{{file.fileName}}</td>
					<td>{{file.time | dateFormat}}</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="clearfix"></div>


	<!-- footer -->
	<div class="footer">
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
		created : function() {
            this.loadModels()
			this.loadArticle()
		},
		data : {
			models : [],
			article : [],
			files : [],
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

			loadArticle : function() {
                [key, value] = window.location.search.substr(1).split("=")
				$.ajax({
                    url : "${pageContext.request.contextPath}/user/loadArticle.action?articleId=" + value,
                    type : "get",
                    dataType : "json",
					success : function(data) {
						vue.article = data.article
						vue.files = data.attachments
					}
				})
			},
            goMenu : function(modelId) {
                window.open("${pageContext.request.contextPath}/page/menuHome.jsp?modelId=" + modelId)
            },
		},
		filters : {
            dateFormat : function(time) {
                let date = new Date(time)
				return date.getMonth() + "-" + date.getDate()
			}
        }
	})
</script>