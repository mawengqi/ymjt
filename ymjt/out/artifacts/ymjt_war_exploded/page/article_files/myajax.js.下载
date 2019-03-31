//创建XMLHttpRequest对象
function myXMLHttpRequest() {
	var xmlHttp = null;
	try {
		//fireFox opera safari
		xmlHttp = new XMLHttpRequest();
	} catch(e) {
		try {
			//IE
			xmlHttp = new ActiveObject("Msxml2.XMLHTTP");
		} catch(e) {
			try {
				xmlHttp = new ActiveObject("Microsoft.XMLHTTP");
			} catch(e){}
		}
	}
	return xmlHttp;
}
//理论上的执行顺序：1-4-3-2，但是为了获得全部的状态码，实际调整后的执行顺序应该是1-2-3-4
//连接的例子程序
//当页面加载完毕之后执行以下代码
window.onload = function() {
	//GET方式调用ajax
	document.getElementById("ok").onclick = function() {
		/**
		 * 创建XMLHttpRequest对象
		 */
		var xhr = myXMLHttpRequest();
		
		/**
		 * 2、服务器响应浏览器请求
		 * readyState属性表示Ajax请求的当前状态：
		 * 		0：代表未初始化，还没有调用open方法
		 * 		1：代表正在加载，open方法已被调用，但是send方法还未调用
		 * 		2：代表加载完毕，send方法已被调用，请求已经发送
		 * 		3：代表交互中，服务器正在发送响应
		 * 		4：代表完成，响应发送完毕
		 * 每次readyState值的改变，都会触发readystatechange事件，如果把onreadystatechang事件处理函数赋给一个函数，那么每次readyState值的改变都会引发该函数的执行。
		 * readyState值的变化会因浏览器的不同而有所差异。但是，当请求结束的时候，每个浏览器都会把readyState的值统一设为4
		 * status属性：服务器发送的每一个响应也都带有首部信息。三位数的状态码是服务器发送的响应中最重要的首部信息，并且属于超文本传输协议中的一部分。
		 * 常用状态码及其含义：
		 * 		404：没有找到页面
		 * 		403：禁止访问
		 * 		500：内部服务器出错
		 * 		200：一切正常
		 * 		304：没有被修改
		 * 在XMLHttpRequest对象中，服务器发送的状态码都保存再status属性里，通过这个值和200及304比较，通常可以确保服务器是否已发送一个成功的响应
		 */
		xhr.onreadystatechange = new function() {
			if(xhr.readyState == 4) {
				if((xmlhttp.status == 200) || (xmlhttp.status == 0) || (xmlhttp.status == 304)) {
					var getData = xhr.responseText;
					alert(getData);
				}
			}
		}
		
		/**
		 * 3、浏览器与服务器建立连接
		 * xhr.open(method,url,asynch)
		 * 		*method：请求类型，类似GET和POST
		 * 		*url：请求路径
		 * 		*asynch：
		 */
		xhr.open("GET","../testServlet?timestamp="+new Date().getTime(),true);
		/**
		 * 4、浏览器向服务器发送请求
		 * 如果浏览器请求的类型是GET类型时，通过send()方法发送请求数据，服务器接收不到
		 * 等价xhr.send(null);
		 */
		xhr.send("a=6&b=3");
	}
	
	//POST方式调用ajax
	document.getElementById("ok").onclick = function() {
		/**
		 * 创建XMLHttpRequest对象
		 */
		var xhr = myXMLHttpRequest();
		
		/**
		 * 2、服务器响应浏览器请求
		 */
		xhr.onreadystatechange = new function() {
			if(xhr.readyState == 4) {
				if((xmlhttp.status == 200) || (xmlhttp.status == 0) || (xmlhttp.status == 304)) {
					var getData = xhr.responseText;
					alert(getData);
				}
			}
		}
		
		/**
		 * 3、浏览器与服务器建立连接
		 */
		xhr.open("POST","../testServlet?timestamp=" + new Date().getTime(),true);
		//如果是POST请求方式，设置请求首部信息
		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		
		/**
		 * 4、浏览器向服务器发送请求
		 * 如果浏览器请求的类型是GET类型时，通过send()方法发送请求数据，服务器接收不到
		 * 
		 */
		//浏览器向服务器发送请求
		xhr.send("a=6&b=3");
	}
}