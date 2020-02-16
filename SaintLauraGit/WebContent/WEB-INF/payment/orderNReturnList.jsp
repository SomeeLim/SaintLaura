<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>     
<jsp:include page="../header.jsp" />

<!-- <link rel="stylesheet" href="css/myAccount.css"> -->
<link rel="stylesheet" href="css/orderNReturnList.css">
<script src="<%=ctxPath%>/js_ysl/orderNReturnList.js"></script>

<script type="text/javascript">

$(document).ready(function () {
	
	getOrderNReturnList("${sessionScope.loginuser.idx}");
	
	$(".logoutMenu").click(function(){
		
		alert("로그아웃 되었습니다.");
		location.href="logout.ysl";
		
	});
	
});

function getOrderNReturnList(idx, start) {
	
	$.ajax({
			
			url:"/SaintLaura/orderNReturnList.ysl",
			method:"POST",
			data:{"idx":idx},
			dataType:"JSON",
			success:function(json) {
				
				var html = "";
				
				html += "<tr><th class='mainLine info col-xs-2'>주문 번호</th>" +
						"<th class='mainLine info col-xs-2'>날짜</th>" +
						"<th class='mainLine info col-xs-2'>상태</th>" +
						"<th class='mainLine info col-xs-2'>가격</th>" +
						"<th class='mainLine info col-xs-2'>반품 번호</th>" +
						"<th class='mainLine info col-xs-2'>상세정보</th></tr>";
				
				if(json.length == 0) {
					
					html += "<tr>" +
							"<td colspan='6' width='100' style='border-top: solid 1px #e9e9e9; text-align: center; font-size:9pt; padding:30px 0;'>주문하신 상품이 존재하지 않습니다</td></tr>";
					   
					
					$("#orderTable").html(html);
					
				}
				else {
					
					
					$.each(json, function(index,item) {
						
							getReturnStatus(item.orderNo_fk, index)

							html += "<tr><td class='mainLine1 info col-xs-2 orderNumber'>"+item.orderNo_fk+"</td>" +
									"<td class='mainLine1 info col-xs-2'>"+item.orderDate+"</td>" +
									"<td class='mainLine1 info col-xs-2'>"+item.orderStatus+"</td>" +
									"<td class='mainLine1 info col-xs-2 orderPrice'>￦ <span>"+numberWithCommas(item.price)+"</span></td>" +
									"<td class='mainLine1 info col-xs-2 returnStatus"+index+"'></td>" +
									"<td class='mainLine1 info col-xs-2 push'><a href='/SaintLaura/orderDetail.ysl?idx="+idx+"&orderNo_fk="+item.orderNo_fk+"' style='text-decoration: none; color:black;'>보기</a></td></tr>";
						
					});
					
				}
		
				$("#orderTable").html(html);
				
			},
			
			error: function(request, status, error){
				alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
			} 
			
		});			
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function getReturnStatus(orderNo_fk, index) {

	$.ajax({
		
		url:"/SaintLaura/returnList.ysl",
		method:"POST",
		data:{"orderNo_fk":orderNo_fk},
		dataType:"JSON",
		success:function(json) {
			
			var html = "";
			
			
			if(json.orderDetailNo_fk == "") {
				
				html = "";
				
				$(".returnStatus"+index).html(html);
				
			}
			else {
				
				html += "<a href='/SaintLaura/returnDetail.ysl?orderNo="+orderNo_fk+"' style='color:black;'>교환반품상세</a>";
				
				$(".returnStatus"+index).html(html);
				
			}
			
		},
		
		error: function(request, status, error){
			alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
		} 
		
	});	

}


</script>

<body>

	<div class="container">
		<img src="images/myAccount_Banner.jpg" class="myAccountBanner"/>
		<div style="border: solid rgb(239, 239, 239) 1px;" >
			<ul class="logged">
				<li class="profileMenu basicMenu" onclick="javascript:location.href='<%=ctxPath%>/myAccountUpdate.ysl'">나의 정보</li>
				<li class="orderMenu basicMenu">주문&반품</li>
				<li class="wishlistMenu basicMenu" onclick="javascript:location.href='<%=ctxPath%>/myWishList.ysl'">위시리스트</li>
				<li class="logoutMenu">로그아웃</li>
			</ul>
		</div>
		<div class="welcomeMsg" style="border: solid rgb(239, 239, 239) 1px; border-top: hidden;">
			<div class="hello">주문 & 반품</div>
			<div class="explanation">구매 내역과 배송 현황을 확인하십시오. 여기에서 반품신청서 작성 및 환불 정보 확인이 가능합니다.</div>
		</div>
		
		<form>
			<table id="orderTable">
			</table>
		</form>
	</div>		
		
</body>
</html>