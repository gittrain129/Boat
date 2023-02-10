<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>회원관리 시스템 관리자모드(회원정보)</title>
<jsp:include page="header.jsp" />
<style>
	tr>td:nth-child(odd){font-weight: bold}
	td{text-align:center}
	.container{width:50%}
</style>
</head>
<body>
	<div class="container">
		<table class="table table-bordered">
			<tr>
				<td>아이디</td>
				<td>${memberinfo.empno}</td><%-- Member클래스의 --%>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>${memberinfo.password}</td>
			</tr>
			<tr>
				<td>주민번호</td>
				<td>${memberinfo.jumin}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${memberinfo.address}</td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td>${memberinfo.post}</td>
			</tr>
			<tr>
				<td>성별</td>
				<td>${memberinfo.gender}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${memberinfo.email}</td>
			</tr>
			<tr>
				<td>사진업로드</td>
				<td>${memberinfo.memberfile}</td>
			</tr>
			<tr>
				<td>자기소개</td>
				<td>${memberinfo.intro}</td>
			</tr>
			
			
		</table>
	</div>
</body>
</html>