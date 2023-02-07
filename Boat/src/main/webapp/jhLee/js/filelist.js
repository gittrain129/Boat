



$(function() {
		var subject = null;
		var writer = null;
		
		
		$("#write").click(function() {

			location.href = "FileBoardWrite.filebo";

			})		
	
		
		//var search_val = $('#search').text();
		
	
		$('#searchbtn+div a').click(function(){
			search_val =$(this).text();
				console.log('작성자나제목선택 : '+ search_val);
				
			$("#search").text(search_val);
			$("#searcselhval").val(search_val);
			//console.log($("#searcselhval").val())
			//#searchval = inputhidden
			
		})
		
		$('#deptbtn+div a').click(function(){
			dept_val =$(this).text();
				console.log(dept_val);
			$("#dept").text(dept_val);
			$('#deptval').val()==dept_val;
			console.log($('#deptval').val());
			//#deptval = inputhidden
		})
		
		$('#orderbtn+div a').click(function(){
			order_val =$(this).text();
				console.log(order_val);

				//#orderval = inputhidden
				$("#order").text(order_val);
				
				switch(order_val){
					case '댓글순':
					$('#orderval').val('(select F_COMMENT_NUM ,count(*) "CNT" from FILE_COMMENT group by F_COMMENT_NUM order by  CNT desc)')
							;
					
								break;
					case '최신순':
					$('#orderval').val('asc');
								break;
					case '조회순':
					$('#orderval').val('desc');
								break;
					
				}
				const message = ["아이디","이름","나이","여 또는 남"]
			$("input[class='search'").attr("placeholder",message[selectedValue]+"입력하세요");
	
	
	
	
$('#searhcbtn2').click(function submit(){
alert('hi')
console.log('hi')
	if($("input").val()==''){
		alert("검색어를 입력하세요");
		$("input").focus();
		return false;
	}
	const word = $(".input-group input").val();
	if(selectedValue ==2){
		const pattern = /^[0-9]{2}$/;
		if(!pattern.test(word)){
			alert("나이는 형식에 맞게 입력하세요(두자리 숫자)");
			return false;
		}
	}else if(selectedValue ==3){
		if(word !="남"&&word !="여"){
			alert("남 또는 여를 입력하세요");
			return false;
		}
	}
})//button 끝

		})


	
	})//ready 끝