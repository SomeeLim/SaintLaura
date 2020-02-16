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

<script type="text/javascript">

	$(document).ready(function() {
		
		prodUpload();
		
	});
	
	function prodUpload() {
		
		var frm = document.prodUploadFrm;
		frm.submit();
		
		$.ajax({
			
			url:"/SaintLaura/prodUpload.ysl",
			method:"POST",
			dataType:"JSON",
			success:function(json){
				
				alert(json.successObj);
				
			},
			
			error: function(request, status, error){
				alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
			}
	});

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

		<%-- 상품등록 --%>
		<form name="prodUploadFrm"
			  method="POST"
			  enctype="multipart/form-data"
			  action="<%=ctxPath%>/prodUpload.ysl">
			<div class="adminContent adminContentProduct">
				<table class="adminTable">
					<tr>
						<td>상품카테고리</td>
						<td>							
							<div class="form-group">
							  <select class="form-control" id="pcategory_k" name="pcategory_fk">
							    <option value="100000">여성-크로스바디백</option>
							    <option value="200000">여성-숄더백</option>
							    <option value="300000">여성-클러치</option>
							    <option value="400000">남성-백팩</option>
							    <option value="500000">남성-캐쥬얼</option>
							    <option value="600000">남성-비즈니스</option>
							  </select>
							</div>
						</td>
					</tr>
					<tr>
						<td>상품명</td>
						<td>
							<div class="form-group">
							  <input type="text" class="form-control" id="pname" name="pname">
							</div>
						</td>
					</tr>
					<tr>
						<td>상품가격</td>
						<td>
							<div class="form-group">
							  <input type="text" class="form-control" id="price" name="price">
							</div>
						</td>
					</tr>
					<tr>
						<td>상품설명</td>
						<td>
							<div class="form-group">
							  <textarea class="form-control" rows="5" id="pcontent" name="pcontent"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td>상세색상</td>
						<td>
							<div class="form-group">
							  <input type="text" class="form-control" id="pcolor" name="pcolor">
							</div>
						</td>
					</tr>
					<tr>
						<td>상세크기</td>
						<td>
							<div class="form-group">
							  <input type="text" class="form-control" id="psize" name="psize">
							</div>
						</td>
					</tr>
					<tr>
						<td>상세소재</td>
						<td>
							<div class="form-group">
							  <input type="text" class="form-control" id="pmaterial" name="pmaterial">
							</div>
						</td>
					</tr>
					<tr>
						<td>상품재고</td>
						<td>
							<div class="form-group">
							  <input type="text" class="form-control" id="pqty" name="pqty">
							</div>
						</td>
					</tr>
					<tr>
						<td>이미지파일(4)</td>
						<td>
							<div class="form-group">
							  <input type="file" class="form-control inputFile" id="pimage1" name="pimage1">
							  <input type="file" class="form-control inputFile" id="pimage2" name="pimage2">
							  <input type="file" class="form-control inputFile" id="pimage3" name="pimage3">
							  <input type="file" class="form-control inputFile" id="pimage4" name="pimage4">
							</div>
						</td>
					</tr>	
					<tr>
						<td colspan="2" style="text-align: center;"> 
							<button class="login-input btn-third btn-Css btn-another" id="register-btn" style="color:white; font-size: 9pt; width: 600px;">상품 등록</button>						
						</td>
					</tr>						
				</table>	
								
													
			</div>
		</form>
		<%-- 상품등록 끝 --%>

	</div>
</div>

</body>
</html>