$(function(){
	$('#work').html(getCookie('work'));
	$('#out').html(getCookie('out'));
	$('#outin').html(' - '+getCookie('outin'));
	$('#leaves').html(getCookie('leaves'));
	
	if(checkCookie('out')==true && checkCookie('outin')==false){
		console.log(1);
		$("#outs").val('복귀');
		$("#outs").html('복귀');
	}
	
	$('.infomodify').click(function(){
		location.href="";
	});
	
	$('#inout').change(function(){
		let output="";
		let output2="";
		let output3="";
		let output4="";
	    let checked = $("#inout option:checked").val();
	    
	    var today = new Date();
		var m = today.getMonth()+1;
		var d = today.getDate();
		var h = today.getHours();
		var mm = today.getMinutes();
		
		if(checked=='출근'){
			output += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
			console.log(output);
			
			setCookie('work',output, 23-today.getHours(), 60-today.getMinutes());
		}
		
		if(checked=='외출'){
			output2 += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
			console.log(output2);
			
			setCookie('out',output2, 23-today.getHours(), 60-today.getMinutes());
		}
		
		if(checked=='복귀'){
			output3 += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
			console.log(output3);
			
			setCookie('outin',output3, 23-today.getHours(), 60-today.getMinutes());
		}
		
		if(checked=='퇴근'){
			output4 += m+'월 '+d+'일 '+h+'시 '+mm+'분 '
			console.log(output4);
			
			setCookie('leaves',output4, 23-today.getHours(), 60-today.getMinutes());
		}
	});
})



//쿠키 생성
function setCookie(name, value, expiretime, expireminutes) {
    var date = new Date();
    date.setHours(date.getHours() + expiretime);
    date.setMinutes(date.getMinutes() + expireminutes);
		      
    var mycookie = '';
    mycookie += name + '=' + value +';';
    mycookie += 'expires=' + date.toUTCString();
		      
    document.cookie = mycookie;
    console.log(date.toUTCString());
}	


//쿠키값 가져오기
function getCookie(cName) {
      cName = cName + '=';
      var cookieData = document.cookie;
      var start = cookieData.indexOf(cName);
      var cValue = '';
      if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
      }
      return unescape(cValue);
}


//쿠키 확인
function checkCookie(name) {
    var cookies = document.cookie.split(';');
    var visited = false;
		    
    for(var i=0; i<cookies.length; i++){
    	if(cookies[i].indexOf(name) > -1){
    		visited = true;
    	}
    }
	return visited 
}