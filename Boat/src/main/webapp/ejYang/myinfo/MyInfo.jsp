<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link href="${pageContext.request.contextPath}/ejYang/css/myinfo.css" type="text/css" rel="stylesheet">
  <%--<script src="${pageContext.request.contextPath}/ejYang/js/myinfo.js"></script>--%>
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>내 정보 보기</title>
 </head>
 
 <body>
 	<div class="info-h2">
 	<h1>내 정보 보기</h1>
 	</div>
 	<div class="info-wrap">
 	<div class="info">
 	<section>
 		<h1>${myinfo.dept}</h1>
 		<h2>&nbsp;</h2>
	 	<div class="memberfile">
	 		<c:if test="${myinfo.memberfile == null}">
		 		<img src="image/ano.png">
	 		</c:if>
	 		<c:if test="${myinfo.memberfile != null}">
		 		<img src="memberupload/${myinfo.memberfile}">
	 		</c:if>
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
			<c:if test="${myinfo.gender == 'm'}">
				<p>성별 : 남자</p>
			</c:if>
			<c:if test="${myinfo.gender == 'f'}">
				<p>성별 : 여자</p>
			</c:if>
			<p>주소 : ${myinfo.address}</p><br>
		</section>
		<%--<div class="dropdown_inout">						
            <select id="inout" name="inout" required autofocus>
            	<option value="" selected disabled hidden>출근현황</option>
				<option style= "background-color: #18a8f1" value="출근">출근</option>
				<option style= "background-color: #f5de16" value="외출">외출</option>
				<option style= "background-color: #ff5858" value="퇴근">퇴근</option>
			</select>
	    </div> --%>
		<section class="alt2">
			<h2>근태관리</h2>
			출근시간 : <span id="work"></span><p></p>
			외   출 : <span id="out"></span><p></p>
			복   귀 : <span id="outin"></span><p></p>
			퇴근시간 : <span id="leaves"></span><p></p>
		</section>
		<section>
			<button class="infomodify">내 정보 수정</button>
		</section>
	</section>
	</div>
	</div>
 <script>
	//내 정보 수정으로 이동
	$('.infomodify').click(function(){
		location.href="memberUpdate.net";
	});
 </script>
 <jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>