function select_inout(){
    var color = $("#inout option:checked").css("color");
    var bgcolor = $("#inout option:checked").css("background-color");
    $("#inout").css("color",color);		
    $("#inout").css("background-color",bgcolor);			
}


function chat_open() {
   const select = $("#inout").val();
   const data = `select=${select}&state=open`; //el이 아닌 백틱 (js에서만 사용추천)
   ajax(data);
}

$(function(){
    
   $('#inout').change(function(){
  	var v = $('#inout').val();
  	if (v =='출근'){
	chat_open();
}
   });
   
});













function ajax(sdata){
   console.log(sdata)
   
   $.ajax({ 
      type : "POST",
      data : sdata,
      url : "chat.jk",
      dataType : "json",
      cache : false,
      success : function(){
	let output = "<div class='Pop-box' id='chat_pop'>";
	output += " <table class='control'> ";
	output += "<tr><td class='title'>Status:</td></tr>";
	output += "<tr><td>";
	output += " <span style='font-weight: bold'>연결할ID: </span>";
	output += "<input type='text' id='receiver-id' title='Input the ID'>";
	output += "<button id='connect-button'>Connect</button>";
	output += "</td></tr>";
	output += "<tr><td>";
	output += "<div class='message' id='message'>";
	output += " <div class='chat ch1'>";
	output += "<div class='icon'><i class='fa-solid fa-user'></i></div>";
	output += "<div class='textbox' id='your_box'>안녕하세요.</div>";
	output += "</div>";
	output += "</div></td></tr>";
	output += "<tr><td>";
	output += " <input type='text' id='sendMessageBox' placeholder='Enter a message...'  />";
	output += "<button type='button' id='sendButton'>Send</button>";
	output += " <button type='button' id='clearMsgsButton'>Clear Msgs (Local)</button>";
	output += "</td></tr><tr>";
	output += "<td><div id='status' class='status'></div></td>";
	output += " </tr></table>";
	
	let output2 = "start_chat();"
	
	
	
	
	
	
	
	 	
	$("body").append(output)
	$("chat_script").append(output2)
	
	}, //success end
         error : function() {
            console.log('에러');
         }
   })//ajax end
}//function ajax end