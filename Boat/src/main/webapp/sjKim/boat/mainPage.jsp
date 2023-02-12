<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<html>
<head>
<jsp:include page="popup.jsp" />
<jsp:include page="header.jsp" />

<style>
body{
	margin-top: 20%;
	margin-right:0;
	margin-left:0;
	margin-bottom:0;
}

h2{
	text-align: center;
}
h2 > span{
	color:#18a8f1;
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
 <link rel="stylesheet" href="jhLee/css/mainpage.css">
 
<title>BOAT 메인페이지</title>
</head>
<body>
<h2> 안녕하세요 <span>BOAT</span>에 오신걸 환영합니다 </h2>
	<div class="body_content">
		
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/map.cal" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">오시는길</span>
				</a>
			</div>
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/MyInfo.my" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">내 정보 보기</span>
				</a>
			</div>
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/MyBoardList.my" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">내 글 보기</span>		
				</a>
					
			</div>
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/MySchedule.my" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">내 할일 보기</span>
				</a>
			</div>
		</div> 
		
			
		<div class="body_content">
		
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/BoardList.bo" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">업무 게시판</span>
				</a>
			</div>
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/FileBoardList.filebo" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">자료실</span>
				</a>
			</div>
			<div class="body_menu">
				<a href="${pageContext.request.contextPath}/project_calendarstart.cal" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">캘린더</span>
				</a>
			</div>
		    <div class="body_menu">
		    	<a href="${pageContext.request.contextPath}/jkKim/address.jk" target="_black">
				<img src="sjKim/image/blue_button.png" >
				<span class="image_text">주소록</span>
				</a>
			</div>
  
		</div> 
</body>
<jsp:include page="footer.jsp" />
</html>