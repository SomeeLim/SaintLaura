package ysl.payment.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import ysl.common.controller.AbstractController;
import ysl.member.model.MemberVO;
import ysl.payment.model.InterPaymentDAO;
import ysl.payment.model.PaymentDAO;

public class OrderDetail extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	InterPaymentDAO pdao = new PaymentDAO();
    	
    	HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String idx = request.getParameter("idx");
		boolean isLogin = super.checkLogin(request);
  
	    if(!isLogin) { // 로그인을 하지 않은 상태라면		      
		         
		    request.setAttribute("message", "주문반품목록은 로그인해야 확인할 수 있습니다.");
		    request.setAttribute("loc", "javascript:history.back()");
		         
		    super.setViewPage(request.getContextPath() + "/main.ysl");
		            
		    return;
	    }
	         
	    else {
	    	
	    	if(idx == null)
				idx = "";
			
			if(!idx.equals(String.valueOf(loginuser.getIdx()))) {
				// 로그인을 했지만 타인의 주문페이지를 확인하려는 경우
				
				String message = "본인 계정의 주문페이지만 확인 가능합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
				
			}
			else {
	    	
		    	String orderNo = request.getParameter("orderNo_fk");
		    	// 내 주문번호 가져오기
		    	List<String> orderNoList =  pdao.getMyOrderNo(idx);
		    		    	
		    	// 로그인하고 본인의 idx지만 타인의 주문번호를 확인하려는 경우
		    	if(idx.equals(String.valueOf(loginuser.getIdx())) && orderNoList==null) {	    	
		    		// (1) 주문리스트가 존재하지 않을 경우
					String message = "본인 계정의 주문페이지만 확인 가능합니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					
					return;
	
		    	}	    	
		    	else if(idx.equals(String.valueOf(loginuser.getIdx())) && orderNoList != null) {		    		
			    	for(String myOrderNo : orderNoList) {
			    		if( !(myOrderNo.equalsIgnoreCase(orderNo))) {
			    			// (2) 주문리스트가 존재할 경우
			    			String message = "본인 계정의 주문페이지만 확인 가능합니다.";
			    			String loc = "javascript:history.back()";

							request.setAttribute("message", message);
							request.setAttribute("loc", loc);
							
							super.setViewPage("/WEB-INF/msg.jsp");
			    		}
			    		else if(myOrderNo.equalsIgnoreCase(orderNo)) {
					    	// (3) 본인의 주문인 경우 orderNo를 가지고 Order Table과 Product Table
			    			List<HashMap<String, String>> orderList = pdao.getOrderDetail(orderNo);
	
			    			request.setAttribute("orderList", orderList);					    	
					    	super.setViewPage("/WEB-INF/payment/orderDetail.jsp");  
					    	
					    	return;
			    		}			    		
			    		
			    	}			    	
	    	
		    	}
		    	

			}
	        	 
	   }

	}

}
