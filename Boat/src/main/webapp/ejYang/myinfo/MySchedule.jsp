<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <script src="${pageContext.request.contextPath}/ejYang/js/schedule.js"></script>
  <link href="${pageContext.request.contextPath}/ejYang/css/schedule.css" type="text/css" rel="stylesheet">
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>내 일정</title>
 </head>
 <body>
   <header>To-do-List</header>        
   <div class="wrapper">
        <p>내 일정</p>
        <div class="inputField">
            <input type="text" id="addValue" placeholder="할 일 추가하기" autofocus/><!--자동포커스-->
            <button type="submit" id="btn">추가</button>
        </div>
        <div>
        	<input class="form-check-input" type="checkbox" id="result1">
			<label class="form-check-label" for="result1">
			  할일
			</label>
        	<input class="form-check-input" type="checkbox" id="result2">
			<label class="form-check-label" for="result2">
			  할일2
			</label>
            <%-- <ul id="addTodo" class="Todolist"> 
            	<input class="form-check-input" type="checkbox" id="result">
                <li><label id='result' for="result">할일</label></li>
                <li><div id='result'>할일2</div></li>
            </ul>--%>
        </div>
        <div class="footer">
            <button type="button" id="allClear">모두 삭제</button>
        </div>
   </div>
   <script src="${pageContext.request.contextPath}/ejYang/js/list.js"></script>
   <jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>