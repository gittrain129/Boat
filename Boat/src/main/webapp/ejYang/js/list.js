function go(page){
	const data = `limit=${10}&state=ajax&page=${page}`;
	ajax(data);
}



$(function(){
	
	$(".page_wrap button").click(function(){
		location.href="BoardWrite.bo";
	})
})