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
			 
				const empno = '${empno}';
				if(empno){
					$("#empno").val(empno);
					$("#remember").prop('checked', true);
				}
			})
			
		 </script>
  </head>
  <body>
  
    <section class="login">
      <h2 class="logo">  
       <a href="${pageContext.request.contextPath}/index.jsp">     				
		<img src="${pageContext.request.contextPath}/sjKim/image/main_logo.jpg" style="width: 200px; height: 200px;">	
	   </a>			
	  </h2>
	  <h3>로그인</h3>
      <ul>
        <form id="login" name="loginform" action="loginProcess.net" method="post">
          <li>
            <input id="empno" type="text" placeholder="사원번호" name="empno" required />
          </li>
          <li>
            <input id="password" type="password" placeholder="비밀번호" minLength="4" name="password"  required />
          </li>
          <li>
            <input type="checkbox" id="remember" name="remember" value="store"/><label for="chk_id">아이디저장</label>
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