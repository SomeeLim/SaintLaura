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

public class OrderNReturnList extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		String method = request.getMethod(); 
		String idx =  request.getParameter("idx");
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
	        	 
	        	// 주문목록 불러오기
	        	List<HashMap<String, String>> payList = pdao.getOrderList(idx);
	        	
	        	// 반품목록 불러오기
	        	 	        	 
	        	JSONArray jsonArr = new JSONArray();
	     		
	     		if(payList != null) {
	     			
	     			for(HashMap<String, String> payMap : payList) {
	     				JSONObject jsobj = new JSONObject();
	     				// JSONObject는 JSON형태{키:값}의 데이터로 만들어주는 것이다.
	     				 jsobj.put("orderNo_fk", payMap.get("orderNo_fk"));
	     				 jsobj.put("orderDate", payMap.get("orderDate"));
	     				 jsobj.put("orderStatus", payMap.get("orderStatus"));
			        	 jsobj.put("pname", payMap.get("pname"));
			        	 jsobj.put("pimage1", payMap.get("pimage1"));
			        	 jsobj.put("price", payMap.get("price"));
			        	 jsobj.put("prodGender", payMap.get("prodGender"));
			        	 jsobj.put("prodCategory", payMap.get("prodCategory"));
	     				
	     				jsonArr.put(jsobj);
	     			} // end of for-------
	     			
	     		}
	     		
	     		result = jsonArr.toString();
	     		
	     		request.setAttribute("result", result);

	        	super.setViewPage("/WEB-INF/jsonResult.jsp");
	        	 
	         }
			
	      }
	
	}

}
