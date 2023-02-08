<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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

<button onclick="window.open('chatView.jsp','BoaTalk','width=400, height=490, location=no, status=no, scrollbars=yes')">채팅뷰 (window.open)열기</button>
<a href="chat.jk" onclick="window.open(this.href, '_blank', 'width=500, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;">
     ${id }</a>
<button onclick="window.open('Sender.jsp','BoaTalk','width=400, height=450, location=no, status=no, scrollbars=yes')">채팅뷰 (window.open)열기</button>
</div>

<div>
<button type="button" class="address">주소록 창으로 가기</button>
</div>
</body>
</html>