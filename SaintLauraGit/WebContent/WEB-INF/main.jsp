<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="mainheader.jsp" />

	<%--      contents  시작            --%>
	<div>
		<div>
			<img id="img-background" alt="background-color" src="images/main-color.png">
		</div>
		<%-- Main Model Image --%>
		<a href="<%= ctxPath %>/collection.ysl"><img id="img-model" alt="model" src="images/main-model-narrow.png"></a>
		
		<%-- Center Texts --%>
		<section>
		
			<a href="<%= ctxPath %>/collection.ysl">
				<div style="text-align:center; cursor:pointer;">
					<h6 id="section-h">FALL WINTER 19</h6>
					<p id="section-p">컬렉션을 구매하세요</p>
				</div>
			</a>
		
		</section>
	</div>
	<%--      contents  끝            --%>

<jsp:include page="footer.jsp" />	