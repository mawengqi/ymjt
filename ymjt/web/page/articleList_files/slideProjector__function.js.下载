var tt_slide=(function(){
	
	var content=document.getElementById("slide_projector"),
		slideList=content.getElementsByTagName('ul')[0],
		slideListItem=slideList.getElementsByTagName('li'),
		slideListItemLen=slideListItem.length,
		timer=null,
		index=0,
		controlPointBox=document.getElementById("slide_control_list"),
		controlPoints,
		buttonLeft,
		buttonRight;
	
	/*初始化函数*/
	function init(id){
		
		getWidth();
		addControlPoint();
		addButtonEvent();
		addPointEvent();
		reOnresize(resizeChange);
		startMove();
		
	}
	
	/*为ul和li添加宽度*/
	function getWidth(){
		
		var i=0;
		
		slideList.style.width=slideListItemLen*100+1+'%';
		
		for(i;i<slideListItemLen;i++){
			
			slideListItem[i].style.width=parseInt(content.clientWidth)+'px';
			
		}
		
	}
	
	/*添加控制点*/
	function addControlPoint(){
		
		var i=0;
		for(i;i<slideListItemLen;i++){
			var controlPoint=document.createElement('span');
			controlPointBox.appendChild(controlPoint);
			
		}
		
		controlPoints=controlPointBox.getElementsByTagName('span');
		controlPoints[0].style.backgroundColor='#ffffff'

	}
	
	function addPointEvent(){
		
		var i=0;
		for(i;i<slideListItemLen;i++){
			(function(i){
				
				controlPoints[i].onclick=function(){
					stopMove();
					index=i;
					slideList.style.left=-index*parseInt(slideListItem[0].style.width)+'px';
					controlChangeColor();
					startMove();
				}
				
			})(i);
		}
		
	}
	
	function addButtonEvent(){
		
		buttonLeft=document.getElementById("slide_button_left");
		buttonRight=document.getElementById("slide_button_right");
		buttonLeft.onclick=function(){
			
			stopMove();
			indexReduce();
			slideList.style.left=-index*parseInt(slideListItem[0].style.width)+'px';
			controlChangeColor();
			startMove();
			
		}
		buttonRight.onclick=function(){
			
			stopMove();
			indexAdd();
			slideList.style.left=-index*parseInt(slideListItem[0].style.width)+'px';
			controlChangeColor();
			startMove();
			
		}
		
	}
	
	/*获取样式*/
	function getStyle(obj,attr){
		
		if(window.getComputedStyle){
			
			return getComputedStyle(obj,false)[attr];
			
		}
		else{
			
			return obj.currentStyle[attr];
			
		}
		
	}
	
	/*控制按钮背景变色*/
	function controlChangeColor(){
		
		var i=0;
		for(i;i<controlPoints.length;i++){
			controlPoints[i].style.backgroundColor='#bbbbbb';
		}
		controlPoints[index].style.backgroundColor='#ffffff';
		
	}
	
	/*开始动*/
	function startMove(){
		
		timer=setTimeout(function(){
			
			indexAdd();
			slideList.style.left=-index*parseInt(slideListItem[0].style.width)+'px';
			controlChangeColor();
			startMove();
			
		},5000);
		
	}
	
	/*停止动*/
	function stopMove(){
		
		clearTimeout(timer);
		timer=null;
		
	}
	
	/*index向右*/
	function indexAdd(){
		
		index++;
		if(index>=slideListItemLen){
			
			index=0;
			
		}
		
	}
	
	/*index向左*/
	function indexReduce(){
		
		index--;
		if(index<0){
			
			index=slideListItemLen-1;
			
		}
		
	}
	
	/*重写resize*/
	function reOnresize(fn){
	
		var reResize=window.onresize;
		if(reResize){
			window.onresize=function(){
				reResize();
				fn();
			}
		}
		else{
			window.onresize=function(){
				fn();
			}
		}
		
	}
	/*窗口大小变化的时候*/
	function resizeChange(){
		stopMove();
		getWidth();
		slideList.style.left=-index*parseInt(slideListItem[0].style.width)+'px';
		startMove();
		
	}
	
	
	
	return init;
	
})();