$(function() {
		let checkid=false;
		let checkemail=false;
		let checkjumin=false;
		let checkjumin2=false;
	
		
		$("input[name=empno]").on('keyup',
			function() {
				$("#message").empty(); //처음에 pattern에 적합하지 않은 경우 메시지 출력 후 적합한 데이터를 입력해도
										//계속 같은 데이터 출력하므로 이벤트 시작할 때마다 비워둡니다.
				//[A-Za-z0-9_]의 의미가 \w
				const pattern = /^\w{4,12}$/;
				const empno = $("input:eq(0)").val();
				if (!pattern.test(empno)) {
					$("#message").css('color', 'red')
								 .html("영문자 숫자 _로 4~12자 가능합니다.");
					checkid=false;
					return;
				}
				
				$.ajax({
					url : "idcheck.net",
					data : {"empno" : empno},
					success : function(resp) {
						if (resp == -1) { //db에 해당 id가 없는 경우 
							$("#message").css('color', 'green').html("사용 가능한 아이디 입니다.");
							checkid=true;
						} else { //db에 해당 id가 있는경우(0) 
							$("#message").css('color', 'blue').html("사용중인 아이디 입니다.");
							checkid=false;
						}
					}
				})//ajax end
		})//id keyup end
		
		
		$("input[name=email]").on('keyup', 
				function() {
			//$("#email_message").empty();
			//[A-Za-z0-9_]와 동일한 것이 \w입니다.
			//+는 1회 이상 반복을 의미하고 {1,}와 동일합니다.
			//\w+ 는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
			const pattern = /^\w+@\w+[.]\w{3}$/;
			const email_value = $(this).val();
			console.log(email_value)
				if (!pattern.test(email_value)) {
					$("#email_message").css('color', 'red')
								 	   .html("이메일형식이 맞지 않습니다.");
					checkemail=false;
				} else { 
					$("#email_message").css('color', 'green')
									   .html("이메일형식에 맞습니다.");
					checkemail=true;
				}
		}); //email keyup 이벤트 처리 끝
		
		$("input[name=jumin]").keyup(function() {
		if ($.trim($(this).val()).length == 6) {
			pattern = /^[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
			const jumin_value = $(this).val();
			console.log(jumin_value)
				if (!pattern.test(jumin_value)) {
					$("#jumin_message").css('color', 'red')
								 	   .html("앞자리 주민번호 형식에 맞지 않습니다.");
					checkjumin=false;
				} else { 
					$("#jumin_message").css('color', 'green')
									   .html("앞자리 주민번호 형식에 맞습니다.");
					checkjumin=true;
				}
		} else{
		
		$("input[name=jumin2]").keyup(function() {
		if ($.trim($(this).val()).length == 7) {
			pattern = /^[1234][0-9]{6}$/;
			const jumin2_value = $(this).val();
			console.log(jumin2_value)
				if (!pattern.test(jumin2_value)) {
					$("#jumin_message").css('color', 'red')
								 	   .html("뒷자리 주민번호 형식에 맞지 않습니다.");
					checkjumin=false;
				} else { 
					$("#jumin_message").css('color', 'green')
									   .html("주민번호 형식에 맞습니다.");
					checkjumin=true;
				}
		}
	});
	}
	});

	

		
		
		
	});//ready
	
