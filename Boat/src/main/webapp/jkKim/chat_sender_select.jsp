<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>

<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath}/jkKim/css/chat_sender_select.css" type="text/css" rel="stylesheet">
 <script src=${pageContext.request.contextPath}/jkKim/js/chat_selector2.js></script>

</head>
<style>
div.icon{
 position: relative;
    overflow: hidden;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #eee;
    margin: 0.3125rem; /* 5px (16px 브라우저 기준) */
    margin-left: 0.625rem;
}

div.icon i {
    position: absolute;
    top: 00px;
    left: 50%;
    font-size: 2.5rem;
    color: #aaa;
    transform: translateX(-50%);
    
}
body > div > ul > li{
	border-top: 1px solid rgb(202, 200, 200);
    padding-top: 0.625rem;
}


</style>
<body>

<div>
   <div class="profile-title">
   <h2>사원</h2>
   <p><c:out value="${listcount }"></c:out></p>
   </div>
 <ul>
 <c:forEach var="m" items="${memberlist }">
 	
			 <li id="lili" value="${m.rownum }">
			 <input type="hidden" class="hidden_v" value="${m.name }">
			 	  <div class="icon"><i class="fa-solid fa-user">
			 	  <img src="${pageContext.request.contextPath}${m.imgsrc}" alt="">
			 	  </i></div>
                  
                  <div class="profile">
                  <p>${m.name }</p>
                  <p>조장 ${m.dept }</p>
                  </div>
                  
           </li>

   
        </c:forEach>
</ul>
</div>




</body>
</html>