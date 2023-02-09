<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link href="${pageContext.request.contextPath}/ejYang/css/list.css" type="text/css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/ejYang/js/list.js"></script>
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>내 글 보기</title>
 </head>
 <body>
<section class="notice">
    <%-- 게시글이 있는 경우 --%>
    <div id="board-search">
        <div class="container">
        <h2>내 글 보기</h2>
        <p></p>
            <div class="search-window">
            <span>총 글 개수 : ${listcount}</span>
            </div>
        </div>
    </div>
   
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-dept">부서</th>
                    <th scope="col" class="th-name">작성자</th>
                    <th scope="col" class="th-count">조회수</th>
                    <th scope="col" class="th-date">작성일</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="num" value="${listcount-(page-1)*limit}"/>
                <c:forEach var="b" items="${boardlist}">
                <tr>
                    <td>
                    	<c:if test="${b.board_notice == 'Y'}">
                    		<c:out value="공지"/>
                    	</c:if>
                    	<c:if test="${b.board_notice == 'N'}">
	                    	<c:out value="${num}"/><c:set var="num" value="${num-1}"/>
                    	</c:if>
                    </td>
                    
                    <td class="title-td"><%-- 제목 --%>
	 		      	  <div>
	 		      	  	<c:if test="${b.board_re_lev != 0}">	<%-- 답글인 경우 --%>
	 		      	  		<c:forEach var="a" begin="0" end="${b.board_re_lev*2}" step="1">
	 		      	  		&nbsp;
	 		      	  		</c:forEach>
	 		      	  		<img src="${pageContext.request.contextPath}/ejYang/image/line.png">
	 		      	  	</c:if>
	 		      	  	
	 		      	  	<c:if test="${b.board_re_lev == 0}">	<%-- 원문인 경우 --%>
	 		      	  		&nbsp;
	 		      	  	</c:if>
	 		      	  	
	 		      	  	<%-- 제목이 너무 길면 '...'으로 처리 --%>
	 		      	  	<a href="BoardDetailAction.bo?num=${b.board_num}">
	 		      	  		<c:if test="${b.board_subject.length()>=20}">
	 		      	  		  <c:out value="${b.board_subject.substring(0,20)}..."/>
	 		      	  		</c:if>
	 		      	  		<c:if test="${b.board_subject.length()<20}">
	 		      	  		  <c:out value="${b.board_subject}"/>
	 		      	  		  
	 		      	  		</c:if>
	 		      	  	</a>&nbsp;[${b.cnt}]
	 		      	  	<c:if test="${b.board_date > nowday}">
	 		      	  		<img src="${pageContext.request.contextPath}/ejYang/image/new.jpg" id="new">
	 		      	  	</c:if>
	 		      	  </div>
	 		      	</td>
                    <td><div>${b.board_dept}</div></td>
                    <td><div>${b.board_name}</div></td>
                    <td><div>${b.board_readcount}</div></td>
 		      		<td><div>${b.board_date}</div></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            
            <%-- 페이징 --%>
            <div class="page_wrap">
			   <div class="page_nation">
			     <c:if test="${page <= 1 }">
			      <a class="arrow prev gray"></a>
			     </c:if>
			     <c:if test="${page > 1 }">
			      <a class="arrow prev" href="BoardList.bo?page=${page-1}"></a>
			     </c:if>
			     
			     <c:forEach var="a" begin="${startpage}" end="${endpage}">
 					<c:if test="${a == page }">
 						<a class="page-link active">${a}</a>
 					</c:if>
 					<c:if test="${a != page }">
					 	<a href="BoardList.bo?page=${a}" class="page-link">${a}</a>
 					</c:if>
 				 </c:forEach>
 				 
 				 <c:if test="${page >= maxpage }">
			      <a class="arrow next gray"></a>
 				 </c:if>
 				 <c:if test="${page < maxpage }">
			      <a class="arrow next" href="BoardList.bo?page=${page+1}"></a>
 				 </c:if>
			   </div>
			</div>	
			<%-- 페이징 --%>
			
				
        </div>
    </div>
</section>
<jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>