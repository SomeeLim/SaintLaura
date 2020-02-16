<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>YSL 공식 스토어 | 생 로라 | SAINT LAURA</title>
<%--<script src="<%=ctxPath %>/js_ysl/main.js"></script> --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

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
		$("#pwdFind-btn").click(function(){
			
			var emailVal = $('#pwdFindEmail').val().trim();
			
			if(emailVal != "") {
				var frm = document.pwdFindFrm;
				frm.method = "POST";
				frm.action = "pwdFindH.ysl";
				frm.submit();
				$("#myPwdFindNav").css('display', '');
				$("#myPwdFindNav").css('width', '30%');
			}
			else {
				alert("이메일을 입력하세요");
				$("#myPwdFindNav").css('display', '');
				$("#myPwdFindNav").css('width', '30%');
			}
			
			$("#myPwdFindNav").css('display', '');
			$("#myPwdFindNav").css('width', '30%');
			
		});
		
		var method = "${ requestScope.method }";
		var email = "${ requestScope.email }";
		var n = "${ requestScope.n }";
		
		if(method == 'POST' && n == 1) {
			$("#pwdFindEmail").val(email);
			$("#pwdFind-btn").hide();
		} else {
			$("#pwdFind-btn").show();
		}

		// ------ 인증하기 ------ //
		$("#btnConfirm-input").click(function(){
			
			var frm = document.verifyCertificationFrm;
			frm.userCertificationCode.value = $("#input_confirmCode").val();
			frm.email.value = $("#pwdFindEmail").val();
			
			frm.action = "verifyCertificationH.ysl"
			frm.method = "POST";
			frm.submit();
	/*		
			var verifiedResult = "${ requestScope.verifiedResult }";
			var method = "${ requestScope.method }";
			
			if(verifiedResult == 1 ) {
				alert("인증에 성공하였습니다.");
				openPwdUpdateNav();
			} else {
				alert("인증에 실패하였습니다.");
			}
		*/	
			$("#myPwdFindNav").css('display', '');
			$("#myPwdFindNav").css('width', '30%');
		});
		
		
		// ------------- 비밀번호재설정 ------------- //
		$("#pwdUpdate-pwd").blur(function(){
			var passwd = $(this).val();
			
			var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자 를 포함한 형태의 8~15자리 이내의 암호 정규식 객체 생성
			
			var bool = regExp_PW.test(passwd);
			
			if(!bool) {
				$(".error_passwd").show();
				$("#pwdUpdate-pwd2").attr("disabled",true).addClass("bgcol"); 
				$("#pwdUpdate-btn").attr("disabled", true);
				$(this).focus();
			} else {
				$(".error_passwd").text("입력하신 비밀번호는 사용 가능합니다.");
				$("#pwdUpdate-pwd2").attr("disabled",false).removeClass("bgcol"); 
				$("#pwdUpdate-btn").attr("disabled", false);
				$(".error_passwd").show();
				$("#pwdUpdate-pwd2").focus();
			}
		});
		
		$("#pwdUpdate-pwd2").blur(function(){
			var passwd = $("#pwdUpdate-pwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) {
				$(".error_passwdCheck").show();
				$("#pwdUpdate-btn").attr("disabled", true);
				$(this).focus();
			} else {
				$("#pwdUpdate-btn").attr("disabled", false);
				$(".error_passwdCheck").text("입력하신 비밀번호가 일치합니다.");
				$(".error_passwdCheck").show();
			}
			
		});
		
		$("#pwdUpdate-btn").click(function(){
			
			var pwd = $("#pwdUpdate-pwd").val().trim();
			var pwd2 = $("#pwdUpdate-pwd2").val().trim();
			
			var regexp_passwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			/* 암호는 숫자,영문자,특수문자가 포함된 형태의 8~15글자 이하만 허락해주는 정규표현식 객체 생성 */
			
			var bool = regexp_passwd.test(pwd);
			      
			if(!bool) {
				$(".error_passwd").show(); 
				$("#pwdUpdate-pwd").val("");
				$("#pwdUpdate-pwd2").val("");
				return;
			} else if(pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("#pwdUpdate-pwd").val("");
				$("#pwdUpdate-pwd2").val("");
				return;
			} else {
				var frm = document.pwdUpdateEndFrm;
				frm.method = "POST";
				frm.action = "pwdUpdateEndH.ysl";
				frm.submit();
			}
			
		});

		
		
		/////////////////////// 회원가입폼 유효성검사 시작 //////////////////////////
		
		$(".requiredInfo").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data == "") {
					// 입력하지 않거나 공백만 입력했을 경우
					$(this).parent().find(".error").show();
					$(".register-input").attr("disabled",true).addClass("bgcol"); 
					$(this).attr("disabled",false).removeClass("bgcol");
					return false;
				}
				else {
					// 공백이 아닌 글자를 입력했을 경우
					$(this).parent().find(".error").hide();
					$(".register-input").attr("disabled",false).removeClass("bgcol"); 
				}
			});
		});
		
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
				$(".register-input").attr("disabled",true).addClass("bgcol"); 
				$(this).attr("disabled",false).removeClass("bgcol");
				$(this).focus();
			}
			else {
				$(".error_passwd").text("입력하신 비밀번호는 사용 가능합니다.");
				$(".error_passwd").show();
				$(".register-input").attr("disabled",false).removeClass("bgcol"); 
				$("#pwdcheck").focus();
			}
		});
		
		$("#pwdCheck").blur(function(){
			var passwd = $("#regPwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) {
				$(".error_passwdCheck").show();
				$(".register-input").attr("disabled",true).addClass("bgcol");
				$(this).attr("disabled",false).removeClass("bgcol");
				$("#regPwd").attr("disabled",false).removeClass("bgcol");
				$(this).focus();
			}
			else {
				$(".error_passwdCheck").text("입력하신 비밀번호가 일치합니다.");
				$(".error_passwdCheck").show();
				$(".register-input").attr("disabled",false).removeClass("bgcol");
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
				$(".register-input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(".register-input").attr("disabled", false).removeClass("bgcol");
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
				$(".register-input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(".register-input").attr("disabled", false).removeClass("bgcol");
			}
			
		});
		
		$("#hp3").blur(function(){
			var hp3 = $(this).val();
			
			var regExp_HP3 = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			var bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(".register-input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(".register-input").attr("disabled", false).removeClass("bgcol");
			}			
		});
		
		/////////////////////// 회원가입폼 유효성검사 끝 //////////////////////////
		
		
		// 이메일인풋에서 엔터키치면 비밀번호칸으로 넘어가고, 비밀번호인풋에서 엔터키치면 로그인됨
		
		$("#loginEmail").keydown(function(event){
			if(event.keyCode == 13) {	// 엔터키
				$("#loginPwd").focus();
				event.preventDefault();
			}
		});

		$("#loginPwd").keydown(function(event){
			// 암호입력란에서 엔터키를 입력했을 경우 로그인을 시도한다.
			if(event.keyCode == 13) {	// 엔터키
				goLogin();
			}
		});
		
	});	// end of $(function(){ ---------------------------------------------------------------------
	
	
	// ---------------------- 열리는 사이드나브들 정리 -------------------------- //

	function openLoginNav() {
		$(".login-input").attr("disabled",false).removeClass("bgcol");
		$(".login-input").val("");
		$("#myLoginNav").css('display', '');
		$("#myLoginNav").css('width', '30%');
		$("#email").focus();
		event.preventDefault();
	}
	
	function closeLoginNav() {
		$("#myLoginNav").css('display', 'none');
	}
	
	function openSearchNav() {
		$("#mySearchNav").css('display', '');
		$("#mySearchNav").css('width', '30%');
	}
	
	function closeSearchNav() {
		$("#mySearchNav").css('display', 'none');
	}
	
	function openRegisterNav() {
		$(".register-input").val("");
		$("#myRegisterNav").css('display','');
		$("#myRegisterNav").css('width', '30%');
		$("#myLoginNav").css('display', 'none');
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
		$("#input_confirmCode").focus();
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
		$("#myPwdFindNav").css('display', 'none');
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
		
		var frm = document.registerFrm;
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
		
		var frm = document.loginFrm;
		frm.method = "POST";
		frm.action = "loginEndH.ysl";
		frm.submit();
	
	}
	
   function goCartList() {
	      
	      var cfrm = document.goCartFrm;
	      cfrm.method = "POST";
	      cfrm.action = "/SaintLaura/cartList.ysl"
	      cfrm.submit();
	   }
	


</script>

</head>
<body>

<div id="container">
	
<header>
	<div>
		<%-- Saint Laura LOGO --%>
		<div id="logo"><a href="<%= ctxPath %>/main.ysl"><img alt="YSL" src="images/main-logo-black.png"></a></div>
		
		<%-- Leftside Navigation --%>
		<div id="header-nav">
			<div id="left-nav">
				<ul style="list-style-type:none;">
					<li class="nav-list"><a href="<%= ctxPath %>/newproduct.ysl">신상품</a></li>
					<li class="nav-list">여성 쇼핑</li>
					<li class="submenu">&emsp;&emsp;<a href="<%= ctxPath %>/productCode.ysl?code=100000">크로스바디 백</a></li>
					<li class="submenu">&emsp;&emsp;<a href="<%= ctxPath %>/productCode.ysl?code=200000">숄더 백</a></li>
					<li class="submenu">&emsp;&emsp;<a href="<%= ctxPath %>/productCode.ysl?code=300000">클러치</a></li>
					<li class="nav-list">남성 쇼핑</li>
					<li class="submenu">&emsp;&emsp;<a href="<%= ctxPath %>/productCode.ysl?code=400000">백팩</a></li>
					<li class="submenu">&emsp;&emsp;<a href="<%= ctxPath %>/productCode.ysl?code=500000">캐쥬얼</a></li>
					<li class="submenu">&emsp;&emsp;<a href="<%= ctxPath %>/productCode.ysl?code=600000">비즈니스</a></li>
					<li class="nav-list"><a href="<%= ctxPath %>/productList.ysl?proCategory=all">모두보기</a></li>
					<li class="nav-list"><a href="<%= ctxPath %>/collection.ysl">컬렉션</a></li>
					<li class="nav-list"><a href="<%= ctxPath %>/laMasion.ysl">LA MAISON</a></li>
				</ul>
			</div>
			
			<%-- Rightside Navigation --%>
			<div id="right-nav">
				<img alt="search" src="images/header-search-icon.png" id="search-icon" onclick="openSearchNav()">
				<ul style="list-style-type:none;">
					<c:if test="${sessionScope.totalCountCart ne null}">
					<li class="nav-list"><form name="goCartFrm"><a onclick="goCartList();">쇼핑백(${sessionScope.totalCountCart})</a></form></li>
					</c:if>
					<c:if test="${sessionScope.totalCountCart eq null}">
					<li class="nav-list"><form name="goCartFrm"><a onclick="goCartList();">쇼핑백</a></form></li>
					</c:if>
					<c:if test="${ sessionScope.loginuser eq null }">
					<li id="login-panel" class="nav-list" onclick="openLoginNav()">로그인 / 등록</li>
					</c:if>
					<c:if test="${ sessionScope.loginuser ne null }">
					<li class="nav-list"><a href="<%= ctxPath %>/myAccount.ysl">나의 계정</a></li>
					</c:if>
					<c:if test="${ sessionScope.loginuser ne null }">
					<li class="nav-list"><a href="<%= ctxPath %>/myWishList.ysl">위시리스트</a></li>
					</c:if>
					<li class="nav-list"><a href="<%= ctxPath %>/customerService.ysl">고객서비스</a></li>
					<c:if test="${sessionScope.loginuser != null && (sessionScope.loginuser).idx == 2}">
					<li class="nav-list"><a href="<%= ctxPath %>/adminOrderYSL.ysl">관리자</a></li>
					</c:if>
				</ul>
			</div>

		</div>
	
		<%-- Search area --%>
		<div id="account-panel">
			<div id="mySearchNav" class="sidenav">
				<a href="javascript:void(0)" class="closebtn" style="display:inline-block !important; float:right; width:30px;" onclick="closeSearchNav()">&times;</a>
				<div class="search-container">
					<form action="<%= ctxPath %>/searchProduct.ysl" >
	                  <input type="text" class="searchProduct" id="search-input" placeholder="검색" name="searchProduct">
	                  <input type="hidden" name="searhProdCat"/>
	                  <input type="hidden" name="searchProdCatDetail"/>
	                  <input type="hidden" name="searhProdColor"/>
	               </form>
				</div>
				<hr style="border-bottom:grey">
			</div>
		</div>
	
		<%-- Login / Register area - panel --%>
		<div id="account-panel">
			<div id="myLoginNav" class="sidenav">
			  <h3 class="sidenav-h" style="display:inline !important float:left;">나의 계정</h3>
			  <a href="javascript:void(0)" class="closebtn" style="display:inline !important; float:right;" onclick="closeLoginNav()">&times;</a>
			  <hr style="border-bottom:grey">
			  
			  <%-- Login form --%>
			  <form name="loginFrm">
			  		<h4 id="loginfrm-h">로그인</h4>
			  		<ul>
			  			<li>
			  				<label>
			  					<span class="login-label" style="text-align:left">이메일 *</span>
							</label><br/>
			  				<input type="email" id="loginEmail" class="login-input" name="email" style="display:block" />
			  			</li>
			  			<li style="clear: both">&nbsp;&nbsp;</li>
			  			<li>
			  				<label>
				  				<span class="login-label" style="text-align:left">비밀번호 *</span>
			  				</label><br/>
			  				<input type="password" id="loginPwd" class="login-input" name="pwd" style="display:block" autocomplete="off" />
			  			</li>
			  			<li>
			  				<c:if test="${ requestScope.verifiedResult != 1 }">
			  				<a class="login-label" id="pwdFindLink" onclick="openPwdFindNav()">비밀번호를 잊으셨습니까?</a>
			  				</c:if>
			  				<c:if test="${ requestScope.verifiedResult == 1 }">
			  				<a class="login-label" id="pwdUpdateLink" onclick="openPwdUpdateNav()">비밀번호 재설정하기</a>
			  				</c:if>
			  			</li>
			  			<li>
			  				<button class="login-input btn-default login-btn" style="color:white">로그인</button>
			  			</li>
			  		</ul>
			  </form>
			  
			  <div>
				<h4 class="sidenav-h" style="display:block; margin-top: 50px;">등록</h4>
				<p style="font-size:11px; padding-left:20px;">나의 계정의 혜택을 누리실 수 있도록 등록하십시오.</p>
				<ul style="font-size:11px">
				  		<li>마음에 드는 아이템을 담아두는 위시리스트</li>
				  		<li>더욱 빠른 주문 완료</li>
				  		<li>주문 정보 및 진행상황 확인</li>
				</ul>
				<ul style="list-style-type: none; padding:20px;">
					<li>
						<button class="login-input btn-default" id="register-btn" onclick="openRegisterNav()">등록</button>
				  	</li>
			  	</ul>
			  </div>
			  
			</div>
			
		</div>
		
		<%-- PasswordFind area - panel --%>
		<div id="myPwdFindNav" class="sidenav">
			<h3 class="sidenav-h" style="display:inline !important float:left;">나의 계정</h3>
			<a href="javascript:void(0)" class="closebtn" style="display:inline !important; float:right;" onclick="closePwdFindNav()">&times;</a>
			<hr style="border-bottom:grey">
			<div style="padding:20px;">
				<h4 style="font-weight: bold">비밀번호를 잊으셨습니까?</h4>
				<p style="font-size: 11px">이메일을 입력하시면 확인코드를 보내드립니다.</p>
				
				<%-- PasswordFind form --%>
				<form name="pwdFindFrm" style="margin-top:30px">
		  			<label class="pwdFind-label" style="text-align:left">이메일 *</label><br/>
	  				<input type="email" class="pwdFind-input" id="pwdFindEmail" name="email" style="display:block" />
	  				
	  				<button class="pwdFind-input btn-default pwdFind-btn" id="pwdFind-btn" style="color:white; margin-top:30px; padding:0;">찾기</button>
				</form>
			
			<div id="div_findResult" align="center">
			 	<c:if test="${ requestScope.n == 1 }">
					<div style="margin: 50px 0; font-size: 11px;">
						<span>인증코드가 ${ requestScope.email } 로 발송되었습니다.</span><br/>
						<span>인증코드를 입력해주세요</span>
					</div>
					
					<c:if test="${ requestScope.n == 0 }">
						<span style="color:red; font-size: 11px;">사용자 정보가 없습니다.</span>
				 	</c:if>
					
				 	<c:if test="${ requestScope.n == -1 }">
						<span style="color:red; font-size: 11px;">메일 발송에 실패했습니다.</span>
				 	</c:if>
					<input type="text" class="pwdFind-input" name="input-confirmCode" id="input_confirmCode" required />
					<button type="button" class="pwdFind-input btn-default pwdFind-btn" id="btnConfirm-input" style="color:white; margin-top:30px; padding:0;">인증하기</button>
			 	</c:if>
			 	
			 	<form name="verifyCertificationFrm">
					<input type="hidden" name="email" />
					<input type="hidden" name="userCertificationCode" />
				</form>
			 	
			</div>
			
			</div>
		</div>
		
		<%-- PasswordUpdate area - panel --%>
		<div id="myPwdUpdateNav" class="sidenav">
			<h3 class="sidenav-h" style="display:inline !important float:left;">나의 계정</h3>
			<a href="javascript:void(0)" class="closebtn" style="display:inline !important; float:right;" onclick="closePwdUpdateNav()">&times;</a>
			<hr style="border-bottom:grey">
			<div style="padding:20px;">
				<h4 style="font-weight: bold">새로운 비밀번호를 설정하세요</h4>

				<%-- PasswordUpdate form --%>
				<form name="pwdUpdateEndFrm" style="margin-top:30px">
		  			<label class="pwdUpdate-label">
		  			<span>새 비밀번호 *</span>
		  			<span class="pwdUpdate-label error_passwd">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
		  			</label><br/>
	  				<input type="password" class="pwdUpdate-input" name="pwd" id="pwdUpdate-pwd" style="display:block" autocomplete="off" />
	  				
	  				<label class="pwdUpdate-label" style="margin-top: 20px;">
	  					<span>새 비밀번호 확인 *</span>
	  					<span class="pwdUpdate-label error_passwdCheck">암호가 일치하지 않습니다.</span>
	  				</label><br/>
	  				<input type="password" class="pwdUpdate-input" name="pwd2" id="pwdUpdate-pwd2" style="display:block" autocomplete="off" />
	  				
	  				<button class="pwdUpdate-input btn-default pwdUpdate-btn" id="pwdUpdate-btn" style="color:white; margin-top:30px; padding:0;">새비밀번호등록</button>
					<input type="hidden" name="email" value="${ requestScope.email }"/>
				</form>
			</div>
		</div>
		<%-- Register area - panel --%>
		<div id="myRegisterNav" class="sidenav">
			<h3 class="sidenav-h" style="display:inline !important float:left;">새 계정 등록</h3>
			<a href="javascript:void(0)" class="closebtn" style="display:inline !important; float:right;" onclick="closeRegisterNav()">&times;</a>
			<hr style="border-bottom:grey">
	 	<%-- 	<p class="registernav-p register-label" onclick="closeRegisterNav()">&lt; 로그인 메뉴로 돌아가기</p>--%>
	 		
	 		<%-- Register form --%>
	 		<div class="form-register">
				<form name="registerFrm">
				  	<table class="table-register">
			  			<tbody>
			  			
			  				<%-- email --%>
			  				<tr>
			  					<td>
			  						<span class="register-label" style="width: 20%; text-align: left; display: inline;">이메일 *</span>
			  						<span class="register-label error_email">이메일 형식이 올바르지 않습니다.</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td>
			  						<input type="email" id="regEmail" class="register-input requiredInfo" name="email" style="display:block" />
			  					</td>
			  				</tr>
			  				
			  				<%-- password --%>
			  				<tr>
			  					<td>
			  						<span class="register-label" style="text-align:left">비밀번호 *</span>
			  						<span class="register-label error_passwd">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td>
			  						<input type="password" id="regPwd" class="register-input requiredInfo" name="pwd" style="display:block" autocomplete="off" />
			  					</td>
			  				</tr>
			  				
			  				<%-- password check --%>
			  				<tr>
			  					<td>
			  						<span class="register-label" style="text-align:left">비밀번호확인 *</span>
			  						<span class="register-label error_passwdCheck">암호가 일치하지 않습니다.</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td>
			  						<input type="password" class="register-input requiredInfo" id="pwdCheck" style="display:block" autocomplete="off" />
			  					</td>
			  				</tr>
			  				
			  				<%-- name --%>
			  				<tr>
			  					<td>
			  						<span class="register-label" style="text-align:left">성명 *</span>
			  					</td>
			  				</tr>
			  				<tr>
			  					<td>
			  						<input type="text" class="register-input requiredInfo" name="name" style="display:block" />
			  					</td>
			  				</tr>
			  				
			  				<%-- zipcode --%>
			  				<tr>
								<td class="register-label" style="width: 20%; font-weight: bold; text-align: left; display: inline;">우편번호 *</td>
								<td class="error_post register-label">우편번호 형식이 아닙니다.</td>
							</tr>
							<tr>
								<td style="width: 80%; text-align: left;">
								   <input type="text" class="input-zipcode" id="post" name="post" size="6" maxlength="3" autocomplete="off" />
								   <!-- 우편번호 찾기 -->
								   <img id="zipcodeSearch" src="images/header-b_zipcode.gif" style="vertical-align: middle; cursor:pointer;" />
								   
								</td>
							</tr>
			  				
			  				<%-- address --%>
			  				<tr>
								<td class="register-label" style="width: 20%; text-align: left; display: inline;">주소 *</td>
								<td class="error_addr register-label">주소를 입력하세요</td>
							</tr>
							<tr>
								<td style="width: 80%; text-align: left;">
									<input type="text" id="addr1" class="address register-input requiredInfo" name="addr1" size="60" maxlength="100" autocomplete="off" /><br style="line-height: 200%"/>
									<input type="text" id="addr2" class="address register-input requiredInfo" name="addr2" size="60" maxlength="100" autocomplete="off" />
								</td>
							</tr>
			  				
			  				<%-- phone --%>
			  				<tr>
								<td class="register-label" style="margin:5px 0; padding:5px 0;">연락처</td>
							</tr>
							<tr>
								<td style="width: 80%; text-align: left; padding-bottom: 5px;">
								    <select name="hp1" id="hp1" style="width: 75px; padding: 3px;">
										<option value="010" selected>010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>&nbsp;-&nbsp;
								    <input type="text" name="hp2" class="input-hp" id="hp2" size="6" maxlength="4" autocomplete="off" />&nbsp;-&nbsp;
								    <input type="text" name="hp3" class="input-hp" id="hp3" size="6" maxlength="4" autocomplete="off" />
								</td>
							</tr>
							
							<%-- gender --%>
							<tr>
								<td class="register-label" style="margin:10px 0; padding:6px 0;">성별</td>
							</tr>
							<tr>
								<td style="width: 80%; text-align: left;">
								   <input type="radio" id="female" name="gender" value="1" />
								   <label class="register-label" for="female" style="margin-left: 2%; vertical-align: top;">여성</label>
								   
								   <input type="radio" id="male" name="gender" value="2" style="margin-left: 10%;" />
								   <label class="register-label" for="male" style="margin-left: 2%; vertical-align: top;">남성</label>
								</td>
							</tr>
							
							<%-- birthyear, birthmonth, birthday --%>
							<tr>
								<td class="register-label" style="width: 20%; font-weight: bold; padding:5px 0;">생년월일</td>
							</tr>
							<tr>
								<td style="width: 80%; text-align: left;">
								   <input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" style="width: 80px;"   />
								   
								   <select id="birthmm" name="birthmm" style="margin-left: 2%; width: 60px; padding: 3px 0;">
									</select> 
								   
								   <select id="birthdd" name="birthdd" style="margin-left: 2%; width: 60px; padding: 3px 0;">
									</select> 
								</td>
							</tr>
			  				
			  				<tr>
			  					<td>
			  						<button class="register-input btn-default" style="margin-top:10px; padding:0; color:white;">등록</button>
			  					</td>
			  				</tr>
			  			</tbody>
			  		</table>
			  	</form>
		  	</div>
		</div>
		
	</div>
</header>

<%--      header  끝            --%>