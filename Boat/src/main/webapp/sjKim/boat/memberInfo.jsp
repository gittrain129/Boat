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
				<td>사진업로드</td>
				<td>${memberinfo.memberfile}</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>${memberinfo.empno}</td>
			</tr>
			<tr>
				<td>부서명</td>
				<td>${memberinfo.dept}</td>
			</tr>
			<tr>
				<td>부서번호</td>
				<td>${memberinfo.deptno}</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>${memberinfo.name}</td>
			</tr>
			<tr>
				<td>나이</td>
				<td>${memberinfo.age}</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>${memberinfo.password}</td>
			</tr>
			
			<tr>
				<td>나이</td>
				<td>${memberinfo.age}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${memberinfo.email}</td>
			</tr>
			<tr>
				<td>성별</td>
				<td>${memberinfo.gender}</td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td>${memberinfo.post}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${memberinfo.address}</td>
			</tr>
			<tr>
				<td>자기소개</td>
				<td>${memberinfo.intro}</td>
			</tr>	
			<tr>
				<td colspan=2>
				<a href="memberList.net">리스트로 돌아가기</a></td>				
			</tr>	
		</table>
	</div>
</body>
</html>