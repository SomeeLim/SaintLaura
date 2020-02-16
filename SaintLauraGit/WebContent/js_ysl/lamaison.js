/**
 * 
 */

	$(document).ready(function(){
	  
	  $(window).scroll(function() {
	    $(".slideanim").each(function(){
	      var pos = $(this).offset().top;
	
	      var winTop = $(window).scrollTop();
	        if (pos < winTop + 600) {
	          $(this).addClass("slide");
	        }
	    });
	  });
	  
	  var video = document.getElementById("video"),
	  fraction = 0.9;
	  function checkScroll() {		 
	
	      var x = video.offsetLeft, y = video.offsetTop, w = video.offsetWidth, h = video.offsetHeight, r = x + w, //right
	          b = y + h, //bottom
	          visibleX, visibleY, visible;
	
	          visibleX = Math.max(0, Math.min(w, window.pageXOffset + window.innerWidth - x, r - window.pageXOffset));
	          visibleY = Math.max(0, Math.min(h, window.pageYOffset + window.innerHeight - y, b - window.pageYOffset));
	
	          visible = visibleX * visibleY / (w * h);
	
	          if (visible > fraction) {
	              video.play();
	          } else {
	              video.pause();
	          } 
	
	  }
	
	  window.addEventListener('scroll', checkScroll, false);
	  window.addEventListener('resize', checkScroll, false);
	  
	}) // end of $(document).ready(function()-------------