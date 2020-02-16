/**
 * 
 */

	$(document).ready(function(){
		
		$(".error_email").hide();
		$(".error_passwd").hide();
		$(".error_passwdCheck").hide();
		$(".error_post").hide();
		$(".error_addr").hide();
		
		$("#myRegisterNav").css('display','none');
		$("#myPwdFindNav").css('display','none');
		
		// -------------------- 생년월일에 쓸 연도, 월, 일 데이터 업로드 ----------------------- //
		
		var html = "";
		
		for(var i=1; i<=12; i++) {
			if(i<10) {
				html += "<option value =0"+i+">0"+i+"</option>";
			} else {
				html += "<option value ="+i+">"+i+"</option>";
			}
		}
		
		$("#birthmm").html(html);
			
		var html = "";
		
		for(var i=1; i<=31; i++) {
			if(i<10) {
				html += "<option value =0"+i+">0"+i+"</option>";
			} else {
				html += "<option value ="+i+">"+i+"</option>";
			}
		}
		
		$("#birthdd").html(html);
		
		// ------------------------ 회원가입 ---------------------------- //
		
		$("button.register-input").click(function(){
		
			goRegister();
			
		});

		// ------------------------ 로그인 ---------------------------- //
		
		$(".login-btn").click(function(){
			
			goLogin();
			
		});
		
		// ------------------------ 비밀번호찾기 ---------------------------- //
		
		// 찾기
		$("#btnFind").click(function(){
			
			var useridVal = $("#userid").val().trim();
			var emailVal = $("#email").val().trim();
			
			if(useridVal != "" && emailVal != "") {
				var frm = document.pwdFindFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/pwdFind.ysl";
				frm.submit();
			}
			else {
				alert("아이디와 이메일을 입력하세요!!");
			}
			
		});
		
		var method = "${ method }";
		var userid = "${ userid }";
		var email = "${ email }";
		var n = "${ n }";
		
		if(method == 'POST' && n == 1) {
			$("#userid").val(userid);
			$("#email").val(email);
			$("#div_btnFind").hide();
		} else {
			$("#div_btnFind").show();
		}
		
		/////////////////////// 회원가입폼 유효성검사 시작 //////////////////////////
		
		$("#regEmail").blur(function(){
			
			var email = $(this).val();
			
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			
			var bool = regExp_EMAIL.test(email);
			
			if(!bool) {
				$(".error").show();
				$(this).val("");
			}
			else {

				$.ajax({
					url:"examCheckEmail.ysl",
					type: "GET",
					data: {'email' : $(this).val().trim()},
					dataType: "json",
					success: function(json) {
						var isExist = json.isEmailExist;
						if(isExist == true) {
							$(".error_email").text("입력하신 이메일은 이미 사용중입니다.");
							$(".error_email").show();
							$(this).val("");
						}
						else {
							$(".error_email").text("입력하신 이메일은 사용 가능합니다.");
							$(".error_email").show();
						}
					}, error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
			
		});
		
		$("#regPwd").blur(function(){
			var passwd = $(this).val();
			
			var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자 를 포함한 형태의 8~15자리 이내의 암호 정규식 객체 생성
			
			var bool = regExp_PW.test(passwd);
			
			if(!bool) {
				$(".error_passwd").show();
				$(":input").attr("disabled",true).addClass("bgcol"); 
				$(this).attr("disabled",false).removeClass("bgcol");
				$(this).focus();
			}
			else {
				$(".error_passwd").text("입력하신 비밀번호는 사용 가능합니다.");
				$(".error_passwd").show();
				$(":input").attr("disabled",false).removeClass("bgcol"); 
				$("#pwdcheck").focus();
			}
		});
		
		$("#pwdCheck").blur(function(){
			var passwd = $("#regPwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) {
				$(".error_passwdCheck").show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$(this).attr("disabled",false).removeClass("bgcol");
				$("#regPwd").attr("disabled",false).removeClass("bgcol");
				$(this).focus();
			}
			else {
				$(".error_passwdCheck").text("입력하신 비밀번호가 일치합니다.");
				$(".error_passwdCheck").show();
				$(":input").attr("disabled",false).removeClass("bgcol");
			}
			
		});
		
		$("#post").click(function(){
			
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    $("#addr2").val(extraAddr);
	                
	                } else {
	                	$("#addr2").val('');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $("#post").val(data.zonecode);
	                $("#addr1").val(addr);
	                // 커서를 상세주소 필드로 이동한다.
	                $("#addr2").focus();
	            }
	        }).open();
			
		});
		
		$("#zipcodeSearch").click(function(){
			
			new daum.Postcode({
	            oncomplete: function(data) {
	                var addr = '';
	                var extraAddr = '';

	                if (data.userSelectedType === 'R') {
	                    addr = data.roadAddress;
	                } else {
	                    addr = data.jibunAddress;
	                }

	                if(data.userSelectedType === 'R'){
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    $("#addr2").val(extraAddr);
	                
	                } else {
	                	$("#addr2").val('');
	                }

	                $("#post").val(data.zonecode);
	                $("#addr1").val(addr);
	                $("#addr2").focus();
	            }
	        }).open();
		});
		
		$(".address").blur(function(){
			var address = $(this).val().trim();
			if(address == "") {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
			}
		});
		
		$("#hp2").blur(function(){
			var hp2 = $(this).val();
			
			var bool1 = false;
			var regExp_HP2a = /^[1-9][0-9][0-9]$/g;
			// 3글자가 숫자이라면 들어오도록 검사해주는 정규표현식
			var bool1 = regExp_HP2a.test(hp2);
			
			var bool2 = false;
			var regExp_HP2b = /^[0-9][0-9][0-9][0-9]$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			var bool2 = regExp_HP2b.test(hp2);
			
			if( !(bool1 || bool2) ) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
			}
			
		});
		
		$("#hp3").blur(function(){
			var hp3 = $(this).val();
			
			var regExp_HP3 = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			var bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
			}			
		});
		
		$(".requiredInfo").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data == "") {
					// 입력하지 않거나 공백만 입력했을 경우
					$(this).parent().find(".error").show();
					$(":input").attr("disabled",true).addClass("bgcol"); 
					$(this).attr("disabled",false).removeClass("bgcol");
					$(this).focus();
				}
				else {
					// 공백이 아닌 글자를 입력했을 경우
					$(this).parent().find(".error").hide();
					$(":input").attr("disabled",false).removeClass("bgcol"); 
				}
			});
		});
		
		/////////////////////// 회원가입폼 유효성검사 끝 //////////////////////////
		
	});	// end of $(function(){ ---------------------------------------------------------------------
	
	
	// ---------------------- 열리는 사이드나브들 정리 -------------------------- //

	function openLoginNav() {
		$("#myLoginNav").css('display', '');
		$("#myLoginNav").css('width', '30%');
		$("#email").focus();
		event.preventDefault();
	}
	
	function closeLoginNav() {
		$("#myLoginNav").css('display', 'none');
	}
	
	// === *** 검색 *** === // 
	function openSearchNav() {
		$("#mySearchNav").css('display', '');
		$("#mySearchNav").css('width', '30%');		
	}

	function closeSearchNav() {
		$("#mySearchNav").css('display', 'none');
	}
	// === *** 검색 끝 *** === // 
	
	function openRegisterNav() {
		$("#myRegisterNav").css('display','');
		$("#myRegisterNav").css('width', '30%');
		$("#regEmail").focus();
		event.preventDefault();
	}
	
	function closeRegisterNav() {
		$("#myRegisterNav").css('display', 'none');
	}
	
	function openPwdFindNav() {
		$("#myLoginNav").css('display', 'none');
		$("#mySearchNav").css('display', 'none');
		$("#myRegisterNav").css('display', 'none');
		$("#myPwdFindNav").css('display', '');
		$("#myPwdFindNav").css('width', '30%');
		$(".pwdFind-input").focus();
		event.preventDefault();
	} 
	
	function closePwdFindNav() {
		$("#myLoginNav").css('display', 'none');
		$("#mySearchNav").css('display', 'none');
		$("#myRegisterNav").css('display', 'none');
		$("#myPwdFindNav").css('display', 'none');
	}
	
	function openPwdUpdateNav() {
		$("#myLoginNav").css('display', 'none');
		$("#mySearchNav").css('display', 'none');
		$("#myRegisterNav").css('display', 'none');
		$("#myPwdUpdateNav").css('display', '');
		$("#myPwdUpdateNav").css('width', '30%');
		$(".pwdFind-input").focus();
		event.preventDefault();
	} 
	
	function closePwdUpdateNav() {
		$("#myLoginNav").css('display', 'none');
		$("#mySearchNav").css('display', 'none');
		$("#myRegisterNav").css('display', 'none');
		$("#myPwdUpdateNav").css('display', 'none');
	}
	
	function goRegister() {
	//	event.preventDefault();
	//	alert("회원가입처리");
	
		$("#regEmail").blur(function(){
			
			var email = $(this).val();
			
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			
			var bool = regExp_EMAIL.test(email);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$(this).attr("disabled",false).removeClass("bgcol"); 
				$(this).focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false).removeClass("bgcol");
			}
			
		});
		
		
		
		var frm = document.registerfrm;
		frm.method = "POST";
		frm.action = "memberInsert.ysl";
		frm.submit();
		
	}
	
	function goLogin() {
	//	event.preventDefault();
	//	alert("로그인처리");
		
		var loginEmail = $("#loginEmail").val().trim();
		var loginPwd = $("#loginPwd").val().trim();
		
		if(loginEmail == "") {
			alert("이메일을 입력하세요");
			$("#loginEmail").val("");
			$("#loginEmail").focus();
			return;
		}
		
		if(loginPwd == "") {
			alert("비밀번호를 입력하세요");
			$("#loginPwd").val("");
			$("#loginPwd").focus();
			return;
		}
		
		var frm = document.loginfrm;
		frm.method = "POST";
		frm.action = "loginEnd.ysl";
		frm.submit();
	
	}
	

	
