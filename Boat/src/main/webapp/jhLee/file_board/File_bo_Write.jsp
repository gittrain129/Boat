<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<script src="lang/summernote-ko-KR.js"></script>
<script src="https://github.com/summernote/summernote/tree/master/lang/summernote-ko-KR.js"></script>
    <link href="${pageContext.request.contextPath}/jhLee/css/bootstrap-select.min.css" type="text/css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jhLee/js/bootstrap-select.min.js"></script>
<script src="js/writeform.js"></script>

<style>
    body{background-color: #bbb;}
    .container{background-color: white;
    margin-top: 50px  ;
    padding: 20px;
}
h1{font-size : 1.5rem; text-align: center;  color:rgb(0,173,238)!important; ;}
.container{width : 90%}
label{font-weight : bold}
#upfile,#upfile2{display : none}
img{width : 20px;}
.writer{
    margin-left: 20px;
    width: 76%;
}
.btn-group{
    margin-right: 20px;
    width : 20%;
    float: left;
}
.btn-group2{
  text-align :center;
}
.btn-secondary {
	background-color: rgb(0, 173, 238) !important;
	border: rgb(0, 173, 238) !important;;
}

</style>

</head>
<body>
<div class="container">
 <form action="FileBoardAddAction.filebo" method="post" enctype = "multipart/form-data" name ="boardform">
 	<h1>boat_  wirte 페이지</h1>
     
    <div class="form-group">
        <label for="board_subject">제목</label>
        <input name="board_subject" id="board_subject" type="text" maxlength="100"
        class="form-control" placeholder="Enter board_subject">
    </div>
 	


 	<div class="form-group">
         <label for="board_pass">비밀번호</label>
 		<input name="board_pass" id="board_pass" type="password" maxlength="30"
 		class="form-control" placeholder="Enter board_pass">
    </div>

 
         <div class="form-group ">
        <label for = "board_name">글쓴이</label><br>
        <div class="btn-group">
            <button type="button" class="btn btn-secondary">부서</button>
            <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">
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
       		<input name="board_name" id="board_name" value="" type="text"  class="form-control writer"
       			placeholder="Enterboard_name">
  	  </div>
        
    

 	
 	<div class="form-group">
 		<label for="board_content">내용</label>
 		<textarea name="board_content" id="summernote"  class="form-control"></textarea>
 	</div>
 	
 	<div class="form-group">
 		<label>
 		<img alt="파일첨부" src="${pageContext.request.contextPath}/jhLee/image/file.png"> 
 		&nbsp;파일첨부
 		<input name="board_file" id="upfile" type="file">
		 </label>
	 	
 		<span id ="filevalue"></span>
 	</div>
 	<div class="form-group">
 		<label>
 		<img alt="파일첨부2" src="${pageContext.request.contextPath}/jhLee/image/file.png">
 		 &nbsp;파일첨부2
 		<input name="board_file2" id="upfile2" type="file">
		 </label>
	 	
 		<span id ="filevalue2"></span>
 	</div>
 	
 	<div class="form-group btn-group2">
 		<button type="submit" class="btn btn-primary" style="background-color :  rgb(0, 173, 238)!important;border-color:rgb(0, 173, 238)!important">등록</button>
 		<button type="reset" class="btn btn-danger">취소</button>
 	</div>
 </form>
</div><!-- container끝 -->
<script>
$(function(){

	$('.dropdown-menu .dropdown-item').click(function(){
			const dept =$(this).text()
			const sel =$('.btn-group button:first-child').text()
			console.log(sel)
			console.log(dept)
	$('#dept').val(dept);
			$('.btn-group button:first-child').text(dept)
			const deptval=$('#dept').val()		
			console.log('deptval ='+deptval)
	
	})//drop downclick 끝
})//ready끝
</script>
<!-- <script>
   $('#summernote').summernote({
        placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 100,
    
  lang:'ko-KR',
  height : 500
});
$('.dropdown-toggle').dropdown()
</script> -->
</body>
</html>