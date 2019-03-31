<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="HandheldFriendly" content="true">

	<title>阳煤集团</title>
	<link rel="shortcut icon" href="../static/image/logo.ico">
	<link rel="stylesheet" type="text/css" href="./articleList_files/common.css">
	<link rel="stylesheet" type="text/css" href="./articleList_files/iconfont.css">
	<link rel="stylesheet" type="text/css" href="./articleList_files/cultural.css">
	<link rel="stylesheet" type="text/css" href="./articleList_files/slideProjector__function.css">

	<script src="../plugins/vue/dist/vue.js"></script>
	<script src="../plugins/jquery/jquery.min.js"></script>

	<script src="../plugins/toast/js/toast.js"></script>
	<link rel="stylesheet" type="text/css" href="../plugins/toast/css/toast.css"/>
</head>
<body>
	<div id="vue">
		<div class="clearfix"></div>

		<!-- bgImg -->
		<div class="bgImg">
			<div class="imgBox">
				<i class="mask"></i>
			</div>
			<h1 class="headerTitle">{{menuName}}</h1>
		</div>

		<div class="clearfix"></div>

		<!-- newsCenter -->
		<div class="newsCenter">
			<div class="content">
				<div class="notice" style="width: 100%">
					<div class="title">
						<h2><span class="iconfont"></span>动态</h2>
					</div>
					<div class="noticeList">
						<ul>
							<li v-for="article in articles">
								<a href="#" @click="goArticle(article.id)">
									<div class="time">
										<h2>{{article.time | dateFormatDate}}</h2>
										<p>{{article.time | dateFormatMonth}}</p>
									</div>
									<h3 class="mainTitle">
										{{article.title}}
									</h3>
								</a>
							</li>
						</ul>
						<div class="more">
							<a  @click="prePage" style="cursor: pointer;">上一页<span></span></a>
							<a  @click="nextPage" style="cursor: pointer;">下一页<span></span></a>
						</div>
					</div>
				</div>
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
								<p><span class="iconfont"></span>官网:www.ymjt.com.cn</p>
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
        created : function () {
            this.loadModels()
            this.nextPage()
        },
        data : {
            models : [],
            articles : [],
            menuName : null,
			pageNumber : -1,
			pageNumbetFlag : true,
        },
        methods : {
            loadModels : function() {
                [key, value] = window.location.search.substr(1).split("=")
                $.ajax({
                    url : "${pageContext.request.contextPath}/user/loadModel.action",
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.models = data
						for(let model of data)
						    for(let menu of model.menuList) {
						        if(menu.id === value) {
									vue.menuName = menu.name
									break
                                }
                            }
                    }
                })
            },
            goMenu : function(modelId) {
                window.open("${pageContext.request.contextPath}/page/menuHome.jsp?modelId=" + modelId)
            },
            goArticleList : function(menuId) {
                window.open("${pageContext.request.contextPath}/page/articleList.jsp?menuId=" + menuId)
            },
			nextPage : function() {
                [key, value] = window.location.search.substr(1).split("=")
                this.pageNumber++
                $.ajax({
                    url : "${pageContext.request.contextPath}/user/loadArticleList.action?menuId=" + value + "&pageNumber=" + this.pageNumber,
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        if(!vue.pageNumbetFlag) {
                            if(data.length === 0) {
                                vue.pageNumber--
                                $("body").toast({
                                    content:'已经到尾',
                                    duration:3000
                                })
                                return
                            }
                        }
                        vue.articles = data
						vue.pageNumbetFlag = false
                    }
                })
			},
			prePage : function() {
                [key, value] = window.location.search.substr(1).split("=")
				if(this.pageNumber === 0) {
                    $('body').toast({
                        content:'已经到头',
                        duration:3000
                    });
                    return
				}
				this.pageNumber--
                $.ajax({
                    url : "${pageContext.request.contextPath}/user/loadArticleList.action?menuId=" + value + "&pageNumber=" + this.pageNumber,
                    type : "get",
                    dataType : "json",
                    success : function(data) {
                        vue.articles = data
                    }
                })
			},
            goArticle : function(articleId) {
                window.open("${pageContext.request.contextPath}/page/article.jsp?articleId=" + articleId)
			}
        },
		filters : {
            dateFormatDate : function(time) {
                return new Date(time).getDate()
			},
            dateFormatMonth : function (time) {
				return new Date(time).getMonth() + "月"
            }
		}
    })
</script>