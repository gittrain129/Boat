<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
 <head>
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <link href="${pageContext.request.contextPath}/ejYang/css/view.css" type="text/css" rel="stylesheet">
 </head>
 <body>
  <div class="container">
    <div id="board-list">
      <table class="board-table">
      	<thead>
          <tr>
          	<th scope="col" class="th-num">제목</th>
          	<th><div id="bname">${boarddata.board_subject}</div></th>
            <th scope="col" class="th-title">${boarddata.board_date}</th>
          </tr>
          <tr>
            <td colspan="3" class="th-count">부서명&nbsp;작성자</td>
          </tr>
          <tr>
            <td colspan="3" class="th-count">댓글수&nbsp;조회수</td>
          </tr>
        </thead>
        <tbody>
          <tr>
 	  		<td style="padding-right: 0px">
 	  		<textarea class="form-control" 
 	  				  rows="5" readOnly>${boarddata.board_content}</textarea></td>
 	  	  </tr>
          <tr>
 	  		<td colspan="2" class="center">
 	  	  	  <a href="BoardModifyView.bo?num=${boarddata.board_num}">
 	  	  	  	<button class="btn btn-info">수정</button>
 	  	  	  </a>
 	  	  	  <%-- href의 주소를 #으로 설정합니다. --%>
 	  	  	  <a href="#">
 	  	  	  	<button class="btn btn-danger" data-toggle="modal"
 	  	  	  			data-target="#myModal">삭제</button>
 	  	  	  </a>
 	  	  	  <a href="BoardReplyView.bo?num=${boarddata.board_num}">
 	  	  	  	<button class="btn btn-success">답변</button>
 	  	  	  </a>
 	  	  </td>
 	  	  </tr>
        </tbody>
      </table>
      
      
    </div>
  </div>
 </body>
</html>