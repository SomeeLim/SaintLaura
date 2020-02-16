<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>    

<jsp:include page="../header.jsp" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/customerService.css">

<script type="text/javascript">

	$(document).ready(function() {
		
		/* 교환 */
		$("#change").css("display", "none");
		$("#change-detail").on("click", function(){
			
			var status = $("#change").css("display");
			if(status == "none"){
				$("#change").slideDown(300);
				$("#progress").slideUp(300);
				$("#return").slideUp(300);
	
				$("#change-detail").html("접기");
				$("#return-detail").html("자세히 읽기");
				$("#progress-detail").html("자세히 읽기");
			}
			else {
				$("#change").slideUp(300);
				$("#change-detail").html("자세히 읽기");
			}
		});
		
		
		/* 반품 */
		$("#return").css("display", "none");
		$("#return-detail").on("click", function(){
			
			var status = $("#return").css("display");
			if(status == "none"){
				$("#return").slideDown(300);
				$("#change").slideUp(300);
				$("#progress").slideUp(300);
				
				$("#return-detail").html("접기");
				$("#change-detail").html("자세히 읽기");
				$("#progress-detail").html("자세히 읽기");
				
			}
			else {
				$("#return").slideUp(300);
				$("#return-detail").html("자세히 읽기");
			}
		});
		
		/* 진행상황 */
		
		$("#progress").css("display", "none");
		$("#progress-detail").on("click", function(){
			
			var status = $("#progress").css("display");
			if(status == "none"){
				$("#progress").slideDown(300);
				$("#return").slideUp(300);
				$("#change").slideUp(300);
				
				$("#progress-detail").html("접기");
				$("#return-detail").html("자세히 읽기");
				$("#change-detail").html("자세히 읽기");
				
			}
			else {
				$("#progress").slideUp(300);
				$("#progress-detail").html("자세히 읽기");
			}
		});

	});

	function customerEmail() {
		
		javacsript:location.href="<%=ctxPath%>/customerEmailService.ysl";
		
	}
	
	function searchStore() {
		
		javacsript:location.href="<%=ctxPath%>/searchStore.ysl";
		
	}

</script>

<body>

	<div class="container">
		<img src="images/customerService-banner.jpg" class="customerServiceBanner"/>
		<div id="customerHead">
			<span class="customerTitle">고객 서비스</span>
		</div>
		<div id="customerBody">
			<span style="font-size: 8pt;">
			문의사항이나 도움이 필요하시면 언제든지 연락주시기 바랍니다. <br/>
			운영시간은 월요일부터 토요일까지 오전 10시30분~오후 10시까지 입니다. (공휴일제외) <br/>
			담당 직원이 고객님의 문의에 성심성의껏 답변해 드리고 브랜드와 제품에 대해 자세히 안내해 드립니다. <br/>
			</span>
		</div>
	
		<div class="customerFooter col-xs-4">
			<span class="footerTitle" style="font-size: 11pt; font-weight: bold;">이메일</span>
			<br/>
			<span style="font-size: 8pt;">
				영업일 기준 24시간 이내에 회신해 드릴 수 있도록<br/>
				최선을 다하겠습니다.<br/><br/>
			</span>
			<button class="btn-third btn-Css btn-another" id="register-btn" style="color:white; margin-top:17px; font-size: 9pt;" onclick="customerEmail();">이메일 문의</button>
		</div>
		<div class="customerFooter col-xs-4">
			<span class="footerTitle" style="font-size: 11pt; font-weight: bold; color:black;">전화</span>
			<br/>
			<span style="font-size: 8pt;">
				저희 직원에게 말씀해 주세요:<br/> 
				+82 10xxxxxxxx<br/>
				월요일~토요일, 오전 10시30~오후 10시
			</span>
			<a href="tel:개인key"><button class="btn-third btn-Css btn-another" id="register-btn" style="white; margin-top:17px; font-size: 9pt;">전화 문의</button></a>
		</div>
		
		<div class="customerFooter col-xs-4">
			<span class="footerTitle" style="font-size: 11pt; font-weight: bold; color:black;">생 로라 매장 안내</span>
			<br/>
			<span style="font-size: 8pt;">
				Saint Laura의 쇼핑경험을 오프라인에서도 느껴보세요<br/> 
				전화번호 해당 매장 내 참조<br/> 
				영업시간 해당 매장 내 참조
			</span>
			<button class="btn-third btn-Css btn-another" id="register-btn" style="color:white; margin-top:17px; font-size: 9pt;" onclick="searchStore();">생 로라 매장 안내</button>
		</div>
		<hr style="color: #f2f2f2; margin-top: 230px;">
		
		
		<div style=" margin-top: 60px;">
			<div style="float:left; width:33%; font-weight: bold; font-size: 11pt;">
				자주묻는 질문
			</div>
			
			
			<div style="float:right; width:67%; font-size: 8pt;">
				<div style="margin: 0 20px 20px 20px;">
					<div style="font-weight: bold;">
						교환
					</div>
					<h6><a id="change-detail" style="font-size: 8pt; color: black; cursor: pointer; text-decoration: underline;">자세히 읽기</a></h6>
					<div id="change" style="float: right; font-size: 8pt">
						<p>구매하신 아이템의 사이즈 및/또는 색상 교환을 원하시는 경우 배송일로부터 30일 이내에 추가 비용 없이 교환하실 수 있습니다.</p>

						<p>반품신청서를 작성하세요. 이때 "교환" 옵션을 선택하시고 교환이 가능한 사이즈 및/또는 색상 중 원하시는 것을 선택하세요. 
						고객님을 위해 새로 선택하신 아이템을 보관해 놓겠습니다. 반품하신 아이템을 수령하는 즉시 기존의 배송 주소로 새로 선택하신 아이템을 보내드립니다. 
						아이템이 발송되면 고객님께 이메일로 알려 드립니다.</p>
						
						<p>사이즈 및/또는 색상 교환은 한 품목 당 1회에 한합니다. 하지만 당사의 반품정책에 기재된 내용에 따라 다시 반품하실 수 있습니다.</p>
					
					<br/><br/>
					</div>
					
				</div>
				
				<div style="margin: 20px;">
					<div style="font-weight: bold;">
						반품 현황을 알 수 있나요?
					</div>
					<h6><a id="return-detail" style="font-size: 8pt; color: black; cursor: pointer; text-decoration: underline;">자세히 읽기</a></h6>
					<div id="return" style="font-size: 8pt">
						<p>반품 현황은 
						<a style="font-size: 8pt; color: black; cursor: pointer; text-decoration: underline;" onclick="javascript:location.href='<%=ctxPath%>/orderNReturnList.ysl'">나의 반품정보</a> 
						페이지에서 언제든지 확인하실 수 있습니다.</p>
					
					<br/>
					</div>
					
				</div>
				
				<div style="margin: 20px;">
					<div style="font-weight: bold;">
						주문 진행 상황을 알 수 있나요?
					</div>
					<h6><a id="progress-detail" style="font-size: 8pt; color: black; cursor: pointer; text-decoration: underline;">자세히 읽기</a></h6>
					<div id="progress" style="font-size: 8pt">
						<p>언제든지 주문 현황을 확인하고 배송 상태를 추적하실 수 있습니다. 
						<a style="font-size: 8pt; color: black; cursor: pointer; text-decoration: underline;" onclick="javascript:location.href='<%=ctxPath%>/orderNReturnList.ysl'">나의 주문정보</a> 페이지에서 이메일로 보내드린 주문 번호를 입력하세요. 
						가입하신 고객님께서는 나의 계정에서 주문과 관련된 모든 정보를 확인하실 수 있습니다.</p>
					
					<br/>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
</body>
</html>
