

function getOrderList(idx) {
	
	$.ajax({
		
		url:"/SaintLaura/accountOrderList.ysl",
		method:"POST",
		data:{"idx":idx},
		dataType:"JSON",
		success:function(json) {
			
			var html = "";
			
			if(json.length == 0) {
				
				html += "<tr class='orderTr'>" +
						"<td>주문하신 상품이 존재하지 않습니다</td></tr>"
				   
				
				$(".accountOrderTable").html(html);
				
			}
			else {
				
				
				$.each(json, function(index,item) {
					
					if(index<2) {
						html += "<tr class='orderTr'><a href='/SaintLaura/orderDetail.ysl?idx="+item.idx+"&orderNo_fk="+item.orderNo_fk+"' style='text-decoration: none; color:black;'>" +
								"<td style='width: 30%;'>" +
								"<img src='images_Product/"+item.pimage1+"' class='orderImg' />" +
								"</td>" +
								"<td style='width: 70%;'>" +
								"<div class='orderList info orderContents'>주문번호 : <span>"+item.orderNo_fk+"</span></div>" +
								"<div class='orderList info orderContents'>주문제품 : <span>"+item.pname+"</span></div>" +
								"</td></a></tr>";	
					}
				});
				
			}
	
			$(".accountOrderTable").html(html);
			
		},
		
		error: function(request, status, error){
			alert("code : " + request.status + "\n" + "message : " +request.responseText + "\n" +"error : " + error);
		} 
		
	});	
	
	
}