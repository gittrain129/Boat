const t_empno = $("#loginid").val();

//조회
function getList(t_empno){
	
	console.log(t_empno);
	$.ajax({
			type:"post",
			url:"Todolist.my",
			data : {"t_empno" : $("#loginid").val()},
			dataType:"json",
			success :function(rdata){
				let output="";
				
				if(rdata.todolist.length>0){
					
					$(rdata.todolist).each(function(){
						output += '<input class="form-check-input" name="chklist" type="checkbox" id="' +this.t_content+ '">'
						output += '<label class="form-check-label" for="'+this.t_content+'">' +this.t_content+ '</label>'
					})//each end
					
					$('.order-list').html(output);
					
				}//if end
			}// success end
	});//ajax end
}//getList end


$(document).ready(function(){
	getList(t_empno);
	$("#addValue").focus();
	
	//추가 버튼 클릭할 때 이벤트 부분
	$("#btn").click(function(){
		
		const content = $.trim($("#addValue").val());
		if(content == ""){
			alert("내용을 입력하세요");
			$("#addValue").focus();
			return false;
		}
		
		if($('label[for="'+content+'"]').text()==content){
		    alert("같은 문구는 추가할 수 없습니다.");
		    $("#addValue").val('').focus();
			return false;
		}
		
		//투두리스트 추가
		$.ajax({
			url: 'TodoAdd.my',//원문 등록
			data : {
				t_empno : $("#loginid").val(),
				t_content : content,//$('.comment-write-area-text').val()
			},
			type : 'post',
			success : function(rdata) {
				
				if(rdata == 1){
					getList(t_empno);
				}
			}
		})//ajax

		$("#addValue").val('').focus();
	});//click end
	
	
	
	
	
	//완료 버튼 클릭할 때 이벤트 부분
	$("#submitbtn").click(function(){
		
		const content = $.trim($("#addValue").val());
		var checkboxValues = [];
		$("input:checkbox[name=chklist]:checked").each(function(){
			checkboxValues.push($(this).next().text());
		});
		
		console.log(checkboxValues);
		var allData = { t_empno: content, "checkArray": checkboxValues };
		//let ival=$("input:checkbox[name=chklist]:checked").next().text()
		
		
		//'N' -> 'Y' 변경
		$.ajax({
			url: 'TodoCheck.my',
			data : allData,
			type : 'post',
			success : function(rdata) {
				
				if(rdata == 1){
					getList(t_empno);
				}
			}
		})//ajax
		

		
	});//click end
	
});//ready() end