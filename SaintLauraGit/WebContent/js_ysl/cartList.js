
	
	$(document).ready(function(){
		
		/* 고객서비스 */
		$("#customer-service").css("display", "none");
		$("#customer-service-detail").on("click", function(){
			
			var status = $("#customer-service").css("display");
			if(status == "none"){
				$("#customer-service").slideDown(300);
				$("#delivery-service").slideUp(300);
				$("#payment-service").slideUp(300);
				$("#return-service").slideUp(300);
				$("#customer-service-detail").html("고객서비스 -");
				$("#delivery-service-detail").html("배송 방법 +");
				$("#payment-service-detail").html("결제 방법 +");
				$("#return-service-detail").html("반품 정책 +");
			}
			else {
				$("#customer-service").slideUp(300);
				$("#customer-service-detail").html("고객서비스 +");
			}
		});
		
		
		/* 배송방법 */
		$("#delivery-service").css("display", "none");
		$("#delivery-service-detail").on("click", function(){
			
			var status = $("#delivery-service").css("display");
			if(status == "none"){
				$("#delivery-service").slideDown(300);
				$("#customer-service").slideUp(300);
				$("#payment-service").slideUp(300);
				$("#return-service").slideUp(300);
				$("#delivery-service-detail").html("배송 방법 -");
				$("#customer-service-detail").html("고객서비스 +");
				$("#payment-service-detail").html("결제 방법 +");
				$("#return-service-detail").html("반품 정책 +");
			}
			else {
				$("#delivery-service").slideUp(300);
				$("#delivery-service-detail").html("배송 방법 +");
			}
		});
		
		/* 결제방법 */
		
		$("#payment-service").css("display", "none");
		$("#payment-service-detail").on("click", function(){
			
			var status = $("#payment-service").css("display");
			if(status == "none"){
				$("#payment-service").slideDown(300);
				$("#customer-service").slideUp(300);
				$("#delivery-service").slideUp(300);
				$("#return-service").slideUp(300);
				$("#payment-service-detail").html("결제 방법 -");
				$("#delivery-service-detail").html("배송 방법 +");
				$("#customer-service-detail").html("고객서비스 +");
				$("#return-service-detail").html("반품 정책 +");
			}
			else {
				$("#payment-service").slideUp(300);
				$("#payment-service-detail").html("결제 방법 +");
			}
		});
		
		
		/* 반품정책 */
		
		$("#return-service").css("display", "none");
		$("#return-service-detail").on("click", function(){
			
			var status = $("#return-service").css("display");
			if(status == "none"){
				$("#return-service").slideDown(300);
				$("#customer-service").slideUp(300);
				$("#delivery-service").slideUp(300);
				$("#payment-service").slideUp(300);
				$("#return-service-detail").html("반품 정책 -");
				$("#payment-service-detail").html("결제 방법 +");
				$("#delivery-service-detail").html("배송 방법 +");
				$("#customer-service-detail").html("고객서비스 +");
			}
			else {
				$("#return-service").slideUp(300);
				$("#return-service-detail").html("반품 정책 +");
			}
			
		});
		
	});
	
