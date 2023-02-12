<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
	<script src="${pageContext.request.contextPath}/ejYang/js/jquery-3.6.3.js"></script> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 	<jsp:include page="/sjKim/boat/header.jsp" />
	<style>
		* {box-sizing: border-box;}
		.container {width:70%; margin-top: 200px;}
		label { font-weight:bold}
		.container fieldset {padding:50px;
			position: relative;
		    display: flex;
		    flex-direction: column;
		    word-wrap: break-word;
		    background-color: #fff;
		    background-clip: border-box;
		    border-radius: 10px;
		    background: #F5F7FF;
		    margin-bottom: 150px;
		    margin-bottom: 300px;
		}
		.container > h2 {text-align: center; width:auto; padding: 10px; font-weight:bold; margin-bottom:40px}
		.form-control {
			width: 88%;
		  	padding: 12px;
			border: 1px solid #ccc;
			border-radius: 4px;
			box-sizing: border-box;
			margin-top: 6px;
			margin-bottom: 16px;
			resize: vertical;
			display: inline-block;
		}
		.control-label, .btn-primary{
			display: inline-block;
			width: 10%;
		}
		#content{
			resize: none;
			height: 250px;
			display: inline-block;
			float: left;
			margin:0px;
		}
		.btn-primary{
			height: 250px;
			float: right;
		}
	</style>
	<title>메일 보내기</title>
	<script>
	$(function(){
		//submit 버튼 클릭할 때 이벤트 부분
		$("form").submit(function(){
			
			if($.trim($("#sender").val()) == ""){
				alert("보내는 사람을 입력하세요");
				$("#sender").focus();
				return false;
			}
			
			if($.trim($("#receiver").val()) == ""){
				alert("받는 사람을 입력하세요");
				$("#receiver").focus();
				return false;
			}
			
			if($.trim($("#subject").val()) == ""){
				alert("제목을 입력하세요");
				$("#subject").focus();
				return false;
			}
			
			if($.trim($("#content").val()) == ""){
				alert("내용을 입력하세요");
				$(".content").focus();
				return false;
			}
			
		});//submit end
		
	});//ready() end
	</script>
 </head>
 <body>
 	<div class="container">
 		<h2>메일보내기</h2>
 		<form class="form-horizontal" method="post" action="emailsend.ne">
 		  <fieldset>
 			<div class="form-group">
 				<label class="control-label" for="sender">보내는 사람</label>
 					<input type="email" name="sender" id="sender" class="form-control"
 						   placeholder="보내는 분의 이메일 주소를 입력하세요."
 						   value="${admininfo.email}" readOnly>
 			</div>
 			
 			<div class="form-group">
 				<label class="control-label" for="receiver">받는 사람</label>
 					<input type="email" name="receiver" id="receiver" class="form-control"
 						   value="${memberinfo.email}"
 						   placeholder="받는 분의 이메일 주소를 입력하세요.">
 			</div>
 			
 			<div class="form-group">
 				<label class="control-label" for="subject">제목</label>
 					<input type="text" name="subject" id="subject" class="form-control"
 						   placeholder="이메일의 제목을 입력하세요.">
 			</div>
 			
 			<div class="form-group">
 					<textarea name="content" id="content" class="form-control"
 						   	  placeholder="이메일의 내용을 입력하세요."></textarea>
 				<input type="submit" class="btn btn-primary" value="전송">
 			</div>
 			
 		  </fieldset>
 		</form>
 	</div>
 	<jsp:include page="/sjKim/boat/footer.jsp" />
 </body>
</html>