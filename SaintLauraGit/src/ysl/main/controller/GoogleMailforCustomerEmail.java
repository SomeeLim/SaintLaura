package ysl.main.controller;

import javax.mail.Transport;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.Address;
import javax.mail.internet.MimeMessage;
import ysl.main.controller.MySMTPAuthenticator;
import javax.mail.Session;
import javax.mail.Authenticator;

import java.util.HashMap;
import java.util.Properties;

public class GoogleMailforCustomerEmail {
	
	public void sendmail(HashMap<String, String> paraMap)  
	    	throws Exception{
	        
	    	// 1. 정보를 담기 위한 객체
	    	Properties prop = new Properties(); 
	    	
	    	// 2. SMTP 서버의 계정 설정
	   	    //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
	    	//	    보내는 사람의 메일주소
	    	prop.put("mail.smtp.user", "개인key"); // key , value
	        	
	    	
	    	// 3. SMTP 서버 정보 설정
	    	//    Google Gmail 인 경우  smtp.gmail.com
	    	prop.put("mail.smtp.host", "smtp.gmail.com");
	         	
	    	
	    	prop.put("mail.smtp.port", "465");
	    	prop.put("mail.smtp.starttls.enable", "true");
	    	prop.put("mail.smtp.auth", "true");
	    	prop.put("mail.smtp.debug", "true");
	    	prop.put("mail.smtp.socketFactory.port", "465");
	    	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    	prop.put("mail.smtp.socketFactory.fallback", "false");
	    	
	    	prop.put("mail.smtp.ssl.enable", "true");
	    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // 메일을 주고받을 수 있는 protocol simple mail transportation
	      	
	    	
	    	Authenticator smtpAuth = new MySMTPAuthenticator(); // 우리가 만들어 온 클래스
	    	Session ses = Session.getInstance(prop, smtpAuth);
	    		
	    	// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
	    	ses.setDebug(true);
	    	        
	    	// 메일의 내용을 담기 위한 객체생성
	    	MimeMessage msg = new MimeMessage(ses);

	    	// 제목 설정
	    	String subject = "["+paraMap.get("csEmailCat1")+"] "+paraMap.get("csEmailEmail")+"고객님으로부터의 문의가 들어왔습니다.";
	    	msg.setSubject(subject);
	    	        
	    	// 보내는 사람의 메일주소 
	    	String sender = "개인key";
	    	Address fromAddr = new InternetAddress(sender);
	    	msg.setFrom(fromAddr);
	    	        
	    	// 받는 사람의 메일주소
	    	Address toAddr = new InternetAddress(sender);
	    	msg.addRecipient(Message.RecipientType.TO, toAddr);
	    	        
	    	// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
	    	msg.setContent("<div style='width:80%; margin:0 auto;'>"+
	    				   "<img src='https://www.ysl.com/clientservice/wp-content/uploads/2018/03/Banner_ClientService_dsk_half.jpg' style='width:600px; height:130px;' />" +
	    				   "<table style='font-size:9pt; border: solid 1px #e9e9e9; border-collapse: collapse; width:600px;'>" + 
	    				   "<tr style='border: solid 1px #e9e9e9; border-collapse: collapse;'>" +
	    				   "<td colspan='4' style='padding:15px 0 15px 5px;'>"+paraMap.get("csEmailEmail")+"고객님으로부터의 문의가 들어왔습니다.</td>" +
	    				   "</tr>" +
	    				   "<tr style='border: solid 1px #e9e9e9; border-collapse: collapse;'>" +
	    				   "<td style='padding:15px 0 15px 5px;'>이름</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>"+paraMap.get("csEmailName") +"</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>연락처</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>"+ paraMap.get("csEmailHp") +"</td>" +
	    				   "</tr>" +
	    				   "<tr style='border: solid 1px #e9e9e9; border-collapse: collapse;'>" +
	    				   "<td style='padding:15px 0 15px 5px;'>항목</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>"+ paraMap.get("csEmailCat1") +"</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>주제</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>"+ paraMap.get("csEmailCat2") +"</td>" +
	    				   "</tr>" +
	    				   "<tr style='border: solid 1px #e9e9e9; border-collapse: collapse;'>" +
	    				   "<td style='padding:15px 0 15px 5px;'>주문번호</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>"+ paraMap.get("csEmailOrderNo") +"</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>제품번호</td>" +
	    				   "<td style='padding:15px 0 15px 5px;'>"+ paraMap.get("csEmailProdNo") +"</td>" +
	    				   "</tr>" +
	    				   "<tr style='border: solid 1px #e9e9e9; border-collapse: collapse;'>" +
	    				   "<td style='padding:15px 0 15px 5px;'>문의내용</td>" +
	    				   "<td colspan='3' style='padding:15px 0 15px 5px;'>"+paraMap.get("csEmailMsg")+"</td>" +
	    				   "</tr>" +
	    				   "</table>"

	    				 , "text/html;charset=UTF-8");
	    	        
	    	// 메일 발송하기
	    	Transport.send(msg);
	    	
	    }

}
