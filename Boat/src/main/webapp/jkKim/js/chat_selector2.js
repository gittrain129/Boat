$(function(){
 $("li").click(function(){
	let wego= "click작동중";
	let jkk = $(this).val();
	
	const data = `rownum=${jkk}&state=ajax`
	console.log(jkk)
	
	ajax(data);

   });

});


function ajax(sdata){
   console.log(sdata)
   
   $.ajax({ 
      type : "POST",
      data : sdata,
      url : "Sender_chat.jk",
      dataType : "json",
      cache : false,
      success : function(data){
	console.log(data.empno_id)
	window.location.href='chatView_Sender.jsp?empno_id=' + data.empno_id;
	
	 }, //success end
         error : function() {
	        console.log('에러');
         }
   })//ajax end
}//function ajax end