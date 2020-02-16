<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />     
<link rel="stylesheet" href="css/searchProduct.css">

<script type="text/javascript">

	$(document).ready(function() {
			
		$("#btnMore").show();
		displayMore("1");

		$("#btnMore").click(function () {	

			$("#btnMore").show();
			displayMore($(this).val());

		});
		
		// === *** 필터 *** ===
			
		$("select[name=prodDetailCatFilter]").attr("disabled", true);
		
		$("select[name=prodCatFilter]").bind("change", function() {
			
			$("select[name=prodDetailCatFilter]").attr("disabled", false);
			
			$(".productListbySearch").empty();
			$("#btnMore").show();
			$("select[name=prodDetailCatFilter]").val("");
			displayMore("1");
		 	
			var catFilter = $(this).val();
			var html = "";
			
			if(catFilter=="") {
				$("select[name=prodDetailCatFilter]").attr("disabled", true);
			}
			
			if(catFilter=="여성") {

				html += "<option class='optionStyle' value=''>모두보기</option>";
				html += "<option class='optionStyle' value='크로스'>크로스바디백</option>";
				html += "<option class='optionStyle' value='숄더'>숄더백</option>";
				html += "<option class='optionStyle' value='클러치'>클러치</option>";
				
				$("#prodDetailCatFilter").html(html);
				
				
				
			} 
			
			if(catFilter=="남성") {
								
				html += "<option class='optionStyle' value=''>모두보기</option>";
				html += "<option class='optionStyle' value='백팩'>백팩</option>";
				html += "<option class='optionStyle' value='캐쥬얼'>캐쥬얼</option>";
				html += "<option class='optionStyle' value='비즈니스'>비즈니스</option>";
				
				$("#prodDetailCatFilter").html(html);
				
			} 
			

		});
		
		$("select[name=prodDetailCatFilter]").bind("change", function() {
			$(".productListbySearch").empty();
			$("#btnMore").show();
			displayMore("1");
		});
		
		$("select[name=prodColorFilter]").bind("change", function() {
			$(".productListbySearch").empty();
			$("#btnMore").show();
			displayMore("1");
		});
		

	});
	
	function displayMore(start) {
		
		var searchProduct = "${searchProduct}";
		var searhProdCat = $("select[name=prodCatFilter]").val();
		var searchProdCatDetail = "";
		var searhProdColor = "";
		if($("select[name=prodDetailCatFilter]").val()!=null) {
			searchProdCatDetail = $("select[name=prodDetailCatFilter]").val();
		}
		if($("select[name=prodColorFilter]").val()!=null) {
			searhProdColor = $("select[name=prodColorFilter]").val();
		}
		 
		
		$.ajax({
			
			url:"/SaintLaura/searchProductByJSON.ysl",
			data:{"searhStartNo":start
				 ,"searhProdCat":searhProdCat
				 ,"searchProdCatDetail":searchProdCatDetail
				 ,"searhProdColor":searhProdColor
				 ,"searchProduct":searchProduct},
			dataType:"json",
			success:function(json){
				
				var html = "";
				
				if(json.length==0) {
					html += "<div class='searchImgRow col-md-12'>" +
						  	"검색하신 상품이 존재하지 않습니다.</div>";
				}
				else {
					$.each(json, function(index, item) {
						if((index+1)%6!=0) {
							html += "<div class='searchImgRow col-xs-2'>" +
									"<img class='searchFrontImg' src='images_Product/"+item.pimage1+"' />" +
									"<a class='searchHover' href='productDetail.ysl?pnum="+item.pnum+"'><div class='searchHoverImg'>"+
									"<span style='font-size:8pt;'><br/><br/>"+item.pname+"</span><span style='font-size:8pt;'><br/><br/>￦&nbsp;"+numberWithCommas(item.price)+"</span>" +
									"</div></a>" +
 									"</div>";
						}
						else {
							html += "<div class='searchImgRow col-xs-2'>" +
									"<img class='searchFrontImg' src='images_Product/"+item.pimage1+"' />" +
									"<a class='searchHover' href='productDetail.ysl?pnum="+item.pnum+"'><div class='searchHoverImg'>"+
									"<span style='font-size:8pt;'><br/><br/>"+item.pname+"</span><span style='font-size:8pt;'><br/><br/>￦&nbsp;"+numberWithCommas(item.price)+"</span>" +
									"</div></a>" +
 									"</div><br/>";				
						}
					});
					
			
				}
				
				$(".productListbySearch").append(html);
				
				// hover
				$(".searchHoverImg").hide();
				$(".searchImgRow").hover(function () {
		
					$(this).find(".searchFrontImg").css('display','none');
					$(this).find(".searchHoverImg").css('display','');
					
					}, function () {
					
					$(this).find(".searchFrontImg").css('display','');
					$(this).find(".searchHoverImg").css('display','none');
				
				});
				
				// >>> (중요!!!) 더보기... 버튼의 value 속성에 값을 지정하기 <<< 
				$("#btnMore").val(parseInt(start)+12);
				
				if(json.length%6!=0) {
					$("#btnMore").hide();
					$("#btnMore").val(json.length);
				}
				
			},
					
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
				
		});
		
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}


</script>

<body>
	<div class="searchProdContainer">
		<div class="prodFilter" style="margin-top: 50px;">
			<div style="display: inline;"><span style="font-size: 9pt;">+Filter</span></div>
			<div class="prodFilter" style="width: 90px; height: 35px; margin-left: 13px; display: inline;">
			  <span style="font-size: 8pt;">성별</span>
			  <select class="prodSelect prodCatFilter" id="prodCatFilter" name="prodCatFilter">
			  	<option value="">모두보기</option>
			    <option value="여성">여성</option> 
			    <option value="남성">남성</option>
			  </select>
			</div>
			<div class="prodFilter" style="width: 150px; height: 100px; margin-left: 13px; display: inline;">
			  <span style="font-size: 8pt;">카테고리</span>
			  <select class="prodSelect prodDetailCatFilter" id="prodDetailCatFilter" name="prodDetailCatFilter">
			  	<option class='optionStyle' value="">모두보기</option>
			  </select>
			</div>
			<div class="prodFilter" style="width: 90px; height: 100px; margin-left: 13px; display: inline;">
			  <span style="font-size: 8pt;">컬러</span>
			  <select class="prodSelect prodColorFilter" id="prodColorFilter" name="prodColorFilter">
			  	<option value="">모두보기</option>
			    <option value="BLACK">BLACK</option>
			    <option value="WHITE">WHITE</option>
			    <option value="GOLD">GOLD</option>
			    <option value="PINK">PINK</option>
			    <option value="BLUE">BLUE</option>
			    <option value="GREEN">GREEN</option>
			    <option value="RED">RED</option>
			    <option value="BROWN">BROWN</option>
			  </select>
			</div>
		</div>
		<div class="productListbySearch">
		</div>
		<div style="text-align: center;">
			<br/>
			<button type="button" id="btnMore" value="" class="theload" >더 로드하기..</button>
			<br/><br/><br/>
		</div>
	</div>
</body>
</html>