package ysl.common.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(
		description = "사용자가 웹에서 *.ysl을 했을 경우 이 Servlet이 먼저 응답을 해주도록 한다.", 
		urlPatterns = { "*.ysl" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "/Users/imsomi/eclipse-workspace/JAVASCRIPT/SaintLaura/WebContent/WEB-INF/Command.properties", description = "*.ysl에 대한 클래스의 매핑파일")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	HashMap<String, Object> cmdMap = new HashMap<String, Object>();	

	public void init(ServletConfig config) throws ServletException {
		
		System.out.println("~~~~ 확인용 => 서블릿 FrontController의 init(ServletConfig config) 메소드가 실행됨.");
		
		Properties pr = new Properties();
  	
		FileInputStream fis = null; 
		
		try {
			String props = config.getInitParameter("propertyConfig");
			System.out.println("~~~~ 확인용 props => " +props);
			
			fis = new FileInputStream(props);
			
			pr.load(fis);

			Enumeration<Object> en = pr.keys();
			
			
			while(en.hasMoreElements()) {
				String key_url = (String)en.nextElement();				
				String className = pr.getProperty(key_url);
				
				if(className!=null) {
					className = className.trim();
					
					Class<?> cls = Class.forName(className); 
					Object obj = cls.newInstance();			
					
					cmdMap.put(key_url, obj);
					
				}
				
			} // end of while -------
		
		} catch (ClassNotFoundException e) {
			System.out.println(">>> 문자열로 명명되어진 클래스가 존재하지 않습니다.");
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			System.out.println(">>> 파일이 존재하지 않습니다.");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	} // end of public void init(ServletConfig config)--------------


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		requestProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request, response);
	}
	
	protected void requestProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uri = request.getRequestURI();
		
		String ctxPath = request.getContextPath();
		
		String mapKey = uri.substring(ctxPath.length());
		
		AbstractController action =(AbstractController)cmdMap.get(mapKey);
		if(action==null) {
			System.out.println(">>> " + mapKey + " URL 패턴에 매핑된 클래스는 없습니다. <<<"); 
		}
		else {
			
			try {
				action.execute(request, response); 
				
				boolean bool = action.isRedirect();
				String viewPage = action.getViewPage();
				if(!bool) { // false 라면 forward
					// viewPage에 명기된 view단 페이지로 forward(dispatcher)를 하겠다는 말이다.
					RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
					dispatcher.forward(request, response);
				}
				else {
					// viewPage에 명기된 주소로 sendRedirect를 하겠다는 말이다.
					response.sendRedirect(viewPage);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} // end of else;

	}


}
