<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<html>
<head>
<title>회원관리 시스템 관리자모드(회원정보)</title>
<jsp:include page="header.jsp" />
<style>
	
	.table-bordered td, .table-bordered th {
    border: 2px solid lightgray;
}


	tr>td:nth-child(odd){font-weight: bold}
	td{text-align:center}
	.container{width:50%}
</style>

 <script>
 	$(function() {
 		$("tr[id='delete']").click(function(event) {
 			const answer = confirm("정말 삭제하시겠습니까?");
 			console.log(answer); //취소를 클릭한 경우-false
 			if (!answer) { //취소를 클릭한 경우 
 				event.preventDefault(); //이동하지 않습니다.
 			}
 		})
 	})
 </script>
 
</head>
<body>
	<div class="container" style="margin-top: 20%" >
		<table class="table table-bordered">
			<tr>
				<td colspan=2 style="background-color:#18a8f1; border:none; color:white;">회원상세정보 [관리자모드]</td>				
			</tr>
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
			<br>	
			<tr>
				<td colspan=2 style="background-color:#18a8f1; border:none;">
				<a href="${pageContext.request.contextPath}/jkKim/adminView.jk" style="color:white;">리스트로 돌아가기</a></td>			
			</tr>
			<br>
			<tr id="delete" name="delete">
				<td colspan=2 style="background-color:red; border:none;">
				<a href="${pageContext.request.contextPath}/memberDelete.net?empno=${memberinfo.empno}" style="color:white;">회원 삭제하기</a></td>
			</tr>	
		</table>
	</div>
</body>
</html>