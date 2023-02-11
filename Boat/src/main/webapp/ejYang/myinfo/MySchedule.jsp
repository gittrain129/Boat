<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <script src="${pageContext.request.contextPath}/ejYang/js/schedule.js"></script>
  <link href="${pageContext.request.contextPath}/ejYang/css/schedule.css" type="text/css" rel="stylesheet">
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>내 할일 보기</title>
 </head>
 <body>
   <header>${myinfo.name}의 To-do-List</header> 
   <input type="hidden" id="loginid" value="${empno}" name="loginid"><%-- 본인 자료 가져오기 위해 추가 --%>       
   <div class="wrapper">
        <p>내 일정</p>
        <div class="inputField">
            <input type="text" id="addValue" name="addValue" placeholder="할 일 추가하기"/>
            <button type="submit" id="btn"><img src="${pageContext.request.contextPath}/ejYang/image/plus.png"></button>
        </div>
        <div class="order-list">
        <%-- <c:if test="${todolist != null}">
            <%-- <ul id="addTodo" class="Todolist"> 
            	<input class="form-check-input" type="checkbox" id="result">
                <li><label id='result' for="result">할일</label></li>
                <li><div id='result'>할일2</div></li>
            </ul>--
          <c:forEach var="b" items="${todolist}">
            <input class="form-check-input" type="checkbox" id="${b.t_content}">
            <label class="form-check-label" for="${b.t_content}">${b.t_content}</label>
          </c:forEach>
        </c:if>
        <c:if test="${todolist == null}">
        </c:if>--%>
        </div>
        <div class="graphbar">
        	<%-- <span>일정 현황</span>
        	<progress value="4" max="7"></progress>--%>
        </div>
        <div class="footer">
            <button type="submit" id="submitbtn">완료</button>
            <button type="reset" id="resetbtn">삭제</button>
            <button type="reset" id="allresetbtn">전체삭제</button>
        </div>
        
   </div>
   <jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>