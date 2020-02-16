<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp" /> 

<link rel="stylesheet" href="css/customerEmailService.css">

<script src="<%=ctxPath%>/js_ysl/customerEmailService.js"></script>

<body>

	<form name="customerServiceEmailFrm">
		<div class="EmailServiceContainer">
			<span style="font-size: 14pt; font-weight: bold; margin-bottom: 10px;">고객님께 드리는 약속</span><br/>
			<span style="font-size: 9pt; margin-bottom: 5px;">하단의 양식을 기입해주시면 담당자가 고객님의 문의에 신속하게 답변을 드릴 것입니다. (공휴일 제외)</span><br/>
			<span style="font-size: 9pt;">필수 항목*</span><br/><br/>
			
			<div class="form-group">
				<label for="csEmailName" class="csEmailLabel">이름 *</label><br/>
				<input class="csEmailInput form-control" id="csEmailName" name="csEmailName" style="width: 535px;" />
				<span class="customerEmail_error">필수 입력사항입니다.</span>
			</div>
			<div class="form-group">
				<label for="csEmailEmail" class="csEmailLabel">이메일 *</label><br/>
				<input class="csEmailInput form-control" id="csEmailEmail" name="csEmailEmail" style="width: 535px;" />
				<span class="customerEmail_error">필수 입력사항입니다.</span>
			</div>
			<div class="form-group">
				<label for="csEmailHp" class="csEmailLabel">전화번호 *</label><br/>
				<input class="csEmailInput form-control" id="csEmailHp" name="csEmailHp" style="width: 535px;" />
				<span class="customerEmail_error">필수 입력사항입니다.</span>
			</div>
			<div class="form-group">
				<label for="csEmailCat1" class="csEmailLabel">항목 *</label><br/>
				<select class="form-control" id="csEmailCat1" name="csEmailCat1" style="width: 535px;">
					<option class="optionStyle" value="1">선택</option>
	    			<option class="optionStyle" value="상품정보">상품정보</option>
	    			<option class="optionStyle" value="구매">구매</option>
	    			<option class="optionStyle" value="환불&교환">환불&교환</option>
	    			<option class="optionStyle" value="고객경험">고객경험</option>
	  			</select>
	  			<span class="customerEmail_error">필수 입력사항입니다.</span>
			</div>
			<div class="form-group">
				<label for="csEmailCat2" class="csEmailLabel">주제 *</label><br/>
				<select class="form-control" id="csEmailCat2" name="csEmailCat2" style="width: 535px;">
	  			</select>
	  			<span class="customerEmail_error">필수 입력사항입니다.</span>
	  		</div>
	  		<div class="form-group">
				<label for="csEmailOrderNo" class="csEmailLabel">주문번호</label><br/>
				<input class="csEmailInput form-control" id="csEmailOrderNo" name="csEmailOrderNo" style="width: 535px;" />
			</div>
			<div class="form-group">
				<label for="csEmailProdNo" class="csEmailLabel">제품번호</label><br/>
				<input class="csEmailInput form-control" id="csEmailProdNo" name="csEmailProdNo" style="width: 535px;" />
			</div>
			<div class="form-group">
	  			<label for="csEmailMsg" class="csEmailLabel">메세지입력*</label>
	  			<textarea class="csEmailInput form-control" rows="5" id="csEmailMsg" name="csEmailMsg" style="width: 535px;"></textarea>
				<span class="customerEmail_error">필수 입력사항입니다.</span>
			</div>
			
			<button class="btn-third btn-Css btn-another" id="sendEmailBtn" style="color:white; margin-top:15px; width: 535px;" onclick="sendCustomerEmail(event);">전송하기</button>
			
		</div>
	</form>

</body>
</html>