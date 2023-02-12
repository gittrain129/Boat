<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link href="${pageContext.request.contextPath}/sjKim/css/join.css" rel="stylesheet" type="text/css">
<style>
	#opener_message{
		margin-top: -10px;
		margin-bottom: 10px;
	}
</style>

<script src="${pageContext.request.contextPath}/sjKim/js/jquery-3.6.3.js"></script>
<script src="${pageContext.request.contextPath}/sjKim/js/validate.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>

<body>
	<form name='myform' method="post" action='joinProcess.net' id='myform' enctype="multipart/form-data" >
	  <div class="container">
		
		<div class="logo">  
		  <a href="${pageContext.request.contextPath}/index.jsp">      				
			<img src="${pageContext.request.contextPath}/sjKim/image/main_logo.jpg" style="width: 200px; height: 200px;">	
		  </a>			
	 	</div>
	 	
		<fieldset>
			<legend>회원가입</legend>
				<div class="top_block1">
					<label for="id" >사원번호</label>
					<div style="width:600px">
						<input type='text' placeholder='사원번호를 입력하세요..' name='empno' id='empno' style="width:60%">
						<input type='button' value="ID중복검사" id="idcheck" ><input type="hidden" id="result">
						<div id="opener_message"></div>
					</div>
				
					<label for="name" style="padding-top: 10px;">이름</label>
					<input type='text' placeholder='성함을 입력하세요..' name='name' id='name' style="width:550px;" >
					
					<label for="age" style="padding-top: 10px;">나이</label>
					<input type='text' placeholder='나이를 입력하세요..' name='age' id='age' style="width:550px;" >
				</div>
				
				<div class="top_block2">
					<label style="text-align: center; margin-top:50px;">
						
						<span id="showImage">
							<c:if test='${empty memberinfo.memberfile}'>
								<c:set var='src' value='sjKim/image/profile.png'/>
							</c:if>
							<c:if test='${!empty memberinfo.memberfile}'>
								<c:set var='src' value='${"memberupload/"}${memberinfo.memberfile}'/>
								<input type="hidden" name="check" value="${memberinfo.memberfile}"> <%-- 파일이 있는데 변경하지 않은 경우 --%>
							</c:if>
							<img src="${src}" width="130px" alt="profile">	
						</span>
	
							<input type="file" id="memberfile" name="memberfile" accept="image/*" style="display:none;">
							<button type="button" onclick="onClickUpload();" id="f_upload">업로드</button>
					</label>				
				</div>
				
				
				<label for="pass" style="padding-top: 10px;">비밀번호</label>
					<input type='password' placeholder='비밀번호를 입력하세요..' name='password' id='password' >
				
					
				<label for="jumin">주민번호</label>
					<input type='text' placeholder='주민번호 앞자리' maxLength="6" 
							name='jumin' id='jumin'  > 
					<b>-</b>
					<input type='text' placeholder='주민번호 뒷자리' maxLength="7" 
							name='jumin2' id='jumin2'  >
							
							
				<label for="email">이메일</label>
					<input type='text' name='email' id='email'> @
					<input type='text' name='domain' id='domain'>
						<select name='sel' id='sel' >
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						
						
				
				
					
				<label>성별</label>
				<div class="container2"> 
				<!--  type="radio"는 readOnly가 작동하지 않아 onclick="return false"로 해결합니다. -->
					<input type='radio' name='gender' value='m' id='gender1' onclick="return false">남자
					<input type='radio' name='gender' value='f' id='gender2' onclick="return false">여자
				</div>

				<label for="post">우편번호</label>
					<input type='text' size='5' maxLength='5' name='post' id='post' readOnly>
					<input type='button' value="우편검색" id="postcode">
				
							
				<label for="address">주소</label>
					<input type='text' size='50' name='address' id='address'>
				
				
				<label for="intro">자기소개</label>
					<textarea rows='10' name="intro" id="intro" maxLength="100"></textarea>
				
				<div class="clearfix">
					<button type="submit" class="signupbtn">회원가입</button>
					<button type="reset" onClick="location.href='mainPage.net'" class="cancelbtn">취소</button>
      			</div>

		</fieldset>
	  </div>
	</form>
</body>
<jsp:include page="footer.jsp" />
</html>