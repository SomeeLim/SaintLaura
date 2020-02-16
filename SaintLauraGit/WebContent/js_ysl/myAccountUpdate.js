$(document).ready(function(){

	$("#birthmonth").click(function() {
		var mmhtml = "";
		for(var i=1; i<=12; i++)
			if(i<10) {
				mmhtml += "<option value = '0"+i+"'>0"+i+"</option>"
			}
			else {
				mmhtml += "<option value = '"+i+"'>"+i+"</option>"
			}
		$("#birthmonth").html(mmhtml);
	});
		
		var ddhtml = "";
		for(var i=1; i<=31; i++){
			if(i<10) {
				ddhtml += "<option value = '0"+i+"'>0"+i+"</option>"
			}
			else {
				ddhtml += "<option value = '"+i+"'>"+i+"</option>"
			}
		$("#birthday").html(ddhtml);
		}
});