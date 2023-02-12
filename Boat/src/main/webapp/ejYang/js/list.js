function go(page){
	
	const data = `state=ajax&page=${page}`;
	ajax(data);
}


function ajax(sdata){
	console.log(sdata)
	
	$.ajax({
		type : "POST",
		data : sdata,
		url : "BoardList.bo",
		dataType : "json",
		cache : false,
		success : function(data){
			$(".search-window").find("span").text("총 글 개수 : " + data.listcount);
			
			if(data.listcount > 0){//총갯수가 0보다 큰 경우
				$("tbody").remove();
				let num = data.listcount - (data.page - 1) * data.limit;
				console.log(num)
				let output = "<tbody>";
				$(data.boardlist).each(function(index, item){
					output += '<tr><td>'
					if(item.board_notice == 'Y'){
						output += '공지' + '</td>'
					}else{
						output += (num--) + '</td>'
					}
					const blank_count = item.board_re_lev * 2 + 1;
					let blank = '&nbsp;';
					let blank1 = '&nbsp;';
					for(let i = 0; i <blank_count; i++){
						blank += '&nbsp&nbsp;';
					}
					
					let img="";
					if(item.board_re_lev > 0){
						img="<img src='${pageContext.request.contextPath}/ejYang/image/line.png'>"
					}
					
					let subject=item.board_subject;
					if(subject.length>=20){
						subject=subject.substr(0,20) + "...";//0부터 20개 부분 문자열 추출
					}
					
					let date=item.board_date
					let img2="";
					if(date > data.nowday){
						img2="<img src='${pageContext.request.contextPath}/ejYang/image/new.jpg' id='new'>"
					}
					
					output += '<td class="title-td"><div>' + blank + img
					output += '<a href="BoardDetailAction.bo?num='+ item.board_num + '">'
					output += subject.replace(/</g,'&lt;').replace(/>/g,'&gt;')
									+ '</a>'+blank1+'[' + item.cnt + ']'	
					output += img2 + '</div></td>'
					output += '<td><div>' + item.board_dept + '</div></td>'
					output += '<td><div>' + item.board_name + '</div></td>'
					output += '<td><div>' + item.board_readcount + '</div></td>'
					output += '<td><div>' + item.board_date + '</div></td></tr>'
				})
				output += '</tbody>'
				$('table').append(output)//table 완성
				
				$(".page_nation").empty();//페이징 처리 영역 내용 제거
				output = "";
				
				let href="";
				if(data.page > 1){
					href = 'href=javascript:go(' + (data.page -1) + ')';
					output += '<a class="arrow prev" '+href+'></a>';
				}else{
					output += '<a class="arrow prev gray"></a>';
				}
				
				for(let i = data.startpage; i <= data.endpage; i++){
					digit = i;
					href="";
					if(i != data.page){
						href = 'href=javascript:go(' + i + ')';
						output += '<a '+href+' class="page-link">'+digit+'</a>';
					}else{
						output += '<a class="page-link active">'+digit+'</a>';
					}
				}
				
				href="";
				if(data.page < data.maxpage){
					href = 'href=javascript:go(' + (data.page +1) + ')';
					output += '<a class="arrow next" '+href+'></a>';
				}else{
					output += '<a class="arrow next gray"></a>';
				}
				
				$('.page_nation').append(output)
			}//if(data.listcount)>0 end
		},//success end
		error : function(){
			console.log('에러')
		}
	})//ajax end
}//function ajax end


$(function(){
	if($('#loginboard').val()===""){
		alert('로그인 후 사용 가능한 게시판입니다.')	
	}
	
	$(".page_wrap button").click(function(){
		location.href="BoardWrite.bo";
	})
	
	
	go(1);//보여줄 페이지를 1페이지로 설정합니다.
})