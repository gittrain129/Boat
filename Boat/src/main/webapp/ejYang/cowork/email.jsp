<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
 <head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<style>
		* { box-sizing: border-box;}
		.container {width:70%}
		label { font-weight:bold}
		fieldset { padding:50px}
		.form-horizontal{border:1px solid #9e9e9e; padding: 10px}
		h2 {text-align: center; width:auto; padding: 10px}
		.control-label, .form-control, .btn-primary, .btn-primary{display: inline-block}
		.control-label {width:10%}
		.form-control {width:88%}
		.form-textarea {width:88%; resize: none;}
		.btn-primary {width:10%}
	</style>
	<title>���� ������</title>
 </head>
 <body>
 	<div class="container mt-5">
 		<h2>���Ϻ�����</h2>
 		<form class="form-horizontal" method="post" action="mailSend.jsp">
 		  <fieldset>
 			<div class="form-group">
 				<label class="control-label" for="sender">������ ���</label>
 					<input type="text" name="sender" id="sender" class="form-control"
 						   placeholder="������ ���� �̸��� �ּҸ� �Է��ϼ���."
 						   value="@naver.com" required>
 			</div>
 			
 			<div class="form-group">
 				<label class="control-label" for="receiver">�޴� ���</label>
 					<input type="email" name="receiver" id="receiver" class="form-control"
 						   placeholder="�޴� ���� �̸��� �ּҸ� �Է��ϼ���." required>
 			</div>
 			
 			<div class="form-group">
 				<label class="control-label" for="reference">����</label>
 					<input type="email" name="reference" id="reference" class="form-control"
 						   placeholder="������ �Է��ϼ���." required>
 			</div>
 			
 			<div class="form-group">
 				<label class="control-label" for="subject">����</label>
 					<input type="email" name="subject" id="subject" class="form-control"
 						   placeholder="�̸����� ������ �Է��ϼ���." required>
 			</div>
 			
 			<div class="form-group">
 					<textarea name="content" id="content" class="form-textarea"
 						   	  row="5" required></textarea>
 			</div>
 			
 			<!-- ��ư ���� -->
 			<div class="form-actions">
 				<input type="submit" class="btn btn-primary" value="����">
 			</div>
 		  </fieldset>
 		</form>
 	</div>
 </body>
</html>