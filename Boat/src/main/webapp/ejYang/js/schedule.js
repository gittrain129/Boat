$(document).ready(function(){
	$("#addValue").val('');
	//추가 버튼 클릭할 때 이벤트 부분
	$("form.search-form").submit(function(){
		
		if($.trim($("#addValue").val()) == ""){
			alert("내용을 입력하세요");
			$("#addValue").focus();
			return false;
		}else{
			location.href="MySchedule.my";
		}

	});//submit end
	
	$("#addValue").focus();
});//ready() end