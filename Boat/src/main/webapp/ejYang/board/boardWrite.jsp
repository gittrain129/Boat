<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
 <head>
  <script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
  <script src="${pageContext.request.contextPath}/ejYang/js/writeform.js"></script>
  <script src="${pageContext.request.contextPath}/ejYang/js/summernote/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/ejYang/js/summernote/lang/summernote-ko-KR.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
  <style>
  	body{
  		background:#bbb
  	}
  	* {
	  box-sizing: border-box;
	}
	.container{
		width:60%;
		margin: auto;
		margin-top: 100px;
	}
	input[type=text],input[type=password], select {
	  width: 100%;
	  padding: 12px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	  resize: vertical;
	}
	
	label {
	  padding: 12px 12px 12px 0;
	  display: inline-block;
	}
	
	input[type=submit] {
	  background-color: #04AA6D;
	  color: white;
	  padding: 16px 20px;
	  border: none;
	  cursor: pointer;
	  width: 20%;
	  margin-top:20px;
	  margin-bottom:10px;
	  opacity: 0.8;
	  display: inline-block;
	}
	
	input[type=reset] {
	  background-color: red;
	  color: white;
	  padding: 16px 20px;
	  border: none;
	  cursor: pointer;
	  width: 20%;
	  margin-top:20px;
	  margin-bottom:10px;
	  opacity: 0.8;
	  display: inline-block;
	}
	
	input[type=submit]:hover, input[type=reset]:hover {
	  opacity: 1;
	}
	
	.row{
		text-align: center;
	}
	
	.container {
	  border-radius: 5px;
	  padding: 20px;
	  background:white
	}
	
	.col-25 {
	  float: left;
	  width: 10%;
	  margin: 6px 0px 0px 20px;
	}
	
	.col-75 {
	  float: left;
	  width: 85%;
	  margin-top: 6px;
	}
	
	/* Clear floats after the columns */
	.row:after {
	  content: "";
	  display: table;
	  clear: both;
	}
	
	/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
	@media screen and (max-width: 600px) {
	  .col-25, .col-75, input[type=submit] {
	    width: 100%;
	    margin-top: 0;
	  }
	}
	
	#summernote{
		margin:auto;
		width:100%;
	}
  </style>
  
 </head>
 <body>
<div class="container">
  <form action="BoardAddAction.bo">
    <div class="row">
      <div class="col-25">
        <label for="fname">제목</label>
      </div>
      <div class="col-75">
        <input type="text" id="board_subject" name="board_subject" placeholder="제목을 입력하세요.">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">작성자</label>
      </div>
      <div class="col-75">
        <input type="text" id="board_name" name="board_name" placeholder="성함을 입력하세요.">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="country">부서명</label>
      </div>
      <div class="col-75">
        <select id="select" name="select">
          <option value="pr">홍보팀</option>
          <option value="dt">개발팀</option>
          <option value="hr">인사팀</option>
          <option value="pt">기획팀</option>
          <option value="st">영업팀</option>
        </select>
      </div>
    </div>
        <div class="row">
      <div class="col-25">
        <label for="lname">비밀번호</label>
      </div>
      <div class="col-75">
        <input type="password" id="board_pass" name="board_pass" placeholder="비밀번호를 입력하세요.">
      </div>
    </div>
    <div class="row">
        <textarea id="summernote" name="editordata" class="board_content"></textarea>
    </div>
    <div class="row">
      <input type="submit" value="등록">
      <input type="reset" value="취소">
    </div>
  </form>
</div>
 <script>
 	$(function(){
 		//여기 아래 부분
		$('#summernote').summernote({
			  height: 300,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  lang: "ko-KR",				// 한글 설정
			  placeholder: '내용을 입력하세요.',	//placeholder 설정
				  toolbar: [
			          ['style', ['style']],
			          ['font', ['bold', 'underline', 'clear']],
			          ['color', ['color']],
			          ['para', ['ul', 'ol', 'paragraph']],
			          ['table', ['table']],
			        ]
		});
 	})
 </script>
 </body>
</html>