function goEdit() {
		
		$(".beforeEdit").css({'display':'none'})
		$(".afterEdit").css({'display':'flex'})
		
		$("#afterEditName").val($("#beforeEditName").text());
		$("#afterEditPost").val($("#beforeEditPost").text());
		$("#afterEditAddr1").val($("#beforeEditAddr1").text());
		$("#afterEditAddr2").val($("#beforeEditAddr2").text());
		$("#afterEditHp").val($("#beforeEditHp").text());
		
	}
	
	function finishEdit() {
		
		$(".beforeEdit").css({'display':'flex'})
		$(".afterEdit").css({'display':'none'})
		
		$("#beforeEditName").val($("#afterEditName").text());
		$("#beforeEditPost").val($("#afterEditPost").text());
		$("#beforeEditAddr1").val($("#afterEditAddr1").text());
		$("#beforeEditAddr2").val($("#afterEditAddr2").text());
		$("#beforeEditHp").val($("#afterEditHp").text());
		
	}