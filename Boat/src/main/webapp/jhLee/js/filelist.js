	function go(page){
			searchsel = $("#search").text();
			searchinput = $("#searchinput").val();
			dept=$("#dept").text();
			order=$("#order").text();
			const data = `state=ajax&page=${page}&searchsel=${searchsel}&searchinput=${searchinput}&dept=${dept}&order=${order}`;
			ajax(data);
	};

	function setPaging(href,digit){
	
		let underline ="";
		let gray = "";
		if(href==""){//href가 빈문자열인 경우
			if(isNaN(digit)){//이전 &nbsp;또는 다음&nbsp;
				gray="gray";
			}else{
				underline="underline"
			}
		}
		let output =`<span class="num ${underline}">`;
		let anchor =`<a class = 'firstItem ${gray}' ${href}>${digit}</a></span>`
		output+=anchor;
		return output;
	}//setpaging끝

	function ajax(sdata){
		console.log("ajax함수안"+sdata);
		// sdata = `state=ajax&page=${page}&searchsel=${searchsel}&searchinput=${searchinput}&dept=${dept}&order=${order}`;
		$.ajax({
			type : "POST",
			data: sdata,
			url : "FileBoardList.filebo",
			dataType : "json",
			cache: false,
			//정적브라우저 환경에서는 true로 계속 바뀔 필요가 없지만  그게 아니라면 계속 바뀌어야합니다.
			success : function(data){
				$("table").find("span").text("글 개수 : "+data.listcount);
				
				if(data.listcount>0){//총 갯수가 0보다 큰 경우
					$("tbody").remove();
					let num = data.listcount-(data.page-1)*data.limit;
					console.log(num)
					let output ="<tbody>";
					$(data.boardlist).each(
						function(index,item){
							output+='<tr><td><div class="num">'+(num--)+'</div></td>'
							const blank_count= item.FILE_RE_LEV *2+1;
							let blank = '&nbsp';
							for(let i =0; i<blank_count;i++){
								blank +='&nbsp;&nbsp;';
							}
							let img="";
							if(item.FILE_RE_LEV>0){
								img="<img src='jhLee/image/down.png'>";
							}
							let subject = item.FILE_SUBJECT;
							if(subject.lengthh>=20){
								subject = subject.substr(0,20)+"...";
							}
							//console.log(item.nowday-item.FILE_DATE)
									let today = new Date(item.FILE_DATE);
									//console.log(item.nowday)
									let nowday = new Date(item.nowday);
									
								//	console.log("today날짜는어찌되었는가"+today)
								//	console.log("nowday날짜는어찌되었는가"+nowday)
									
							moment(today).format();
								//	console.log("js 오늘 moment사용 후 "+moment().format())
								//	console.log("게시판 저장되어있는 "+item.FILE_DATE)
								//	console.log(typeof(item.FILE_DATE));
								//	console.log(typeof(moment().format()));
								//	console.log("new날짜"+item.FILE_DATE-moment().format())
								
									
								//	console.log("nowday"+item.nowday)
									let imgnew ="";
									if(item.FILE_DATE>item.nowday){
										imgnew='<img src="/Boat/jhLee/image/new.jpg" id="new">'
									}
						
							output +="<td><div class='title'>"+blank+img
							output +='<a href = "FileBoadrdDetailAction.filebo?num='+item.FILE_NUM+'">'
							output += subject.replace(/</g,'&lt;').replace(/>/g,'&gt;')
									+'</a>['+item.CNT+']'+imgnew+'</div>'
							//d윗문장지우기
							
							output +='</td><td><div class="dept">'+item.DEPT+'</div></td>'
							output +='<td><div class="writer">'+item.FILE_NAME+'</div></td>'
							output +='<td><div class="count">'+item.FILE_READCOUNT+'</div></td>'
							output +='<td><div class="date">'+item.FILE_DATE+'</div></td>'
							let fileimg =""
							let fileimg2 =""
							if(item.FILE_FILE!=null)
							fileimg ='<img src="/Boat/jhLee/image/download.png" class = "file">';
							if(item.FILE_FILE2!=null)
							fileimg2 ='<img src="/Boat/jhLee/image/download.png" class = "file">';
							
							output+='<td><div class = "file1">'+fileimg+'</div></td>'
							output+='<td><div class = "file2">'+fileimg2+'</div></td>'
							
									+'</tr>'
						})
					output+="</tbody>"
					$('table').append(output)//table끝
					$(".paging").empty();//페이징처리영역 제거
					output ="";
		
			let digit = '이전&nbsp; <img src="jhLee/image/pre.png" alt="이전10개" width="10px">';  
					let href = "";
					if(data.page > 1){
						href = 'href=javascript:go(' +(data.page - 1) + ')';
					}
					output += setPaging(href, digit);
					
					for(let i = data.startpage; i <= data.endpage; i++){
						digit = i;
						href="";
						if (i != data.page){
							href = 'href=javascript:go(' + i + ')';
						}
						output += setPaging(href, digit); //아래랑 처리하는 내용이 반복이라 setPaging() 메소드 만들어서 사용함
					}
					digit='&nbsp;다음&nbsp;<img src="jhLee/image/next.png" alt="다음10개" />';
					href="";
					if(data.page<data.maxpage){
						href='href=javascript:go('+(data.page+1)+')';
					}
					output+=setPaging(href,digit);
					$('.paging').append(output)
				}//if(data.listcount)>0 end
			},
			error:function(){
				console.log('에러')
			}
		})//$.ajax끝
	}//ajax끝
	
	
	var searchsel;
	var searchval;
	var dept;
	var order;

	$(function() {
			//글쓰기 버튼
		$("#write").click(function() {
				location.href = "FileBoardWrite.filebo";
		})		
		
		
		$("#searchinput").attr('placeholder','검색어를 입력하세요')
		
		$('#searchbtn+div a').click(function(){
				
			searchval= $(this).text();
			console.log(searchval);
			$("#search").text(searchval);
			
			$("#searchinput").focus();
			
			if($("#search").text() === "제목"){
				$("#searchinput").attr('placeholder','제목을 입력하세요')
				console.log(searchval);
			}else if($("#search").text() === "작성자"){
				$("#searchinput").attr('placeholder','이름을 입력하세요')
			}
			searchsel = searchval;
			
		})
		//돋보기
		$("#searhcbtn2").click(function(){
			if($("#searchinput")==""){
				alert('검색어를 입럭하세요.')
				return false;
			}
			
			if($("#search").text()==="검색옵션")
			{alert("검색 옵션을 선택하세요.")
			return false;}
			
			go(1);
		});
	
		$('#deptbtn+div a').click(function(){
			dept = $(this).text();
			console.log(dept);
			$('#dept').text(dept);
				console.log(dept);
				$('#deptval').val(dept);
				console.log($('#deptval').val(dept));
				go(1);
			
		});
				

		$('#orderbtn+div a').click(function(){
			 order_val =$(this).text();
				console.log(order_val);

				//#orderval = inputhidden
				$("#order").text(order_val);
				
				switch(order_val){
					case '댓글순':
					$('#orderval').val(
							;
					
								break;
					case '최신순':
					$('#orderval').val('');
								break;
					case '조회순':
					$('#orderval').val('');
								break;
				}
		go(1);
		})

	
	//})//button 끝
		
})//ready 끝