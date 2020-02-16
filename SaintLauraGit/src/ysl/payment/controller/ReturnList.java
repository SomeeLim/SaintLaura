package ysl.payment.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import ysl.common.controller.AbstractController;
import ysl.payment.model.InterPaymentDAO;
import ysl.payment.model.PaymentDAO;

public class ReturnList extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); 
		String orderNo =  request.getParameter("orderNo_fk");
		String result = ""; 
		
		if(!"POST".equalsIgnoreCase(method)) {
	         // GET 방식이라면
	         
	         super.setViewPage("/WEB-INF/payment/orderNReturnList.jsp");
	      }
	      
	      else {
	         // POST 방식이라면
	         
	         // == 로그인 유무 검사하기 == //
	         boolean isLogin = super.checkLogin(request);
	         
	         if(!isLogin) { // 로그인을 하지 않은 상태라면		      
		         
		         request.setAttribute("message", "주문반품목록은 로그인해야 확인할 수 있습니다.");
		         request.setAttribute("loc", "javascript:history.back()");
		         
		         super.setViewPage("/WEB-INF/msg.jsp");
		            
		         return;
	         }
	         
	         else {
	        	 
	        	InterPaymentDAO pdao = new PaymentDAO();
	        	 
	        	// 반품번호 불러오기
	        	String orderDetailNo_fk  = pdao.getReturnList(orderNo);	       

	     		JSONObject jsobj = new JSONObject();
	     		jsobj.put("orderDetailNo_fk", orderDetailNo_fk);

	     		result = jsobj.toString();
	     		
	     		request.setAttribute("result", result);

	        	super.setViewPage("/WEB-INF/jsonResult.jsp");
	        	 
	         }
			
	      }

	}

}
