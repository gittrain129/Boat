<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
<script src="${pageContext.request.contextPath}/ex8_db/_4.join/js/jquery-3.6.3.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/ex8_db/_4.join/js/validate.js" charset="euc-kr"></script>
</head>

<body>
	<form name='myform' method="post" action='join_ok' id='myform' >
	  <div class="container">
		
		<div class="logo">       				
			<img src="${pageContext.request.contextPath}/sjKim/image/main_logo.jpg" style="width: 200px; height: 200px;">				
	 	</div>
	 	
		<fieldset>
			<legend>회원가입</legend>
				<label for="id">ID</label>
				<div>
					<input type='text' placeholder='Enter id' name='id' id='id' >
					<input type='button' value="ID중복검사" id="idcheck"><input type="hidden" id="result">
					<div id="opener_message"></div>
				</div>
				
				
				<label for="pass">Password</label>
					<input type='password' placeholder='Enter Password' name='pass' id='pass' >
				
					
				<label for="jumin1">주민번호</label>
					<input type='text' placeholder='주민번호 앞자리' maxLength="6" 
							name='jumin1' id='jumin1'  > 
					<b>-</b>
					<input type='text' placeholder='주민번호 뒷자리' maxLength="7" 
							name='jumin2' id='jumin2'  >
							
							
				<label for="email">E-Mail</label>
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

				<label for="post1">우편번호</label>
					<input type='text' size='5' maxLength='5' name='post1' id='post1' readOnly>
					<input type='button' value="우편검색" id="postcode">
				
							
				<label for="address">주소</label>
					<input type='text' size='50' name='address' id='address'>
				
				
				<label for="intro">자기소개</label>
					<textarea rows='10' name="intro" id="intro" maxLength="100"></textarea>
				
				<div class="clearfix">
					<button type="submit" class="signupbtn">회원가입</button>
					<button type="reset"  class="cancelbtn">취소</button>
      			</div>

		</fieldset>
	  </div>
	</form>
</body>
<jsp:include page="footer.jsp" />
</html>