<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head> 
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link href="${pageContext.request.contextPath}/ejYang/css/list.css" type="text/css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/ejYang/js/list.js"></script>
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>업무 게시판</title>
  <script>
  	$(function(){
  		$("#country").val(0).prop("selected", true);
  		$('input').attr("placeholder", "작성자를 입력하세요.");
  	})
  </script>
 </head>
 <body>
<section class="notice">
    <%-- 게시글이 있는 경우 --%>
    <input type="hidden" name = "loginboard" id = "loginboard" value ="${empno}">
    <div id="board-search">
        <div class="container">
        <h2><a class = "bolist" href="${pageContext.request.contextPath}/BoardList.bo" target="_self">업무 게시판</a></h2>
        <p>업무 게시판 입니다.</p>
            <div class="search-window">
                    <div class="search-wrap">
                    	<select id="country" name="search_field">
				          <option value="0">작성자</option>
				          <option value="1">제목</option>
				        </select>
                        <input id="search_word" type="search" name="search_word" 
                        		placeholder="검색어를 입력해주세요." value="${search_word}">
                    <button type="submit" class="btn btn-dark">검색</button>
                    </div>
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
                    		<c:set var="num" value="${num-1}"/>
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
	 		      	  	
	 		      	  	<c:if test="${!empty empno}">
	 		      	  	<%-- 제목이 너무 길면 '...'으로 처리 --%>
	 		      	  	<a href="BoardDetailAction.bo?num=${b.board_num}">
	 		      	  	</c:if>
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
			   <select id="department" name="department">
		          <option value="selected">부서명</option>
		          <option value="홍보팀">홍보팀</option>
		          <option value="개발팀">개발팀</option>
		          <option value="인사팀">인사팀</option>
		          <option value="기획팀">기획팀</option>
		          <option value="영업팀">영업팀</option>
		       </select>
			   <select id="listse" name="listse">
		          <option value="3" selected>정렬</option>
		          <option value="0">최신순</option>
		          <option value="1">조회순</option>
		          <option value="2">댓글순</option>
		       </select>
			   <button type="submit" class="btn write">글쓰기</button>
			</div>		
        </div>
    </div>
</section>
<jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>