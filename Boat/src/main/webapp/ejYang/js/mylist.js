function getname(){
	$.ajax({
			url: 'MyInfo.my',
			type : 'post',
			success : function(rdata) {
				let output="";
				
				$(rdata.memberinfo).each(function(){
					output += '<input type="hidden" id="loginid" value="'+this.name+'" name="loginid">'
				});
				
				$('body').html(output);
			}
		})//ajax
}

$(document).ready(function(){
	getname();
})