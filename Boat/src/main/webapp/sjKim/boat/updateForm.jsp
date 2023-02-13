<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>회원관리 시스템 회원수정 페이지</title>
<link href="${pageContext.request.contextPath}/sjKim/css/update.css" rel="stylesheet" type="text/css">
<style>

span{
		font-size: 15px;
		margin-bottom: 10px;
	}
</style>

<script src="${pageContext.request.contextPath}/sjKim/js/jquery-3.6.3.js"></script>
<script src="${pageContext.request.contextPath}/sjKim/js/join.js"></script>
<script src="${pageContext.request.contextPath}/sjKim/js/submit.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>

<body>
	
	<form name = "joinform" id="joinform" action="updateProcess.net" method="post" enctype="multipart/form-data">
		<div class="container">
		<fieldset>
			<legend>내 정보 수정</legend>
				<div class="top_block1">
						<label for="id" >사원번호</label>
						<input type='text' name='empno' id='empno' style="width:550px" value="${memberinfo.empno}" readonly>
					
						<label for="dept" style="padding-top: 10px;">부서명</label>
						<input type='text' placeholder='부서명을 입력하세요..' name='dept' id='dept' style="width:550px;" value="${memberinfo.dept}" >
						
						<label for="deptno" style="padding-top: 10px;">부서번호</label>
						<input type='text' placeholder='부서번호를 입력하세요..' name='deptno' id='deptno' style="width:550px;" value="${memberinfo.deptno}">
					
						<label for="name" style="padding-top: 10px;">이름</label>
						<input type='text' placeholder='성함을 입력하세요..' name='name' id='name' style="width:550px;" value="${memberinfo.name}">
						
						<label for="age" style="padding-top: 10px;">나이</label>
						<input type='text' placeholder='나이를 입력하세요..' name='age' id='age' style="width:550px;" maxLength="3" value="${memberinfo.age}" required>
						<span id="message"></span>
				</div>
				
				<div class="top_block2">
					<label style="text-align: center; margin-top:50px;">
						<span id="filename">${memberinfo.memberfile}</span>
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
					<input type='password' name='password' value="${memberinfo.password}" readonly>	
						
					<label for="jumin">주민번호</label>
					<input type='text' placeholder='주민번호 앞자리'
							name='jumin' id='jumin'  value="${memberinfo.jumin}" > 
					<b>-</b>
					<input type='text' placeholder='주민번호 뒷자리'  
							name='jumin2' id='jumin2' value="●●●●●●●" readonly >
							
					<label for="email">이메일</label>
					<input type='text' name='email' value="${memberinfo.email}" placeholder='Enter email' maxLength="30" required>
					<span id="email_message"></span>
					
							
					<label>성별</label>
					<div class="container2">
						<input type='radio' name='gender' value='남' ><span>남자</span>
						<input type='radio' name='gender' value='여' ><span>여자</span>
					</div>
						
					<label for="post">우편번호</label>
					<input type='text' size='5' maxLength='5' name='post' id='post' value="${memberinfo.post}" readOnly>
					<input type='button' value="우편검색" id="postcode">
				
							
					<label for="address">주소</label>
					<input type='text' size='50' name='address' id='address' value="${memberinfo.address}">
				
				
					<label for="intro">자기소개</label>
					<textarea rows='10' name="intro" id="intro" maxLength="100" value="${memberinfo.intro}"></textarea>
					
					
					<div class= "clearfix">
						<button type="submit" class="submitbtn">수정</button>
						<button type="button" class="cancelbtn">취소</button>
					</div>
					
	   </fieldset>
	  </div>
	</form>
	
	
	<script>
		
		//성별 체크해주는 부분
		
		$("input[value='${memberinfo.gender}']").prop('checked', true);
		
		$(".cancelbtn").click(function(){
			history.back();
		});
		
		//처음 화면 로드시 보여줄 이메일은 이미 체크 완료된 것이므로 기본 checkemail=true입니다.
		let checkemail=true;
		$("input[name=email]").on('keyup', 
				function() {
					$("#email_message").empty();
					//[A-Za-z0-9_]와 동일한 것이 \w입니다.
					//+는 1회 이상 반복을 의미하고 {1,}와 동일합니다.
					//\w+ 는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
					const pattern = /^\w+@\w+[.]\w{3}$/;
					const email = $("input[name=email]").val();
						if (!pattern.test(email)) {
							$("#email_message").css('color', 'red')
										 	   .html("이메일형식이 맞지 않습니다.");
							checkemail=false;
						} else { 
							$("#email_message").css('color', 'green')
											   .html("이메일형식에 맞습니다.");
							checkemail=true;
						}
				}); //email keyup 이벤트 처리 끝
				
		$('form[name=joinform]').submit(function() {
				if(!$.isNumeric($("input[name='age']").val())) {
					alert("나이는 숫자를 입력하세요");
					$("input[name='age']").val('').focus();
					return false;
				}

				if(!checkemail) {
					alert("email 형식을 하세요.");
					$("input:eq(6)").focus();
					return false;
				}
		});//submit
		
		
		$('input[type=file]').change(function(event){
			const inputfile = $(this).val().split('\\');
			const filename = inputfile[inputfile.length - 1]; //inputfile.length -1 = 2
			
			const pattern = /(gif|jpg|jpeg|png)$/i; //i(ignore case)는 대소문자 무시를 의미
			if (pattern.test(filename)){
				$('#filename').text(filename);
				
				const reader = new FileReader(); //파일을 읽기 위한 객체 생성
			
				//DataURL 형식(접두사 data:가 붙은 URL이며 바이너리 파일을 Base64로 인코딩하여 ASCII 문자열 형식으로 변환 것)
				//파일을 읽어옵니다.  (참고-Base64 인코딩은 바이너리 데이터를 Text로 변경하는 Encoding입니다.)
				//읽어온 결과는 reader객체의 result 속성에 저장됩니다.
				//event.target.files[0] : 파일리스트에서 첫번째 객체를 가져옵니다.
				reader.readAsDataURL(event.target.files[0]);
				
				reader.onload = function() { //읽기에 성공했을 때 실행되는 이벤트 핸들러
					$('#showImage > img').attr('src', this.result);
				};
			}else{
				alert('이미지 파일(gif,jpg,jpeg,png)이 아닌 경우는 무시됩니다.');
				$('#filename').text('');
				$('#showImage > img').attr('src', 'image/profile.png');
				$(this).val('')
				$('input[name=check]').val('');
			}
		})//chage()
		
		
	
	</script>
</body>
</html>









