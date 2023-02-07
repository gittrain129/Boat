<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/ejYang/css/view.css" type="text/css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <jsp:include page="/sjKim/boat/header.jsp" />
  <title>게시글 보기</title>
  <script>
  	$(function(){
	  	$('.gray1').click(function(){
	  		alert("이전글이 없습니다.");
	  	});
	  	$('.gray2').click(function(){
	  		alert("다음글이 없습니다.");
	  	});
  	})
  </script>
 </head>
 <body>
  <div class="containers">
  <h2>업무 게시판</h2>
  <p>업무 게시판 입니다.</p>
    <div id="board-list">
      <table class="board-table">
      	<thead>
          <tr>
          	<th scope="col" class="th-num">제목</th>
          	<th scope="col" class="th-num2"><div id="bname">${boarddata.board_subject}</div></th>
            <th scope="col" class="th-title">${boarddata.board_date}</th>
          </tr>
          <tr>
            <td class="th-count1"></td>
            <td class="th-count2">
            	부서명&nbsp;:&nbsp;${boarddata.board_dept}&emsp;&emsp;작성자&nbsp;:&nbsp;${boarddata.board_name}
            </td>
            <td class="th-count3">
	            <img src="${pageContext.request.contextPath}/ejYang/image/reply.png">댓글&nbsp;${boarddata.cnt}
	            &nbsp;
	            <img src="${pageContext.request.contextPath}/ejYang/image/eye.png">조회&nbsp;${boarddata.board_readcount}
            </td>
          </tr>
        </thead>
        <tbody>
          <tr>
 	  		<td colspan="3" style="padding-right: 0px">
 	  		<div class="form-control"><c:out value="${boarddata.board_content}" escapeXml="false" /></div>
 	  		</td>
 	  	  </tr>
          <tr>
 	  		<td colspan="3" class="center">
 	  		  <a href="BoardList.bo">
 	  	  	  	<button class="btn btn-warning">목록</button>
 	  	  	  </a>
 	  	  	  <a href="BoardReplyView.bo?num=${boarddata.board_num}">
 	  	  	  	<button class="btn btn-success">답변</button>
 	  	  	  </a>
 	  	  	  <a href="BoardModifyView.bo?num=${boarddata.board_num}">
 	  	  	  	<button class="btn btn-info">수정</button>
 	  	  	  </a>
 	  	  	  <%-- href의 주소를 #으로 설정합니다. --%>
 	  	  	  <a href="#">
 	  	  	  	<button class="btn btn-danger" data-toggle="modal"
 	  	  	  			data-target="#myModal">삭제</button>
 	  	  	  </a>
 	  	  </td>
 	  	  </tr>
 	  	    <td colspan="2" class="center2">
 	  	      <c:if test="${prevdata.board_subject != null}">
 	  	  	  <a href="BoardDetailAction.bo?num=${prevdata.board_num}">
 	  	  	  	<button class="btn">이전글</button>
 	  	  	  	${prevdata.board_subject}
 	  	  	  </a>
 	  	  	  </c:if>
 	  	  	  <c:if test="${prevdata.board_subject == null}">
 	  	  	  <button class="btn gray1">이전글</button>
 	  	  	  </c:if>
 	  	    </td>
 	  	    <td class="center3">
 	  	      <c:if test="${nextdata.board_subject != null}">
 	  	  	  <a href="BoardDetailAction.bo?num=${nextdata.board_num}">
 	  	  	  	${nextdata.board_subject}
 	  	  	  	<button class="btn">다음글</button>
 	  	  	  </a>
 	  	  	  </c:if>
 	  	      <c:if test="${nextdata.board_subject == null}">
 	  	  	  <button class="btn gray2">다음글</button>
 	  	  	  </c:if>
 	  	    </td>
          <tr>
 	  	  </tr>
        </tbody>
      </table>
    </div>
    
    <%-- modal 시작 --%>
 	  <div class="modal" id="myModal">
 	  	<div class="modal-dialog">
      	  <div class="modal-content">
        	<!-- Modal body -->
        	<div class="modal-body">
        	  <form name="deleteForm" action="BoardDeleteAction.bo" method="post">
        	  	<input type="hidden" name="num" value="${boarddata.board_num}" id="comment_board_num">
        	  	<div class="form-group">
        	  		<label for="pwd">비밀번호</label>
        	  		<input type="password"
        	  			   class="form-control" placeholder="Enter password"
        	  			   name="board_pass" id="board_pass">
        	  	</div>
        	  	<button type="submit" class="btn btn-primary">전송</button>
 	  	  		<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        	  </form>
        	</div>
          </div>
      	</div>
      </div>
    <%-- id="myModal" end --%>
  </div>
  <jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>