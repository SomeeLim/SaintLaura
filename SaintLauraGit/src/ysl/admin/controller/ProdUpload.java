package ysl.admin.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ysl.common.controller.AbstractController;
import ysl.member.model.MemberVO;
import ysl.product.model.InterProductDAO;
import ysl.product.model.ProductDAO;
import ysl.product.model.ProductVO;

public class ProdUpload extends AbstractController {
	
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
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			
			super.setViewPage("/WEB-INF/adminYSL.jsp"); 
			
		}
		
		else {
			
			// MultipartRequest는 request의 기능 + 업로드, 다운로드 기능까지 한다.
			MultipartRequest mtrequest = null;
			
			// 1. 첨부되어진 파일이 어느 경로에 업로드 지 경로 설정
			session = request.getSession();
			
			ServletContext svlCtx = session.getServletContext();
			String imagesDir = svlCtx.getRealPath("/images_Product");
			
			System.out.println("image file이 올라가는 절대 경로 : " + imagesDir);
			
			/*	MultipartRequest의 객체가 생성됨과 동시에 파일 업로드가 이루어 진다.
			 * 	MultipartRequest(HttpServletRequest request,
			 * 					 String saveDirectory, -- 파일이 저장될 경로
			 * 					 int maxPostSize, -- 업로드할 파일 1개의 최대 크기(Byte),
			 * 					 String encoding,
			 * 					 FileRenamePolicy policy) -- 중복된 파일명 처리
			 */
			
			try {
			
				mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			
			} catch (IOException e) {
				request.setAttribute("message", "경로를 찾지 못하였거나 용량부족으로 업로드가 실패하였습니다.");
				request.setAttribute("loc", request.getContextPath()+"/adminYSL.jsp");
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			// 제품 정보 DB테이블 삽입
			InterProductDAO pdao = new ProductDAO();
			
			// form태그에서 입력한 값들 얻어오기
			String pcategory_fk = mtrequest.getParameter("pcategory_fk");
			String pname = mtrequest.getParameter("pname");
			String price = mtrequest.getParameter("price");
			String pcontent = mtrequest.getParameter("pcontent");
			
			pcontent = this.replaceParameter(pcontent);
			pcontent = pcontent.replaceAll("\r\n", "<br/>");
			
			String pcolor = mtrequest.getParameter("pcolor");
			String psize = mtrequest.getParameter("psize");
			String pmaterial = mtrequest.getParameter("pmaterial");
			String pqty = mtrequest.getParameter("pqty");
			
			String pimage1 = mtrequest.getFilesystemName("pimage1");
			String pimage2 = mtrequest.getFilesystemName("pimage2");
			String pimage3 = mtrequest.getFilesystemName("pimage3");
			String pimage4 = mtrequest.getFilesystemName("pimage4");
			
			int pnum = pdao.getPnumOfProduct();
			 
			ProductVO pvo = new ProductVO(pnum, pname, pcategory_fk, pimage1, pimage2, pimage3, pimage4, Integer.parseInt(pqty), Integer.parseInt(price), pcontent, pcolor, psize, pmaterial, "YSL");

			int n = pdao.uploadProduct(pvo);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "제품등록이 완료되었습니다.";
				loc = "javascript:history.back()";
			}
			else {
				message = "제품등록이 실패하였습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
				
	}

}
