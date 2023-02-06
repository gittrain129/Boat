$(document).ready(function(){
	//추가 버튼 클릭할 때 이벤트 부분
	$("#btn").click(function(){
		
		if($.trim($("#addValue").val()) == ""){
			alert("내용을 입력하세요");
			$("#addValue").focus();
			return false;
		}else{
			
		}
		
	});//submit end
});//ready() end