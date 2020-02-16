
	$(document).ready(function () {
		
		$(".customerEmail_error").hide();
		
		$("select[name=csEmailCat2]").attr("disabled", true);
		
		$("select[name=csEmailCat1]").bind("change", function() {
			
			$("select[name=csEmailCat2]").attr("disabled", false);
		 	
			var cat1 = $(this).val();
			var html = "";
			
			if(cat1=="1") {
				$("select[name=csEmailCat2]").attr("disabled", true);
				$("select[name=csEmailCat1]").parent().find(".customerEmail_error").show();
			}
			
			if(cat1=="상품정보") {
				
				$("select[name=csEmailCat1]").parent().find(".customerEmail_error").hide();
				
				html += "<option class='optionStyle' value='재고여부'>재고여부</option>";
				html += "<option class='optionStyle' value='가격'>가격</option>";
				html += "<option class='optionStyle' value='사이즈'>사이즈</option>";
				html += "<option class='optionStyle' value='특징'>특징</option>";
				
				$("#csEmailCat2").html(html);
				
			} 
			
			if(cat1=="구매") {
				
				$("select[name=csEmailCat1]").parent().find(".customerEmail_error").hide();
				
				html += "<option class='optionStyle' value='주문현황'>주문현황</option>";
				html += "<option class='optionStyle' value='배송'>배송</option>";
				html += "<option class='optionStyle' value='취소요청'>취소요청</option>";
				html += "<option class='optionStyle' value='결제관련'>결제관련</option>";
				html += "<option class='optionStyle' value='인보이스요청'>인보이스요청</option>";
				
				$("#csEmailCat2").html(html);
				
			} 
			
			if(cat1=="환불&교환") {
				
				$("select[name=csEmailCat1]").parent().find(".customerEmail_error").hide();
				
				html += "<option class='optionStyle' value='환불절차'>환불절차</option>";
				html += "<option class='optionStyle' value='수령'>수령</option>";
				html += "<option class='optionStyle' value='교환요청'>교환요청</option>";
				html += "<option class='optionStyle' value='환불요청'>환불요청</option>";
				html += "<option class='optionStyle' value='환불정책'>환불정책</option>";
				
				$("#csEmailCat2").html(html);
				
			} 
			
			if(cat1=="고객경험") {
				
				$("select[name=csEmailCat1]").parent().find(".customerEmail_error").hide();
				
				html += "<option class='optionStyle' value='상품'>상품</option>";
				html += "<option class='optionStyle' value='가격'>가격</option>";
				html += "<option class='optionStyle' value='온라인경험'>온라인경험</option>";
				html += "<option class='optionStyle' value='불편사항'>불편사항</option>";

				$("#csEmailCat2").html(html);
				
			} 
			
		});
			
		
		
	});

	function sendCustomerEmail(event) {
		
		event.preventDefault();
		
		var name = $("#csEmailName").val().trim();
		
		if(name == "") {
			$("#csEmailName").parent().find(".customerEmail_error").show();
			$("#csEmailName").focus();
			return;
		}
		else {
			$("#csEmailName").parent().find(".customerEmail_error").hide();
		}
		
		var email = $("#csEmailEmail").val().trim();
		
		if(email == "") {
			$("#csEmailEmail").parent().find(".customerEmail_error").show();
			$("#csEmailEmail").focus();
			return;
		}
		else {
			$("#csEmailEmail").parent().find(".customerEmail_error").hide();
		}
		
		var hp = $("#csEmailHp").val().trim();
		
		if(hp == "") {
			$("#csEmailHp").parent().find(".customerEmail_error").show();
			$("#csEmailHp").focus();
			return;
		}
		else {
			$("#csEmailHp").parent().find(".customerEmail_error").hide();
		}
		
		var cat1 = $("select[name=csEmailCat1]").val();
		
		if(cat1 == "1") {
			$("select[name=csEmailCat1]").parent().find(".customerEmail_error").show();
		}
		
		var msg = $("#csEmailMsg").val().trim();
		
		if(msg=="") {
			$("#csEmailMsg").parent().find(".customerEmail_error").show();
			$("#csEmailMsg").focus();
			return;
		}
		
		var frm = document.customerServiceEmailFrm;
		frm.method = "POST";
		frm.action = "customerEmailService.ysl";
		frm.submit();
		
		
	}