<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<title>error.jsp</title>
<style>
	body{width:320px; margin:3em auto}
	div{
		color:orange;
		font-size:30px;
		text-align:center;
	}
	span{font-size:1.5rem; color:#5d5de2}
	
	#error-image:hover{
	cursor:pointer;
	}
	
</style>
</head>
<body>
	<div>
		<p><img src="${pageContext.request.contextPath}/jkKim/image/logo.jpg" width="100px" id="error-image" onclick="go_home()">
		
		</p>
		<p> 로그인 후 이용해주세요 <br>
			${message}</p>
		<span>서비스 이용에 불편을 드려 &nbsp;&nbsp;&nbsp; 죄송합니다.</span>
	</div>
	<script>
	function go_home(){
		window.location='${pageContext.request.contextPath}/index.jsp';
		
	}
	</script>
	
</body>
</html>