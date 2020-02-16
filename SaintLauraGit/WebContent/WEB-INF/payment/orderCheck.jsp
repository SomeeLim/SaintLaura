<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="<%=ctxPath %>/css/orderCheck.css">
<%-- <script src="<%=ctxPath%>/js_ysl/payment.js"></script>--%>
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">

<%--      contents  시작            --%>

<script type="text/javascript">

	$(document).ready(function () {
		
		$.ajax({
			
			url:"/SaintLaura/sendMessage.ysl",
			method:"POST",
			dataType:"JSON",
			success:function(json) {
				
				//alert("문자메세지 발송 성공!");
			},
			
			error: function(request, status, error){
				alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
			} 
			
		});
		
	});
	
	function afterEdit() {
		
			// $(".beforeEdit").css({'display':'flex'});
			$(".afterEdit").css({'display':'none'});
			
			$("#afterEditName").val();		
			$("#afterEditPost").val();
			$("#afterEditAddr1").val();
			$("#afterEditAddr2").val();
			$("#afterEditHp").val();
			
	} 
	
	function totalCartPayment() {
		
		var totalcartval = ${list.price * list.oqty}
		
	}
	
	
</script>


<div class="Mycontainer">

	<div class="pay-session isLogged">	
		<span class="login-id" style="font-size: 10pt;" aria-label="${(sessionScope.loginuser).email}으로 로그인하셨습니다">
		 ${(sessionScope.loginuser).email}
		</span>
		
		<div class="logout">    	
		<a class="logoutLink" href="javascript:void(0)">
		<span class="text">로그아웃</span>
		</a>
		</div>
	</div>
	
	<div class="pay-top">
		<img align="middle"  src="images/payment-logo.png"/>
	</div>
	
	<div class="pay-left col-xs-6 col-sm-7 cstm-col-md-4">
		
		<span id="pay-title">배송 주소</span>
		
	<c:if test="${not empty paraMap}">
		<div class ="payInfo beforeEdit" style="display: flex;">	 		
			<div id="deliveryInfo">
				<ul>
					<li class="subtitle">받는 사람</li>					
					<li class="contents"><span>이름</span><span class="beforeEditDetail" id="beforeEditName">${paraMap.afterEditName}</span></li>
					<li class="contents"><span>우편번호</span><span class="beforeEditDetail" id="beforeEditPost">${paraMap.afterEditPost}</span></li>
					<li class="contents"><span>주소</span><span class="beforeEditDetail" id="beforeEditAddr1">${paraMap.afterEditAddr1}</span></li>
					<li class="contents"><span>상세주소</span><span class="beforeEditDetail" id="beforeEditAddr2">${paraMap.afterEditAddr2}</span></li>				
				</ul>
			</div>
			
			<div id="myInfo">
				<ul>
					<li class="subtitle">연락처</li>
					<li class="contents"><span>이메일</span><span class="beforeEditDetail" id="beforeEditEmail">${(sessionScope.loginuser).email}</span></li>
					<li class="contents"><span>전화번호</span><span class="beforeEditDetail" id="beforeEditHp">${paraMap.afterEditHp}</span></li>
				</ul> 
			</div>
		</div>	
		</c:if>	
		
		
	  
		
		<div class="payDeliveryType">
			<span id="pay-title">주문 완료</span>
			<span class="contents contentHoliday" style="font-weight: bold;">고객님의 주문이 성공적으로 완료되었습니다.</span>
			<span class="contents">주문번호 :&nbsp;<span>${paraMap.orderNo}</span></span><br/>
			<span class="contents">
				곧 주문확인 이메일을 보내드립니다.<br/>
				배송 도착 시점에서 한달 이내에 고객센터를 통하여 반품하실 수 있습니다.
			</span>		
		</div>	
	
	</div>
	
	<div >
		<aside class="pay-right col-xs-6 col-sm-5 cstm-col-md-8">	
		<div class="cartInfo">
		<span id="pay-title">주문 상품</span>
		</div>
	<c:if test="${not empty cartList}" >
		<c:forEach var="list" items="${cartList}">
		<section>
			<div class="cartInfo">
					<span class="subtitle">주문상품&nbsp;&nbsp;(<span class='count subtitle'>${list.oqty}</span>)</span>
					<div><a><span class="text"></span></a></div>
				</div>
				<div class="payInfo">
					<div id="pay-img" style="width: 80	px; height: 130px;">
			        	<img src="images_Product/${list.pimage1}" />
			        </div>
					<div class="pay-pro"> 
						<ul style="width: 150px;">
							<li><span>${list.pname}</span></li>
							<li class="subtitle" style="margin-top: 30px;">컬러 : <span style="font-weight: normal;">${list.pcolor}</span>
							<li class="subtitle">수량 : <span style="font-weight: normal;">${list.oqty}</span></li>		
						</ul>
					</div> 
					<div class="pay-mini">
							<span class="contents"><span>₩</span><span class="price">${list.price}</span></span>
					</div>
				</div>						
			</section>
		</c:forEach>
  	</c:if>

 
		<section>
		
		<div class="pay-pri">		
			<ul>
			<c:if test="${not empty cartList}" >
			<c:set var = "sum" value = "0" />
				<c:forEach var="cart" items="${cartList }">
					<c:set  var= "sum" value="${sum + cart.price}" />
				</c:forEach>

				<li class="totalPayInfo totalPayInfo1">
				 <div class="contents value">
					<span>소계</span>
				 </div>
				 <div class="contents value value-right">
                    <span class="price">
                    <span class="currency">₩</span>
                    <span class="value"><fmt:formatNumber value="${sum}" pattern="###,###" /></span>
       			    </span>
   				 </div>
				</li>

  	     	</c:if>
				<li class="totalPayInfo totalPayInfo2">
				 <div class="contents value">
					<span>배송 방법</span>
				 </div>
				 <div class="contents value delivery">
                    <span class="deliveryType">익스프레스</span>
   				 </div>
   				 <div class="contents value value-right">
                    <span class="price">
                    <span class="currency">₩</span>
                    <span class="value" style="text-decoration: line-through;">25,000</span>
       			    </span>
       			    <span class="free">
                    <span class="value" data-ytos-price="0.0000">무료</span>
        			</span>
   				 </div>   				 
				</li>
				 
				<li class="totalPayInfo totalPayInfo3">
				 <div class="contents value">
					<span>결제 방법</span>
				 </div>
				 <div class="contents value delivery">
                    <span class="deliveryType">신용카드</span>
   				 </div>  				 
				</li>
									
				<li class="totalPayInfo totalPayInfo4">
				 <div class="subtitle value totalPay">
					<span>총 결제 금액</span>
				 </div>
				 <div class="subtitle value value-right">
                    <span class="price">
                    <span class="currency">₩</span>
                    <c:if test="${not empty cartList}" >					
                    	<span class="totalCartPayment"><fmt:formatNumber value="${sum}" pattern="###,###" /></span>
  					</c:if>	
       			    </span>       			      
   				 </div>
   				 <span class="subtitle taxLabel">(모든 세금과 관세 포함)</span> 
				</li> 
				
		    </ul>
		    </div> 	
		</section>
				 
		<button type="button" class="btn-third btn-Css btn-another" id="pay-btn" style="color:white; margin: 7px 0 20px 0; height: 40px;" onclick="javascript:location.href='orderNReturnList.ysl'">주문 목록</button>
		</aside>
    </div>
</div>
</body>
</html>