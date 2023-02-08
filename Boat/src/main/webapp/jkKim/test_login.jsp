<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<title>회원관리 시스템 로그인 페이지</title>

<link href="css/login.css" type="text/css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
$(function(){
   
   $(".join").click(function(){

      location.href = "join.net";
   });
   
   
   const id = '${id}';
   if(id){
      $("#id").val(id);
      $("#remember").prop('checked',true);
   }
})
</script>


<style>
   .container{margin:3em auto; border:1px solid lightgray; width:500px;}
</style>

<body>


   <form name ="testloginform" action="home.jk" method="post">
   
      <h1>로그인</h1>
      <hr>
      
      <b>ID</b>
      <input type="text" id="id"  name="id" placeholder="Enter id" required>
      
      <b>Password</b>
      <input type="password"  placeholder="Enter password" name="pass" required>
      <input type="checkbox" id="remember" name="remember" value="store">
      <span>remember</span>
      

      <div class="clearfix">
         <button type="submit" class="submitbtn">로그인</button>
         <button type="button" class="join">회원가입</button>
      </div>
      
   </form>
   
</body>
</html>