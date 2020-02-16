package ysl.admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import ysl.admin.model.AdminDAO;
import ysl.admin.model.InterAdminDAO;
import ysl.common.controller.AbstractController;
import ysl.member.model.MemberVO;

public class CustomerList extends AbstractController {  

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
		

			////// #### Customer List && Search #### //////
			String searchType = request.getParameter("searchCustomerType");
			String searchWord = request.getParameter("searchCustomerWord");
			String memberType = request.getParameter("memberType");
			
			System.out.println(searchType);
			System.out.println(searchWord);
			System.out.println(memberType);
			
			String currentShowPageNo = request.getParameter("currentShowPageNo"); // 현재 페이지 번호
			String sizePerPage = "10"; // 한 페이지에 보여지는 행의 갯수
			
			
			if(!("email".equalsIgnoreCase(searchType) || 
			     "name".equalsIgnoreCase(searchType) ||
			     "hp".equalsIgnoreCase(searchType))) {
				
				searchType = "";
				searchWord = "";
				
			}
			
			if(!("2".equalsIgnoreCase(memberType) || 
				 "1".equalsIgnoreCase(memberType) ||
				 "0".equalsIgnoreCase(memberType))) {
				memberType = "2";
			}
			
			InterAdminDAO adao = new AdminDAO();		
			List<HashMap<String, String>> customerList = null;
			
			// sql문을 위해 변수 Map에 담기 
			HashMap<String, String> customerMap = new HashMap<String, String>();
			
			if(searchType != null) {
				customerMap.put("searchType", searchType);
			}		
			if(searchWord != null) {
				customerMap.put("searchWord", searchWord);
			}
			if(memberType != null) {
				customerMap.put("memberType", memberType);
			}
			
			customerMap.put("currentShowPageNo", currentShowPageNo);
			customerMap.put("sizePerPage", sizePerPage);
			
			// 검색조건에 따른 회원목록 페이징하여 보여주기
			customerList = adao.getAdminCustomerList(customerMap);

			JSONObject jsobj = new JSONObject();
			
			JSONArray listArray = new JSONArray();
			
			
			if(customerList!=null) {
				for(HashMap<String, String> listMap :customerList) {
					JSONObject listObj = new JSONObject();
					listObj.put("idx", listMap.get("idx"));
					listObj.put("email", listMap.get("email"));
					listObj.put("name", listMap.get("name"));
					listObj.put("hp1", listMap.get("hp1"));
					listObj.put("hp2", listMap.get("hp2"));
					listObj.put("hp3", listMap.get("hp3"));
					listObj.put("status", listMap.get("status"));
					listArray.put(listObj);
				}
			}
			
			jsobj.put("listArray", listArray);
			
			
			////// #### Pagination #### //////
			
			int totalPage = adao.getTotalPage(customerMap);		
			int pageNo =1; // 페이지바에서 보여지는 페이지 번호이다.
			int blockSize = 10; // 블럭당 보여지는 페이지 번호의 갯수이다.
			int loop = 1; // 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 갯수(지금은 10개)까지만 증가하는 용도
			pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize +1; 
			// 처음 페이지번호를 구하는 공식
			
			JSONArray pageArray = new JSONArray();
			
			JSONObject pageObj = new JSONObject();
			pageObj.put("totalPage", totalPage);
			pageObj.put("pageNo", pageNo);
			pageObj.put("blockSize", blockSize);
			pageObj.put("loop", loop);
			pageObj.put("currentShowPageNo", currentShowPageNo);
			
			pageArray.put(pageObj);
			
			jsobj.put("pageArray", pageArray);
			
			String result = jsobj.toString();
			
			request.setAttribute("result", result);
			
			super.setViewPage("/WEB-INF/jsonResult.jsp");	

	}


}
