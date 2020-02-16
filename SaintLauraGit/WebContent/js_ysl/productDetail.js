
$(document).ready(function () {
	
	$("div.zoom").hide();
	$("#loveImage2").hide();
	
	$("img.myimage").click(function () {
		$("body#main").css("overflow","hidden");
		$("header").hide();
		$("div.zoom").show();
		$("div.container-detail").hide();
	});
	
	$("div.zoom").click(function () {
		$("body#main").css("overflow","auto");
		$("header").show();
		$("div.container-detail").show();
		$("div.zoom").hide();
	});
	
	
	$("div#detail-product-info").hide();

	$("a#detail").on("click", function() {
		$("div#detail-product-info").slideDown(300);
		$("a#detail").hide();
	});
	
	$("a#close").on("click", function() {
		$("div#detail-product-info").slideUp(300);
		$("a#detail").show();
	});
	
	var modal = document.getElementById("myModal");

	// Get the button that opens the modal
	var btn = document.getElementById("myBtn");

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	
	var nav = document.getElementById("right-nav");
	
	// When the user clicks the button, open the modal 
	btn.onclick = function() {
	  modal.style.display = "block";
	  nav.style.display = "none";
	}

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	  nav.style.display = "block";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	    nav.style.display = "block";
	  }
	}
	
	
	$("#wishBtn").hover(function(e){ 
		   $(this).find(">img").attr("src", function(index, attr){ 
		      if(attr.match('productDetail-wish-btn')) return attr.replace("productDetail-wish-btn.png", "productDetail-wish2-btn.png"); 
		   }); 
		}, function() {
		   $(this).find(">img").attr("src", function(index, attr){ 
		      if(attr.match('productDetail-wish2-btn')) return attr.replace("productDetail-wish2-btn.png", "productDetail-wish-btn.png"); 
		   }); 
		});
	
	$("#callBtn").hover(function(e){ 
		   $(this).find(">img").attr("src", function(index, attr){ 
		      if(attr.match('productDetail-call-btn')) return attr.replace("productDetail-call-btn.png", "productDetail-call2-btn.png"); 
		   }); 
		}, function() {
		   $(this).find(">img").attr("src", function(index, attr){ 
		      if(attr.match('productDetail-call2-btn')) return attr.replace("productDetail-call2-btn.png", "productDetail-call-btn.png"); 
		   }); 
		});
	
	$("#chatBtn").hover(function(e){ 
		   $(this).find(">img").attr("src", function(index, attr){ 
		      if(attr.match('productDetail-chat-btn')) return attr.replace("productDetail-chat-btn.png", "productDetail-chat2-btn.png"); 
		   }); 
		}, function() {
		   $(this).find(">img").attr("src", function(index, attr){ 
		      if(attr.match('productDetail-chat2-btn')) return attr.replace("productDetail-chat2-btn.png", "productDetail-chat-btn.png"); 
		   }); 
		});
	
	$("#loveImage1").click(function(){
		$("#loveImage1").hide();
		$("#loveImage2").show();
	});
	
	$("#loveImage2").click(function(){
		alert("이 제품은 이미 위시리스트에 저장되었습니다.");
	}); 
});
	

function wishListAdd(pnum) { // 하트(wish)를 클릭한경우
	   
	   var frm = document.wishFrm;
	   frm.method = "POST";
	   frm.action = "/SaintLaura/mywishListAdd.ysl";
	   frm.submit();
	   
	}
	