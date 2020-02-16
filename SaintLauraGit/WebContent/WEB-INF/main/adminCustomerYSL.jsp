<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="<%=ctxPath%>/css/adminYSL.css?after">
<script src="<%=ctxPath%>/js_ysl/payment.js"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">

<%-- <script src="<%=ctxPath%>/js_ysl/adminYSL.js"></script> --%>

<script type="text/javascript">

$(document).ready(function() {
	
	/* $(".adminContent").hide();
	$(".adminContentCustomer").show();
	$(".adminMenu span").removeClass("menuFontBold");
	$("#adminCustomer").addClass("menuFontBold"); */
	
	currentShowPageNo = 1;
	customerSearch();
			
	$("#searchCustomerWord").bind("keydown", function(event) {			
		
		if(event.keyCode==13) {
			event.preventDefault();
			var searchCustomerWord = $(this).val();
			currentShowPageNo = 1;
			customerSearch();
		}
	})
					
	$("#memberType").bind("change", function() {
		currentShowPageNo = 1;
		customerSearch();
		
	})
	
});

var currentShowPageNo = 1; // 현재 페이지 변수를 1로 초기화

function customerSearch() {		
	
	var searchCustomerType = $("#searchCustomerType").val();	
	var searchCustomerWord = $("#searchCustomerWord").val();
	var memberType = $("#memberType").val();

	
	$("#searchCustomerType").bind("change", function() {			
		searchCustomerType = $(this).val();
	})		
					
	$("#memberType").bind("change", function() {			
		searchCustomerType = $(this).val();
		
	})
				
	// 회원목록 DB에서 가져오기 && 페이지처리
	$.ajax({
		
		url:"/SaintLaura/customerList.ysl",
		data:{"searchCustomerType":searchCustomerType,"searchCustomerWord":searchCustomerWord,"memberType":memberType,"currentShowPageNo":currentShowPageNo},
		dataType:"JSON",
		success:function(json){
			
			var list = json.listArray;
			var page = json.pageArray;
			
			$("#adminCustomerList").empty();				
			
			var html ="";
			
			html += "<thead>";
			html += "<tr class='adminTableTR'>";
			html += "<th>고객번호</th>";
			html += "<th>이메일</th>";
			html += "<th>성명</th>";
			html += "<th>연락처</th>";
			html += "<th>가입상태</th>";
			html += "</tr>";
			html += "</thead>";
			html += "<tbody>";
			
			if(list.length == 0) {
				html += "<tr class='adminTableTR' style='cursor: pointer;' onclick='goCustomerDetail();'>";
				html += "<td colspan='5'>";
				html += "가입된 회원이 없습니다.";
				html += "</td>";
				html += "</tr>";
			}
			
			else {
				
				$.each(list, function(index, item) {						
						
						html += "<tr class='adminTableTR' id='pagingTR"+index+"' style='cursor: pointer;' onclick='goCustomerDetail("+item.idx+");'>";
						html += "<td>" +item.idx+ "</td>";
						html += "<td>" +item.email+ "</td>";
						html += "<td>" +item.name+ "</td>";
						html += "<td>" +item.hp1+ "-" +item.hp2+ "-" +item.hp3+ "</td>";
						html += "<td>" +item.status+ "</td>";
						html += "</tr>";
				
				});					
			}
			
			html += "</tbody>";
			
			$("#adminCustomerList").html(html);
			
			
			// #### Pagination
			
			currentShowPageNo = page[0].currentShowPageNo;
			var totalPage = page[0].totalPage;
			var pageNo = page[0].pageNo;
			var blockSize = page[0].blockSize;
			var loop = page[0].loop;
											
			$("#adminCustomerPageBar").empty();
			
			// previous				
			if(pageNo != 1) {
				
				$("#adminCustomerPageBar").append("<li class='page-item goPreviousPage'>"+
												  "<a class='page-link' aria-label='Previous'>" +
						   						  "<span aria-hidden='true'>&laquo;</span>" +
						   						  "<span class='sr-only'>Previous</span>" +
						   						  "</a></li>")
			}
			
			// Page Bar				
			while(!(loop>blockSize || pageNo>totalPage)) {				
				
				$("#adminCustomerPageBar").append("<li class='page-item goPage' data-page="+pageNo+"><a class='page-link'>"+pageNo+"</a></li>");
				pageNo = pageNo + 1;						
				loop = loop + 1;						
															
			}			
			
			// Next
			if(pageNo<totalPage) { // 페이지 수가 총 페이지 수보다 크다면
				$("#adminCustomerPageBar").append("<li class='page-item goNextPage'>" +
						   						  "<a class='page-link' aria-label='Next'>" + 
						   						  "<span aria-hidden='true'>&raquo;</span>" +
						   						  "<span class='sr-only'>Next</span>" +
						   						  "</a></li>");
			}
			
			// 이전 페이지블럭으로
			$("#adminCustomerPageBar").find(".goPreviousPage").bind("click", function() {					
				currentShowPageNo = pageNo-(pageNo%10);					
				customerSearch();					
			});
			
			// 페이지 번호를 누른다면
			$("#adminCustomerPageBar").find(".goPage").bind("click", function() {	
				currentShowPageNo = $(this).attr("data-page");					
				customerSearch();					
			});
			
			// 다음 페이지 블럭으로
			$("#adminCustomerPageBar").find(".goNextPage").bind("click", function() {					
				currentShowPageNo = pageNo;					
				customerSearch();					
			});
						
			
		},
		
		error: function(request, status, error){
			alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
		}
					
	});
} // end of function customerSearch() ---------------



function goCustomerDetail(idx) {
	
	$(".adminContent").hide();
	$(".adminCustomerDetail").show();
	
	$.ajax({
		
		url:"/SaintLaura/customerDetail.ysl",
		data: {"idx":idx},
		dataType:"JSON",
		success:function(json){
			
			var html = "";
			
			if(json.length==0) {
				html += "<tr>";
				html += "<td>가입된 회원이 없습니다.<td>";
				html += "</tr>";
			}
			
			else {
				
				html += "<tr class='adminTableTR'>";
				html += "<td>회원번호</td>";
				html += "<td>"+json.idx+"</td>";
				html += "<td>이메일</td>";
				html += "<td>"+json.email+"</td>";
				html += "</tr>";
				html += "<tr class='adminTableTR'>";
				html += "<td>회원명</td>";
				html += "<td>"+json.name+"</td>";
				html += "<td>연락처</td>";
				html += "<td>"+json.hp1+ "-" +json.hp2+ "-" +json.hp3+"</td>";
				html += "</tr>";
				html += "<tr class='adminTableTR'>";
				html += "<td>우편번호</td>";
				html += "<td>"+json.post+"</td>";
				html += "<td>주소</td>";
				html += "<td>"+json.addr1 + json.addr2+"</td>";
				html += "</tr>";
				html += "<tr class='adminTableTR'>";
				html += "<td>성별</td>";
				html += "<td>"+json.gender+"</td>";
				html += "<td>생년월일</td>";
				html += "<td>"+json.birthday+"</td>";
				html += "</tr>";
				html += "<tr class='adminTableTR'>";
				html += "<td>가입일자</td>";
				html += "<td>"+json.registerday+"</td>";
				html += "<td>가입상태</td>";
				html += "<td>"+json.status+"</td>";
				html += "</tr>";
				
				if(json.status=="회원") {
					var status = 1;
					html += "<tr class='adminTableTR'>";
					html += "<td colspan='4' style='cursor:pointer; text-decoration:underline;' onclick='changeStatus("+status+","+json.idx+")'>탈퇴회원으로 변경</td>";
					html += "</tr>";
				}
				else {
					var status = 0;
					html += "<tr class='adminTableTR'>";
					html += "<td colspan='4' style='cursor:pointer; text-decoration:underline;' onclick='changeStatus("+status+","+json.idx+")'>일반회원으로 변경</td>";
					html += "</tr>";
				}
				
				html += "<tr>";
				html += "<td colspan='4' style='text-align: center; border-left: hidden; border-right: hidden; border-bottom: hidden; vertical-align: middle;''>";
				html += "<button class='login-input btn-default login-btn' id='register-btn' style='color:white; font-size: 9pt; width: 160px;' onclick='javascript:location.reload(true)'>목록으로</button>";
				html += "</td>";
				html += "</tr>";
				
			}
			
			$("#adminOrderDetailTable").html(html);
			
		}, 
		
		error: function(request, status, error){
			alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
		}
		
	});
	
} // end of function goCustomerDetail(idx)----------------- 

function changeStatus(status, idx) {
	
	$.ajax({
		
		url:"/SaintLaura/changeMemberStatus.ysl",
		type:"POST",
		data:{"status":status
			 ,"idx":idx},
		dataType:"JSON",
		success:function(json){
			
			if(json.n == 1) {
				alert("회원업데이트에 성공하였습니다.");
			}
			else {
				alert("회원업데이트에 실패하였습니다.");
			}
			
			goCustomerDetail(idx);
			
		}, 
		
		error: function(request, status, error){
			alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
		}
		
	});
	
}

</script>


	<div id="adminContainer">
		<div class="adminrow adminFirRow">
			<img src="images/payment-logo.png" class="admingLogo" />
		</div>
		<div class="col-xs-3 adminMenurow adminrow" style="border-right: hidden;" >
			<div class="adminMenu adminOrder"><span id="adminOrder" onclick="location.href='adminOrderYSL.ysl'">주문&반품리스트</span></div>
		</div>
		<div class="col-xs-3 adminMenurow adminrow" style="border-right: hidden; border-left: hidden;">
			<div class="adminMenu adminProduct"><span id="adminProduct" onclick="location.href='adminProdUploadYSL.ysl'">상품등록</span></div>
		</div>
		<div class="col-xs-3 adminMenurow adminrow" style="border-right: hidden; border-left: hidden;">
			<div class="adminMenu adminCustomer"><span id="adminCustomer" onclick="location.href='adminCustomerYSL.ysl'">고객리스트</span></div>
		</div>
		<div class="col-xs-3 adminMenurow adminrow" style="border-left: hidden;">
			<div class="adminMenu adminService"><span id="adminService" onclick="location.href='adminContactYSL.ysl'">관리자</span></div>
		</div>

		<div class="adminContentrow adminrow">			
		
		<%-- 고객리스트 --%>
		<div class="adminContent adminContentCustomer" id="adminContentCustomer">			
			<form name="adminCustomerFrm">
				<div class="form-group">
				  <select id="searchCustomerType" name="searchCustomerType" class="form-control" id="sel1" style="width: 100px; height: 30px; margin-left: 108px; font-size: 9pt; display: inline;">
				    <option style="font-size: 9pt;" value="email">이메일</option>
				    <option style="font-size: 9pt;" value="name">이름</option>
				    <option style="font-size: 9pt;" value="hp3">연락처</option>
				  </select>
				  <input type="text" class="form-control" id="searchCustomerWord" name="searchCustomerWord" id="usr" size="10" style="display: inline; width: 120px; height: 28px" placeholder="Enter" />
				  <select class="form-control" name="memberType" id="memberType" id="sel1" style="width: 100px; height: 30px; margin-left: 370px; font-size: 9pt; display: inline;">
				    <option value="2" style="font-size: 9pt;">모두보기</option>
				    <option value="1" style="font-size: 9pt;">활동회원</option>
				    <option value="0" style="font-size: 9pt;">탈퇴회원</option>
				  </select>
				</div>
			</form>
			
			<table class="adminTable adminCustomerList" id="adminCustomerList">					
			</table>
			
			<nav class="bottomNav" aria-label="Page navigation example">
 					<ul class="pagination pg-blue" id="adminCustomerPageBar" style="cursor: pointer;">
 					</ul>
			</nav>
		</div>
		<%-- 고객리스트 끝 --%>
		
		<%-- 고객상세 --%>
		<div class="adminContent adminCustomerDetail">
			<table class="adminOrderDetailTable" id="adminOrderDetailTable">
			</table>
		</div>	
		<%-- 고객상세 끝 --%>
		
	</div>
</div>

</body>
</html>