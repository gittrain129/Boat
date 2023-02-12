<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link href="${pageContext.request.contextPath}/ejYang/css/mylist.css" type="text/css" rel="stylesheet">
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>내 글 보기</title>
 </head>
 <body>
<section class="notice">
    <%-- 게시글이 있는 경우 --%>
    <c:if test="${listcount > 0 }">
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
                    <th scope="col" class="th-cate">카테고리</th>
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
                    	<c:if test="${b.board_notice != 'Y'}">
	                    	<c:out value="${b.board_num}"/>
	                    </c:if>
                    </td>
                    <td>
	                    <c:choose>
                    		<c:when test="${b.board_notice == 'Y'}">
                    			<c:out value="업무 게시판"/>
                    		</c:when>
                    		<c:when test="${b.board_notice == 'N'}">
                    			<c:out value="업무 게시판"/>
                    		</c:when>
                    		<c:otherwise>	
                    			<c:out value="자료실 게시판"/>
					 	    </c:otherwise>
                    	</c:choose>
                    </td>
                    <td class="title-td">
                      <div>
                      	<c:choose>
                    		<c:when test="${b.board_notice == 'Y'}">
                    			<%-- 제목이 너무 길면 '...'으로 처리 --%>
			 		      	  	<a href="BoardDetailAction.bo?num=${b.board_num}">
			 		      	  		<c:if test="${b.board_subject.length()>=20}">
			 		      	  		  <c:out value="${b.board_subject.substring(0,20)}..."/>
			 		      	  		</c:if>
			 		      	  		<c:if test="${b.board_subject.length()<20}">
			 		      	  		  <c:out value="${b.board_subject}"/>
			 		      	  		</c:if>
			 		      	  	</a>
                    		</c:when>
                    		<c:when test="${b.board_notice == 'N'}">
                    			<%-- 제목이 너무 길면 '...'으로 처리 --%>
			 		      	  	<a href="BoardDetailAction.bo?num=${b.board_num}">
			 		      	  		<c:if test="${b.board_subject.length()>=20}">
			 		      	  		  <c:out value="${b.board_subject.substring(0,20)}..."/>
			 		      	  		</c:if>
			 		      	  		<c:if test="${b.board_subject.length()<20}">
			 		      	  		  <c:out value="${b.board_subject}"/>
			 		      	  		</c:if>
			 		      	  	</a>
                    		</c:when>
                    		<c:otherwise>	
                    			<%-- 제목이 너무 길면 '...'으로 처리 --%>
			 		      	  	<a href="FileBoadDetailAction.filebo?num=${b.board_num}">
			 		      	  		<c:if test="${b.board_subject.length()>=20}">
			 		      	  		  <c:out value="${b.board_subject.substring(0,20)}..."/>
			 		      	  		</c:if>
			 		      	  		<c:if test="${b.board_subject.length()<20}">
			 		      	  		  <c:out value="${b.board_subject}"/>
			 		      	  		</c:if>
			 		      	  	</a>
					 	    </c:otherwise>
                    	</c:choose>
	 		      	  	&nbsp;[${b.cnt}]
	 		      	  	<c:if test="${b.board_date > nowday}">
	 		      	  		<img src="${pageContext.request.contextPath}/ejYang/image/new.jpg" id="new">
	 		      	  	</c:if>
	 		      	  	<c:choose>
                    		<c:when test="${b.board_notice == 'Y'}">
                    		</c:when>
                    		<c:when test="${b.board_notice == 'N'}">
                    		</c:when>
                    		<c:otherwise>	
                    			<img src="${pageContext.request.contextPath}/ejYang/image/download.png" id="file">
					 	    </c:otherwise>
                    	</c:choose>
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
			      <a class="arrow prev" href="MyBoardList.my?page=${page-1}"></a>
			     </c:if>
			     
			     <c:forEach var="a" begin="${startpage}" end="${endpage}">
 					<c:if test="${a == page }">
 						<a class="page-link active">${a}</a>
 					</c:if>
 					<c:if test="${a != page }">
					 	<a href="MyBoardList.my?page=${a}" class="page-link">${a}</a>
 					</c:if>
 				 </c:forEach>
 				 
 				 <c:if test="${page >= maxpage }">
			      <a class="arrow next gray"></a>
 				 </c:if>
 				 <c:if test="${page < maxpage }">
			      <a class="arrow next" href="MyBoardList.my?page=${page+1}"></a>
 				 </c:if>
			   </div>
			</div>	
			<%-- 페이징 --%>
			
				
        </div>
    </div>
    </c:if>
    
    <%-- 게시글이 없는 경우 --%>
 	<c:if test="${listcount == 0 }">
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
                    <th scope="col" class="th-cate">카테고리</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-dept">부서</th>
                    <th scope="col" class="th-name">작성자</th>
                    <th scope="col" class="th-count">조회수</th>
                    <th scope="col" class="th-date">작성일</th>
                </tr>
                </thead>
             </table>
        </div>
    </div>
 	<br><h3 style="text-align:center">등록된 글이 없습니다.</h3>
 	</c:if>
</section>
<jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>