package ysl.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import ysl.admin.model.AdminDAO;
import ysl.admin.model.InterAdminDAO;
import ysl.common.controller.AbstractController;
import ysl.member.model.MemberVO;

public class ChangeMemberStatus extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 관리자(admin)로 로그인 했을때만 조회가 가능하도록 한다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null) {
			
			String message = "먼저 로그인 해야 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		else {
			
			String idx = String.valueOf(loginuser.getIdx());
			
			if(!"2".equalsIgnoreCase(idx)) {
				
				String message = "관리자만 접근이 가능합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;				
			}
			
					
		}		
		
		String status = request.getParameter("status");
		String idx = request.getParameter("idx");
		
		InterAdminDAO adao = new AdminDAO();
		
		int n = adao.updateMemberStatus(status, idx);
		
		JSONObject jsobj = new JSONObject();
		
		jsobj.put("n", String.valueOf(n));
		
		String result = jsobj.toString();
		
		request.setAttribute("result", result);
		
		super.setViewPage("/WEB-INF/jsonResult.jsp");

	}

}
