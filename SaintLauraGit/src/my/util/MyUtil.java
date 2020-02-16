package my.util;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

	public class MyUtil {
	
	
	// *** ? 다음의 데이터까지 포함한 URL 주소를 알아오는 메소드 ***
	
	public static String getCurrentURL(HttpServletRequest request) {

		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/shop/prodView.up => 물음표 전 까지 알아온다.
		
		String queryString = request.getQueryString();
		// pnum=3 => 물음표 다음부터 끝까지
		
		currentURL += "?" + queryString;
		// http://localhost:9090/MyMVC/shop/prodView.up?pnum=3 완성~
		
		String ctxPath = request.getContextPath();
		// /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length(); 
		// /MyMVC 이 글자가 시작되는 위치값 : 21 + 6
		currentURL = currentURL.substring(beginIndex+1);
		
		return currentURL;
	}
	
    public static String numberGen(int len) {
        
        Random rand = new Random();
        String numStr = ""; //난수가 저장될 변수
        
        for(int i=0;i<len;i++) {
            
            //0~9 까지 난수 생성
            String ran = Integer.toString(rand.nextInt(10));
            //중복을 허용하지 않을시 중복된 값이 있는지 검사한다
            
            if(!numStr.contains(ran)) {
                //중복된 값이 없으면 numStr에 append
                numStr += ran;
            }else {
                //생성된 난수가 중복되면 루틴을 다시 실행한다
                i-=1;
            }
           
        }
        return numStr;
     }

}
