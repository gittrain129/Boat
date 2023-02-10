$(function(){
	$('#inout').change(function(){
		let output="";
		let output2="";
	    let checked = $("#inout option:checked").val();
	    
	    var today = new Date();
		var m = today.getMonth()+1;
		var d = today.getDate();
		var h = today.getHours();
		var mm = today.getMinutes();
		
		if(checked=='출근'){
			output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
			console.log(output);
			$('#work').html(output);
		}
	});
	
    
	
})