<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link href="${pageContext.request.contextPath}/ejYang/css/myinfo.css" type="text/css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/ejYang/js/list.js"></script>
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>내 정보 보기</title>
 </head>
 <body>
 	<div class="info-wrap">
 	<div class="info">
 	<section>
 		<h1>${myinfo.dept}</h1>
 		<h2>팀장</h2>
	 	<div class="memberfile">
	 		<img src="${pageContext.request.contextPath}/ejYang/image/profile.png">
		</div>
	</section>
	</div>
	
	<div class="info">
	<section class="split contact">
		<section class="alt">
			<h2>내 정보</h2>
			<p>이름 : ${myinfo.name}</p>
			<p>생년월일 : ${myinfo.jumin.substring(0,6)}</p>
			<p>메일주소 : ${myinfo.email}</p>
			<p>성별 : ${myinfo.gender}</p>
			<p>주소 : ${myinfo.address}</p><br>
		</section>
		<section>
			<h2>근태관리</h2>
			<p>출근시간 : </p>
			<p>외   출 : </p>
			<p>퇴근시간 : </p>
			<p>주 근무 시간 : </p>
		</section>
		<section>
			<button class="infomodify">내 정보 수정</button>
		</section>
	</section>
	</div>
	</div>
 <jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>