$(document).ready(function() {
	let is_idcheck_click = false;  // id 중복검사 했는지 여부
	let idcheck_value = '';        // id 중복검사시 값

	// ID중복검사 부분
	$("#idcheck").click(function() {

		const empno = $("#empno");
		// $.trim(문자열)는  문자열의 앞, 뒤 공백을 제거합니다.
		const empno_value = $.trim(empno.val());
		if (empno_value == "") {
			alert("사원번호를 입력 하세요");
			empno.focus();
			return false;
		} else {
			// 대소문자, 숫자, _로 총 4개 이상
			pattern = /^[a-zA-Z0-9_]{4,}$/;
			if (pattern.test(empno_value)) {
				idcheck_value = empno_value;
				is_idcheck_click = true;
				const ref = "idcheck?empno=" + empno_value;
				window.open(ref, "idcheck", "width=350,height=200");

			} else {
				alert("아이디는 대소문자, 숫자, _로 총 4개 이상이어야 합니다.");
				empno.val('').focus();
			}
		}
	});


	// 도메인 선택 부분
	$("#sel").change(function() {
		const domain = $("#domain");
		if ($(this).val() == "") { // 직접입력 선택한 경우
			domain.val("").focus();
			domain.prop("readOnly", false);
		} else {   // 도메인 선택한 경우
			domain.val($(this).val());
			domain.prop("readOnly", true);
		}
	});


	$("#jumin1").keyup(function() {
		if ($.trim($(this).val()).length == 6) {
			pattern = /^[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
			if (pattern.test($(this).val())) {
				$("#jumin2").focus();// 주민번호 뒷자리로 포커스 이동
			} else {
				alert("숫자 또는 형식에 맞게 입력하세요[yymmdd]");
				$(this).val('').focus();
			}
		}
	});

	$("#jumin2").keyup(function() {
		if ($.trim($(this).val()).length == 7) {
			pattern = /^[1234][0-9]{6}$/;
			if (pattern.test($(this).val())) {
				const c = $(this).val().substring(0, 1);
				const index = (c - 1) % 2; // c=1,3이면 index=0
				                           // c=2,4이면 index=1
				$("input[type=radio]").eq(index)
					.prop("checked", true);
			} else {
				alert("형식에 맞게 입력하세요[1234][0-9]{6}");
				$(this).val('').focus();
			}
		}
	});


	// 회원가입 버튼 클릭할때 이벤트 처리 부분
	$("form").submit(function() {
		// $.trim(문자열)는  문자열의 앞, 뒤 공백을 제거합니다.
		const empno = $("#empno");
		if ($.trim(empno.val()) == "") {
			alert("사원번호를 입력 하세요");
			empno.focus();
			return false;
		}


        if(!$("#empno").prop('readOnly')){  //회원가입 폼과 정보 수정 폼에서 동시에 사용할 js입니다.
    	                                //회원가입 폼에서만 사용할 문장들 입니다.
    	                                //정보 수정 폼에서는 아이디를 수정하지 않기 때문에 필요없는 부분입니다.
    	   console.log($("#empno").prop('readOnly'))
	       const submit_empno_value=$.trim($("#empno").val()) 
	       if(submit_empno_value != idcheck_value){//submit 당시 아이디값과 아이디 중복검사에 사용된 아이디를 비교합니다.
	    	   alert("사원번호 중복검사를 하세요");
	           return false;
	       }
	       
    	   //아이디 중복 검사를 했지만  사용중인 아이디인 경우에는 submit시 경고창 나타납니다.
	       const result=$("#result").val();       
	       if(result==-1){
	    	   alert("사용 가능한 사원번호로 다시 입력하세요");
	    	   $("#empno").val('').focus();
	    	   return false;
	       }
       }
		const name = $("#name");
		if ($.trim(name.val()) == "") {
			alert("이름을 입력 하세요");
			name.focus();
			return false;
		}

		const age = $("#age");
		if ($.trim(age.val()) == "") {
			alert("나이를 입력 하세요");
			age.focus();
			return false;
		}


		const password = $("#password");
		if ($.trim(password.val()) == "") {
			alert("비밀번호를 입력 하세요");
			password.focus();
			return false;
		}

		const jumin1 = $("#jumin1");
		if ($.trim($("#jumin1").val()) == "") {
			alert("주민번호 앞자리를 입력 하세요");
			jumin1.focus();
			return false;
		}

		if ($.trim(jumin1.val()).length != 6) {
			alert("주민번호 앞자리 6자리를 입력 하세요");
			jumin1.val("").focus();
			return false;
		}

		if (!$.isNumeric(jumin1.val())) {
			alert("숫자만 입력 가능 합니다.");
			jumin1.val("");
			jumin1.focus();
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

		const email = $("#email");
		if ($.trim($("#email").val()) == "") {
			alert("E-Mail주소를 입력 하세요");
			email.focus();
			return false;
		}

		const domain = $("#domain");
		if ($.trim($("#domain").val()) == "") {
			alert("도메인 주소를 입력 하세요");
			domain.focus();
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

		const address = $("#address");
		if ($.trim(address.val()) == "") {
			alert("주소를 입력 하세요");
			address.focus();
			return false;
		}

		const intro = $("#intro");
		if ($.trim(intro.val()) == "") {
			alert("자기소개를 입력 하세요");
			intro.focus();
			return false;
		}

	});// submit() end


// 우편검색 버튼 클릭
    $("#postcode").click(function(){ 
     //window.open("post.html","post", "width=400,height=500,scrollbars=yes");
    	Postcode();
    }); 
    
  //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
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
    
    
    //프로필사진 업로드
    
    
        
        
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
		
		
});// ready() end


function onClickUpload() {
            let myInput = document.getElementById("memberfile");
            myInput.click();
        	}




