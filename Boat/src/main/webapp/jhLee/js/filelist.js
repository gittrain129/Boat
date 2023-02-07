



$(function() {
		var subject = null;
		var writer = null;
		
		
		$("button:last-child").click(function() {

			location.href = "FileBoardWrite.filebo";

			})		
	
		
		//var search_val = $('#search').text();
		
	
		$('#searchbtn+div a').click(function(){
			search_val =$(this).text();
				console.log(search_val);
				
			$("#search").text(search_val);
			$("#searchval").val(search_val);
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
				
			console.log('123456789'+$('#orderval').val());


		})


	
	})//ready 끝