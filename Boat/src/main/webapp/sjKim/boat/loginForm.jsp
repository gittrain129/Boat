<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link href="${pageContext.request.contextPath}/sjKim/css/login.css" type="text/css" rel="stylesheet"> 
 	<script src="js/jquery-3.6.3.js"></script>
    <title>로그인</title>
    
     <script>
		 $(function(){
			 	$(".join").click(function() {
			 		location.href = "join.net";
			 	});
			 
				const id = '${id}';
				if(id){
					$("#id").val(id);
					$("#remember").prop('checked', true);
				}
			})
			
		 </script>
  </head>
  <body>
  
    <section class="login">
      <h2 class="logo">       				
		<img src="${pageContext.request.contextPath}/sjKim/image/main_logo.jpg" style="width: 200px; height: 200px;">				
	  </h2>
	  <h3>로그인</h3>
      <ul>
        <form id="login">
          <li>
            <input id="userid" type="text" placeholder="아이디" name="userid" required />
          </li>
          <li>
            <input id="userpw" type="password" placeholder="비밀번호" minlength="10" name="userpw"  required />
          </li>
          <li>
            <input type="checkbox" id="chk_id" name="chk_id" /><label for="chk_id">아이디저장</label>
          </li>
          <li><input type="submit" value="로그인" /></li>
        </form>
      </ul>
      <div>
        <ul>
          <li><a href="${pageContext.request.contextPath}/join.net" target="_self">회원가입</a></li>
          <li><a href="">아이디 찾기</a></li>
          <li><a href="">비밀번호 찾기</a></li>
        </ul>
      </div>
    </section>
  </body>
  <jsp:include page="footer.jsp" />
</html>