<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/sjKim/boat/header.jsp" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- include summernote css/js -->



    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js" defer></script>

  <link rel="stylesheet" href="jhLee/css/writeform.css">

<script src="${pageContext.request.contextPath}/jhLee/js/writeform.js"></script>

<style>

</style>
 
</head>
<body>
<div class="container">
 <form action="FileBoardAddAction.filebo" method="post" enctype = "multipart/form-data" name ="fileboardform">
 	<h1>boat_  글 수정페이지2</h1>
     <input type="hidden" name="board_num" value="${boarddata.FILE_NUM}">
     
    <div class="form-group">
        <label for="board_subject">제목</label>
        <input name="board_subject" id="board_subject" type="text" maxlength="100"
        class="form-control" placeholder="제목을 입력하세요" value="${boarddata.FILE_SUBJECT }">
    </div>
 	


 	<div class="form-group">
         <label for="board_pass">비밀번호</label>
 		<input name="board_pass" id="fileboard_pass" type="password" maxlength="30"
 		class="form-control" placeholder="비밀번호를 입력하세요" value="${boarddata.FILE_PASS }">
    </div>

 
         <div class="form-group ">
        <label for = "board_name">글쓴이</label><br>
        <div class="btn-group">
            <button type="button" class="btn btn-secondary" id = "deptsel">부서</button>
            <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" id = "deptbutton">
            </button>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">홍보팀</a>
                <a class="dropdown-item" href="#">개발팀</a>
                <a class="dropdown-item" href="#">인사팀</a>
                <a class="dropdown-item" href="#">기획팀</a>
                <a class="dropdown-item" href="#">영업팀</a>
              </div>
            </div>
            <input type="hidden" name = "dept" id = "dept">
       		<input name="board_name" id="board_name" type="text"  class="form-control writer"
       			placeholder="이름을 입력하세요" value="${boarddata.FILE_NAME }">
  	  </div>
    

 	
 		<label for="board_content">내용</label>
 		<textarea name="board_content" id="summernote"  class="form-control"></textarea>
 	
 	<div class="form-group file1">
 		<label>
 		<img alt="파일첨부" src="${pageContext.request.contextPath}/jhLee/image/file.png"> 
 		&nbsp;파일첨부
 		<input name="board_file" id="upfile" type="file">
		 </label>
	 	
 		<span id ="filevalue"></span>
 	</div>
 	<div class="form-group file2">
 		<label>
 		<img alt="파일첨부2" src="${pageContext.request.contextPath}/jhLee/image/file.png">
 		 &nbsp;파일첨부2
 		<input name="board_file2" id="upfile2" type="file">
		 </label>
	 	
 		<span id ="filevalue2"></span>
 	</div>
 	
 	<div class="form-group btn-group2">
 		<button type="submit" class="btn btn-primary" style="background-color :  rgb(0, 173, 238)!important;border-color:rgb(0, 173, 238)!important">등록</button>
 		<button type="reset" class="btn btn-danger" onclick="history.go(-1)">취소</button>
 	</div>
 
 </form>
</div><!-- container끝 -->
<!-- <script>
$(function(){
	$('#summernote').val(" ${boarddata.FILE_CONTENT}");
	 $('#summernote').summernote({
		 	placeholder: '내용을 입력하세요.',
	       tabsize: 2,
	        lang : "ko-KR",
	        height: 300,
	        callbacks: {
	        	onImageUpload: function(files, editor, welEditable) {
	        		for(var i = files.length -1; i>=0; i--) {
	        			sendFile(files[i], this);
	        		}
	        	}
	        }
	 });
	
	
})//ready끝

</script> -->
 <jsp:include page="/sjKim/boat/footer.jsp" />
</body>
</html>