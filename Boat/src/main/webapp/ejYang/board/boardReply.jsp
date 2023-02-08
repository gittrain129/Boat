<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
 <head>
  <title>게시글 답글 쓰기</title>
  <jsp:include page="/sjKim/boat/header.jsp" />
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <script src="${pageContext.request.contextPath}/ejYang/js/reply.js"></script>
  <link href="${pageContext.request.contextPath}/ejYang/css/write.css" type="text/css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/ejYang/js/summernote/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/ejYang/js/summernote/lang/summernote-ko-KR.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
  <script>
  $(document).ready(function(){
		//부서명 자동 선택
		let department = '${member.dept}'
		let part = 1;
		switch(department){
			case '개발팀':
				part=2;
				break;
			case '인사팀':
				part=3;
				break;
			case '기획팀':
				part=4;
				break;
			case '영업팀':
				part=5;
				break;
		}
		$('#select option:nth-child('+part+')').prop('selected',true)
	});
  </script>
 </head>
 <body>
<div class="containers">
<h1>게시글 답글 쓰기</h1>
<div class="container">
  <form action="BoardReplyAction.bo" method="post" name="replyform">
    <input type="hidden" name="board_re_ref" value="${boarddata.board_re_ref}">
 	<input type="hidden" name="board_re_lev" value="${boarddata.board_re_lev}">
 	<input type="hidden" name="board_re_seq" value="${boarddata.board_re_seq}">
    <div class="row">
      <div class="col-25">
        <label for="board_subject">제목</label>
      </div>
      <div class="col-75">
        <input type="text" id="board_subject" name="board_subject" placeholder="제목을 입력하세요."
        value="Re:${boarddata.board_subject}">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="board_name">작성자</label>
      </div>
      <div class="col-75">
        <input type="text" id="board_name" name="board_name" placeholder="성함을 입력하세요."
        value="${member.name}">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="select">부서명</label>
      </div>
      <div class="col-75">
        <select id="select" name="department">
          <option value="홍보팀">홍보팀</option>
          <option value="개발팀">개발팀</option>
          <option value="인사팀">인사팀</option>
          <option value="기획팀">기획팀</option>
          <option value="영업팀">영업팀</option>
        </select>
      </div>
    </div>
        <div class="row">
      <div class="col-25">
        <label for="board_pass">비밀번호</label>
      </div>
      <div class="col-75">
        <input type="password" id="board_pass" name="board_pass" placeholder="비밀번호를 입력하세요.">
      </div>
    </div>
    <div class="row">
        <textarea id="summernote" name="editordata" class="board_content "></textarea>
    </div>
    <div class="row2">
      <input type="submit" value="등록">
      <input type="reset" onclick="history.back()" value="취소">
    </div>
  </form>
 </div>
</div>
  <script>
 	$(function(){
 		$('#board_content').val("${board_data.BOARD_CONTENT}");
 		//여기 아래 부분
		$('#summernote').summernote({
			  height: 300,                 // 에디터 높이
			  lang: "ko-KR",				// 한글 설정
			  placeholder: '내용을 입력하세요.',	//placeholder 설정
				  toolbar: [
			          ['style', ['style']],
			          ['font', ['bold', 'underline', 'clear']],
			          ['color', ['color']],
			          ['para', ['ul', 'ol', 'paragraph']]
			        ]
		});
 	})
  </script>
  <jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>