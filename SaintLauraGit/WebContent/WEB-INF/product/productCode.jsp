<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />    
    

<link rel="stylesheet" href="css/productCode.css">

<body>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#totalCodeCount").hide();
		$("#countCode").hide();
		
		// 카테고리별 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대해 초기값 호출  
		displayCode("1");
		
		// HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션의 이벤트 등록하기 
		$("#btnMore").click(function(){
			
				displayCode($(this).val());
		});
		
	});// end of $(document).ready()---------------
	
	
	var len = 9; 
	// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 갯수(단위)크기 
	
	
	// display 할 상품정보를 추가요청하기(Ajax로 처리함)
	function displayCode(start) {
		
		$.ajax({
			url:"<%= ctxPath%>/productCodeJSON.ysl",
		//	type:"GET",
		    data:{"pcategory_fk":"${code}"
		    	 ,"start":start
		    	 ,"len":len},
		    dataType:"JSON",
		    success:function(json){
		    	//alert("성공");
		    	var html = "";
		    	
		    	var idx = "<c:out value='${sessionScope.loginuser.idx}'></c:out>"
		    		
		    	if(json.length == 0) {
		    		
		    		$("#btnMore").hide();
		    		
		    	}
		    	else {
		    		// 데이터가 존재하는 경우
		    		$.each(json, function(index, item){
		    			if((index+1)%3 != 0) {		    					
							html += "<article class='item'>" 
								  + "<div class='image' >"	
								  + "<a href='/SaintLaura/productDetail.ysl?pnum="+item.pnum+"' style='text-decoration: none;'>"
								  + "<img class='listViewImage mainImage' src='/SaintLaura/images_Product/"+item.pimage1+"' style='width: 280px; height: 420px;'>"
								  + "<img class='listViewImage hoverImage' src='/SaintLaura/images_Product/"+item.pimage2+"' style='width: 280px; height: 420px;' >"
								  + "</div><br>"
								  
	 							  + "<div id='infoBox'>"
								  + 	"<div class='info'>"
								  + 		"<span class='info'>"+(item.pname).substr(0,24)+"<br>"+(item.pname).substr(25,43)+"<br>"+(item.pname).substr(44,100)+"</span><br><br>"
								  + 		"<span class='info'>&#8361; &nbsp;</span>"
								  + 		"<span class='info'>"+(item.price).toLocaleString('en')+"</span><br><br>"
								  + 	"</div>"
							      + "</div>"
							      + "</a>";
							 
							 if(idx == 2) {
								 
								 html += "<a href='/SaintLaura/deleteProduct.ysl?pnum="+item.pnum+"' style='text-decoration: none;'>" +
								 		 "<div style='color:#b3b3b3; border: solid 1px #d9d9d9; text-align:center; padding: 7px 0px; margin-bottom:10px;'>삭제</div></a>";
								 
							 }
							      
							 html += "</article>";
						}
						else {
							html += "<article class='item'>" 
								  + "<div class='image' >"	
								  + "<a href='/SaintLaura/productDetail.ysl?pnum="+item.pnum+"' style='text-decoration: none;'>"
								  + "<img class='listViewImage mainImage' src='/SaintLaura/images_Product/"+item.pimage1+"' style='width: 280px; height: 420px;'>"
								  + "<img class='listViewImage hoverImage' src='/SaintLaura/images_Product/"+item.pimage2+"' style='width: 280px; height: 420px;' >"
								  + "</div><br>"
								  
	 							  + "<div id='infoBox'>"
								  + 	"<div class='info'>"
								  + 		"<span class='info'>"+(item.pname).substr(0,24)+"<br>"+(item.pname).substr(25,43)+"<br>"+(item.pname).substr(44,100)+"</span><br><br>"
								  + 		"<span class='info'>&#8361; &nbsp;</span>"
								  + 		"<span class='info'>"+(item.price).toLocaleString('en')+"</span><br><br>"
								  + 	"</div>"
							      + "</div>"
							      + "</a>"
							      
					      if(idx == 2) {
								 
								html += "<a href='/SaintLaura/deleteProduct.ysl?pnum="+item.pnum+"' style='text-decoration: none;'>" +
								 		"<div style='color:#b3b3b3; border: solid 1px #d9d9d9; text-align:center; padding: 7px 0px; margin-bottom:10px;'>삭제</div></a>";
						  }
					      
					      html += "</article>" + "<br>";
						}
		    		});

		    		// HIT 상품 결과를 출력하기
		    		$("#displayCode").append(html);
		    		
		    		// hover
					$(".hoverImage").hide();
					$(".item").hover(function () {
			
						$(this).find(".mainImage").css('display','none');
						$(this).find(".hoverImage").css('display','');
						
						}, function () {
						
						$(this).find(".mainImage").css('display','');
						$(this).find(".hoverImage").css('display','none');
					
					});
		    		
		    		
					// 더로드하기... 버튼의 value 속성에 값을 지정하기
		    		$("#btnMore").val(parseInt(start)+len);

					// countCode 에 지금까지 출력된 상품의 갯수를 누적해서 기록한다. 
		    		$("#countCode").text( parseInt($("#countCode").text()) + json.length);
		    		
		    		if( $("#countCode").text() == $("#totalCodeCount").text() ) { 
		    			$("#btnMore").hide();
		    		}
		    		
		    	}
		    },
		    error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	}
	
</script>
	<div class="container">
		<div id="displayCode" ></div>
		<br>
		<div id="moveTable">
			<button type="button" id="btnMore" value="" class="theload" >더 로드하기..</button>
			<span id="totalCodeCount">${totalCodeCount}</span>
			<span id="countCode">0</span>
		</div>
	</div>   
	<br><br><br>

</body>
</html>