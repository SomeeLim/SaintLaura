

		
		$(document).ready(function () {
			$(".hoverImage").css('display','none');
			
			$(".item").hover(function () {
				
				$(this).find(".mainImage").css('display','none');
				$(this).find(".hoverImage").css('display','');
				
				}, function () {
				
				$(this).find(".mainImage").css('display','');
				$(this).find(".hoverImage").css('display','none');
	
			});
			
		});