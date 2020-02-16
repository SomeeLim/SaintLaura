package ysl.main.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ysl.common.controller.AbstractController;

public class CustomerEmailService extends AbstractController {
	
	private String replaceParameter(String param) {
		
		String result = param;
		
		if(param!=null) {
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("\"", "&quot;");
		}
		
		return result;
		
	} // end of private String replaceParameter(String param) ---------

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String csEmailName = request.getParameter("csEmailName");
			String csEmailEmail = request.getParameter("csEmailEmail");
			String csEmailHp = request.getParameter("csEmailHp");
			String csEmailCat1 = request.getParameter("csEmailCat1");
			String csEmailCat2 = request.getParameter("csEmailCat2");
			String csEmailOrderNo = request.getParameter("csEmailOrderNo");
			String csEmailProdNo = request.getParameter("csEmailProdNo");
			String csEmailMsg = request.getParameter("csEmailMsg");
			
			csEmailMsg = this.replaceParameter(csEmailMsg);
			csEmailMsg = csEmailMsg.replaceAll("\r\n", "<br/>");
			
			HashMap<String, String> paraMap = new HashMap<String, String>();
			
			paraMap.put("csEmailName", csEmailName);
			paraMap.put("csEmailEmail", csEmailEmail);
			paraMap.put("csEmailHp", csEmailHp);
			paraMap.put("csEmailCat1", csEmailCat1);
			paraMap.put("csEmailCat2", csEmailCat2);
			paraMap.put("csEmailOrderNo", csEmailOrderNo);
			paraMap.put("csEmailProdNo", csEmailProdNo);
			paraMap.put("csEmailMsg", csEmailMsg);
			
			GoogleMailforCustomerEmail mail = new GoogleMailforCustomerEmail();
			
			try {
				mail.sendmail(paraMap);								
				
			}
			catch (Exception e) {
				e.printStackTrace(); 
			}
			
		}
		
		super.setViewPage("/WEB-INF/main/customerEmailService.jsp"); 
		
	}

}
