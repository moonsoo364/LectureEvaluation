<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.mail.Transport"%>

<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>

<%@page import="javax.mail.internet.InternetAddress"%>

<%@page import="javax.mail.internet.MimeMessage"%>

<%@page import="javax.mail.Session"%>

<%@page import="javax.mail.Authenticator"%>

<%@page import="java.util.Properties"%>

<%@page import="java.io.PrintWriter"%>

<%@page import="user.UserDAO"%>

<%@page import="util.SHA256"%>

<%@page import="util.Gmail"%>



<%
	request.setCharacterEncoding("UTF-8");
	UserDAO userDAO = new UserDAO();
	String userID = null;
	String userEmail =null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}
	
	if(session.getAttribute("Email") != null) {

		userEmail = (String) session.getAttribute("Email");

	}
	System.out.println("------reportAction.jsp입니다-------"+"\n");
	
	System.out.println("userID="+userID+"\n");
	System.out.println("userEmail="+userEmail+"\n");
	
	System.out.println("------reportAction.jsp입니다-------"+"\n");
	String reportTitle =null;
	String reportContent =null;
	
	if(request.getParameter("reportTitle")!=null){
		reportTitle =request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent")!=null){
		reportContent=request.getParameter("reportContent");
	}
	if(reportContent ==null || reportTitle ==null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('신고내용이 비었습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();

	}
	System.out.println("reportTitle="+reportTitle+"\n");
	System.out.println("reportContent="+reportContent+"\n");
	if(userID == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();

	}
	

	

	

	// 사용자에게 보낼 메시지를 기입합니다.

	String host = "http://localhost:8080/Lecture_Evaluation/";

	String from = "aptx15hibr@gmail.com";

	String to = userEmail;

	String subject = "강의 평가 사이트에서 접수된 신고메일입니다.";

	String content = "신고자:"+userID+
			"<br>제목:"+reportTitle+
			"<br>내용:"+reportContent;
			

	

	// SMTP에 접속하기 위한 정보를 기입합니다.

	Properties p = new Properties();

	p.put("mail.smtp.user", from);

	p.put("mail.smtp.host", "smtp.gmail.com");

	p.put("mail.smtp.port", "465");

	p.put("mail.smtp.starttls.enable", "true");

	p.put("mail.smtp.auth", "true");

	p.put("mail.smtp.debug", "true");

	p.put("mail.smtp.socketFactory.port", "465");

	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

	p.put("mail.smtp.socketFactory.fallback", "false");

	 

	try{

	    Authenticator auth = new Gmail();

	    Session ses = Session.getInstance(p, auth);

	    ses.setDebug(true);

	    MimeMessage msg = new MimeMessage(ses); 

	    msg.setSubject(subject);

	    Address fromAddr = new InternetAddress(from);

	    msg.setFrom(fromAddr);

	    Address toAddr = new InternetAddress(to);

	    msg.addRecipient(Message.RecipientType.TO, toAddr);

	    msg.setContent(content, "text/html;charset=UTF-8");

	    Transport.send(msg);
	    

	} catch(Exception e){

	    e.printStackTrace();

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('에러입니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		System.out.println("------메일 전송 실패-------"+"\n");

		}
	    
	

 
	

%>








	

		

