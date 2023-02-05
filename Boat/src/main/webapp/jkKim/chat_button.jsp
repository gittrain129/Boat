<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<script>
$(function(){
   
   $(".address").click(function(){

      location.href = "address.jk";
   });
    
})
</script>

<div>
<button onclick="window.open('chatView.jsp','BoaTalk','width=400, height=450, location=no, status=no, scrollbars=yes')">채팅뷰 (window.open)열기</button>
<button onclick="window.open('Sender.jsp','BoaTalk','width=400, height=450, location=no, status=no, scrollbars=yes')">채팅뷰 (window.open)열기</button>
</div>

<div>
<button type="button" class="address">주소록 창으로 가기</button>
</div>
</body>
</html>