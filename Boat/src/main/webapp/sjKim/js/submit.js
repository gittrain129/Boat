$(document).ready(function() {

$('form').submit(function() {
			if(!$.isNumeric($("input[name='age']").val())) {
				alert("나이는 숫자를 입력하세요");
				$("input[name='age']").val('').focus();
				return false;
			}
			if(!checkid) {
				alert("사용가능한 id로 입력하세요.");
				$("input[name=id]").val('').focus();
				return false;
			}
			if(!checkemail) {
				alert("email 형식을 하세요.");
				$("input[name=email]").focus();
				return false;
			}
			const name = $("#name");
		if ($.trim(name.val()) == "") {
			alert("이름을 입력 하세요");
			name.focus();
			return false;
		}
		const password = $("#password");
		if ($.trim(password.val()) == "") {
			alert("비밀번호를 입력 하세요");
			password.focus();
			return false;
		}

		const jumin = $("#jumin");
		if ($.trim($("#jumin").val()) == "") {
			alert("주민번호 앞자리를 입력 하세요");
			jumin.focus();
			return false;
		}

		if ($.trim(jumin.val()).length != 6) {
			alert("주민번호 앞자리 6자리를 입력 하세요");
			jumin.val("").focus();
			return false;
		}

		if (!$.isNumeric(jumin.val())) {
			alert("숫자만 입력 가능 합니다.");
			jumin.val("");
			jumin.focus();
			return false;
		}
		const jumin2 = $("#jumin2");
		if ($.trim(jumin2.val()) == "") {
			alert("주민번호 뒷자리를 입력 하세요");
			jumin2.focus();
			return false;
		}
		if ($.trim(jumin2.val()).length != 7) {
			alert("주민번호 뒷자리 7자리를 입력 하세요");
			jumin2.val("").focus();
			return false;
		}


		if (!$.isNumeric(jumin2.val())) {
			alert("숫자만 입력 가능 합니다.");
			jumin2.val("");
			jumin2.focus();
			return false;
		}
		let cnt = $('input:radio:checked').length;
		if (cnt == 0) {
			alert("성별을  선택하세요");
			return false;
		}


		cnt = $('input:checkbox:checked').length;


		const post = $("#post");
		if ($.trim(post.val()) == "") {
			alert("우편번호를 입력 하세요");
			post.focus();
			return false;
		}

		if (!$.isNumeric(post.val())) {
			alert("숫자만 입력 가능 합니다.");
			post.val("");
			post.focus();
			return false;
		}

		if ($.trim(post.val()).length != 5) {
			alert("우편번호는 다섯자리입니다.");
			post.focus();
			return false;
		}
		
		const intro = $("#intro");
		if ($.trim(intro.val()) == "") {
			alert("자기소개를 입력 하세요");
			intro.focus();
			return false;
		}
		});//submit
		
		
		
		// 우편검색 버튼 클릭
	    $("#postcode").click(function(){ 
	     //window.open("post.html","post", "width=400,height=500,scrollbars=yes");
	    	Postcode();
	    }); 
	    
		function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            	console.log(data.zonecode)
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#post').val(data.zonecode); //5자리 새우편번호 사용
                $('#address').val(fullRoadAddr);
            }
        }).open();
    }//function Postcode()

		
		
	$('input[type=file]').change(function(event){
			const inputfile = $(this).val().split('\\');
			const f_upload = inputfile[inputfile.length - 1]; //inputfile.length -1 = 2
			
			const pattern = /(gif|jpg|jpeg|png)$/i; //i(ignore case)는 대소문자 무시를 의미
			if (pattern.test(f_upload)){
			//	$('#f_upload').text(f_upload);
				
				const reader = new FileReader(); //파일을 읽기 위한 객체 생성
			
				//DataURL 형식(접두사 data:가 붙은 URL이며 바이너리 파일을 Base64로 인코딩하여 ASCII 문자열 형식으로 변환 것)
				//파일을 읽어옵니다.  (참고-Base64 인코딩은 바이너리 데이터를 Text로 변경하는 Encoding입니다.)
				//읽어온 결과는 reader객체의 result 속성에 저장됩니다.
				//event.target.files[0] : 파일리스트에서 첫번째 객체를 가져옵니다.
				reader.readAsDataURL(event.target.files[0]);
				
				reader.onload = function() { //읽기에 성공했을 때 실행되는 이벤트 핸들러
					$('#showImage > img').attr('src', this.result); 
				};
			}else{
				alert('이미지 파일(gif,jpg,jpeg,png)이 아닌 경우는 무시됩니다.');
				$('#f_upload').text('');
				$('#showImage > img').attr('src', 'image/profile.png');
				$(this).val('')
				$('input[name=check]').val('');
			}
						
		})//chage()
		
});

function onClickUpload() {
            let myInput = document.getElementById("memberfile");
            myInput.click();
        	}