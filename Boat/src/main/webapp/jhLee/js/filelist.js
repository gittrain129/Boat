



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
			
			$('#search').val==search_val;
		})
		
		$('#deptbtn+div a').click(function(){
			dept_val =$(this).text();
				console.log(dept_val);
			$("#dept").text(dept_val);
			$('#deptval').val()==dept_val;
		})
		
		$('#orderbtn+div a').click(function(){
			order_val =$(this).text();
				console.log(order_val);
			$("#order").text(order_val);
			$('#orderval').val()==order_val;
		})


	
	})//ready 끝