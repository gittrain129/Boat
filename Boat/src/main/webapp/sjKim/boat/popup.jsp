<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
 <head>
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <style>
  	.pop-cont img {margin-bottom: 10px;  width: 300px; height: 400px;}
  	.layerPopup::before {display: block; content: ""; position: fixed; left: 0; top: 0; 
  						 width: 100%; height: 100%; background: rgba(0,0,0,.5); z-index: 900}
  	.pop-box {z-index:1000; position:fixed; left:50%; top:40%; padding:30px; background:white; 
  			  border-radius:5px; position: absolute; transform: translate(-50%,-50%); padding: 15px;}
  	.pop-box .title {margin:10px 0px 10px 0px; padding-bottom:10px; font-weight:600; border-bottom:1px solid #3179fd;}
  	form[name=pop_form] {margin: 5px; font-size:16px; font-weight:600; color:black; weight: 100%; 
  						 height : 30px; line-height:30px; text-decoration:none;}
  	#btn-today {float: left;}
  	#btn-close {float: right;}
  	.layerPopup div {display : inline;}
  	#btn-close a{text-decoration : none; color : black; width: 50px;height : 40px; cursor: pointer;}
  </style>

 </head>
 <body>
 	<div class="layerPopup" id="layerPopup">
      <div class="pop-box">
        <h4 class="title">BOAT 공지사항</h4>
        <div class="pop-cont">
			<img src="${pageContext.request.contextPath}/ejYang/image/popup.jpg" alt="event page">
        </div>
        
        <form name="pop_form">
          <div id="btn-today">
          	<input type="checkbox" name="checktoday" value="checktoday" id='checktoday'>
          	<label for="checktoday">오늘 하루동안 보지 않기</label>
          </div>
		  <div id="btn-close">
		  	<a id="closePop">닫기</a>
		  </div>    
		</form>
	  </div>
	</div>
	
	<script>
	  	var layerPopup = document.querySelector('.layerPopup');
	  	var popbox = document.querySelector('.pop-box');
	  	
	  	//쿠키 생성
		function setCookie(name, value, expiretime, expireminutes) {
		    var date = new Date();
		    date.setHours(date.getHours() + expiretime);
		    date.setMinutes(date.getMinutes() + expireminutes);
		      
		    var mycookie = '';
		    mycookie += name + '=' + value +';';
		    mycookie += 'expires=' + date.toUTCString();
		      
		    document.cookie = mycookie;
		    console.log(date.toUTCString());
		}
		
		//쿠키 삭제
		function delCookie(name) {
		    var date = new Date();
		    date.setDate(date.getDate()-1); 
		      
		    var setCookie = '';
		    setCookie += name + '=Main;';
		    setCookie += 'expires=' + date.toUTCString();
		      
		    document.cookie = setCookie;
		}
		
		//쿠키 확인
		function checkCookie(name) {
		    var cookies = document.cookie.split(';');
		    var visited = false;
		    
		    for(var i=0; i<cookies.length; i++){
		    	if(cookies[i].indexOf(name) > -1){
		    		visited = true;
		    	}
		    }
		    
		    if(visited){
		    	//재방문
		    	layerPopup.style.display='none';
		    }else{
		    	layerPopup.style.display='block';
		    }
		}
		
		checkCookie('BOAT.com');
		
		$(function(){
			$('#closePop').click(function(){
				if($('#checktoday').prop("checked")){
					var tDate = new Date();
					//오늘 하루동안 보지 않기, 팝업 닫고 쿠키 생성
					setCookie('BOAT.com','Main', 23-tDate.getHours(), 60-tDate.getMinutes());
					$('.layerPopup').css('display','none');
				}else{
					$('.layerPopup').css('display','none');
					delCookie('BOAT.com');
				}
			});
		})
   	</script>
 </body>
</html>