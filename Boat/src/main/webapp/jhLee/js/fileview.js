function del(num){//num : 댓글 번호
  	
  	if(!confirm('정말 삭제하시겠습니까?')){
	
	$('#comment-list-item-layer'+num).hide();// 수정삭제영역숨김
	return;
}
	$.ajax({
			url : 'FileCommentDelete.filebo',
			data : {num:num},
			success : function(rdata){
				if(rdata==1){
					getList(option);
				}
			}
		})//ajax

}//function(del) end


	let option=1;  //선택한 등록순과 최신순을 수정, 삭제, 추가 후에도 유지되도록 하기위한 변수로 사용됩니다.

function getList(state){//현재 선택한 댓글 정렬방식을 저장합니다. 1=>등록순, 2=>최신순
	    console.log(state)
	    option=state;
		$.ajax({
			type:"post",
			url:"FileCommentList.filebo",
			data : {"F_COMMENT_NUM" : $("#comment_board_num").val(), state:state},
			dataType:"json",
			success:function(rdata){
				$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
				let red1 = 'red';
				let red2 ='red';
				if(state ==1){
					red2='gray';
				}else if(state==2){
					red1='gray';
				}
				let output="";
				if(rdata.boardlist.length>0){
					output +='<li class = "comment-order-item '+ red1+'">'
							+'	<a href="javascript:getList(1)" class ="comment-order-button">등록순</a>'
							+'</li>'
							+'<li class ="comment-order-item '+ red2+'">'
							+' 	<a href="javascript:getList(2)" class ="comment-order-button">최신순</a>'
							+'</li>';
			$('.comment-order-list').html(output);
			output='';
			$(rdata.boardlist).each(function(){
				const lev = this.comment_re_lev;
				let comment_reply ='';
				if(lev==1){
					comment_reply =' comment-list-item--reply lev1';
				}else if(lev==2){
					comment_reply =' comment-list-item--reply lev2';
					
				}
				const profile = this.memberfile;
				let src ='image/profile.png';
				if(profile){
					src='memberupload/'+profile;
				}
				output +='<li id ="'+this.num+'"class="comment-list-item '+comment_reply + '">'
						+'	<div class ="comment-nick-area">'
						+'	<img src="'+src+'" alt ="프로필사진" width="36" height="36">'
						+'	<div class ="comment-box">'
						+'		<div class ="comment-nick-box">'
						+'			<div class="comment-nick-info">'
						+'				<div class="comment-nickname">'+ this.F_C_ID + '</div>'
						+'			</div>'//comment-nick-info
						+'		</div>'//comment-nick-box
						+'	</div>'//comment-box
						+'	<div class ="comment-text-box">'
						+'		<p class-"comment-text-view">'
						+'			<span class="text-comment">'+ this.F_CONTENT + '</span>'
						+'		</p>'
						+'	</div>'//comment-text-box
						+'	<div class="comment-info-box">'
						+'		<span class="comment-info-data">'+this.F_COMMENT_DATE + '</span>';	
				if(lev<2){
					output +='	<a href="javascript:replyform('+this.F_C_NUM +','
							+ lev +','+this.F_COMMENT_RE_SEQ+','
							+ this.F_COMMENT_RE_REF +')" class="comment-info-button">답글쓰기</a>'
				}
				output+='</div>'//comment-info-box;
				
				if($("#loginid").val()==this.id){
					output+='<div class="comment-tool">'
						+'	<div title="더보기" class="comment-tool-button">'
						+'			<div>&#46;&#46;&#46;</div>'
						+'		</div>'
						+'		<div id = "comment-list-item-layer'+this.num+'" class="LayerMore">'//스타일에서 display:none
						+'		<ul class="layer-list">'
						+'			<li class="layer-item">'
						+'			<a href="javascript:updateForm('+this.F_C_NUM+')"'
						+'			class="layer-button">수정</a>&nbsp;&nbsp;'
						+'			<a href="javascript:del('+this.F_C_NUM+')"'
						+'			class="layer-button">삭제</a></li></ul>'
						+'		</div>'
						+'		</div>'
				}
						output+='</div>'//comment-nick-area
						+'		</li>'//li.comment-list-item
			})//each end
			$('.comment-list').html(output);
			}//if(rdata.boardlist.length>0)
			else{//댓글 1개가 있는 상태에서 삭제하는 경우 갯수는 0이라 if문을 수행하지 않고 이곳으로 옵니다.
				//이곳에서 아래의 두 영역을 없앱니다.
				$('.comment-list').empty();
				$('.comment-order-list').empty();
				
			}
				
			
			}//success end
		});//ajax end
	}//function(getList) end
	