<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<html>
<head>
<jsp:include page="header.jsp" />
<jsp:include page="popup.jsp" />

<style>
body{
	margin-top: 20%;
}

.body_content {
	width: 100%;
	/*min-height:700px;*/
	text-align: center; 
	overflow: hidden;
	display: flex;
	justify-content: center;
}

.body_menu {
	height: 40%; 
	display: inline-block; 
	vertical-align: middle;
	position: relative;
	margin:15px;
	
}

.image_text {
    position: absolute;
    color: white;
    z-index:1;
    top:270px;
    left:85px;
    font-size: 18px;
    width: 120px;
    font-weight: bold;
  }
 
.body_menu img {
	width: 235px;
	padding: 30px;	
	display:block;
	margin:auto;
}

a {
	width: 200px;
	text-decoration: none;
	color: black;
}

</style>
<title>BOAT 메인페이지</title>
</head>
<body>
<h1> 메인 페이지 </h1>
	<div class="body_content">
		
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">오시는길</span>
			</div>
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">내 정보 보기</span>
			</div>
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">내 글 보기</span>		
					
			</div>
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">내 일정 보기</span>
			</div>
		</div> 
		
			
		<div class="body_content">
		
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">업무 게시판</span>
			</div>
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">자료실</span>
			</div>
			<div class="body_menu">
				<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">캘린더</span>
			</div>
		    <div class="body_menu">
		    	<a href="https://www.naver.com" target="_black">
				<img src="sjKim/image/blue_button.png" >
				</a>
				<span class="image_text">주소록</span>
			</div>
  
		</div> 
</body>
<jsp:include page="footer.jsp" />
</html>