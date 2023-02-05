<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
 <head>
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link href="${pageContext.request.contextPath}/ejYang/css/view.css" type="text/css" rel="stylesheet">
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
    <div id="board-list">
      <table class="board-table">
      	<thead>
          <tr>
          	<th scope="col" class="th-num">제목</th>
          	<th><div id="bname">${boarddata.board_subject}</div></th>
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
 	  	  	  <a href="BoardDetailAction.bo?num=${boarddata.board_num-1}">
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
 	  	  	  <a href="BoardDetailAction.bo?num=${boarddata.board_num+1}">
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
  </div>
  
 </body>
</html>