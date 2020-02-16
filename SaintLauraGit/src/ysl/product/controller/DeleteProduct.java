package ysl.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ysl.common.controller.AbstractController;
import ysl.member.model.MemberVO;
import ysl.product.model.InterProductDAO;
import ysl.product.model.ProductDAO;

public class DeleteProduct extends AbstractController {

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
			
			String pnum = request.getParameter("pnum");
					
			InterProductDAO pdao = new ProductDAO();
			
			// 1. 해당 상품 테이블에서 삭제
			int n = pdao.deleteProdfromTab(pnum);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "상품이 삭제되었습니다.";
				loc = "javascript:history.back()";
			}
			else {
				message = "상품삭제가 실패하였습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");				
		}

	}

}
