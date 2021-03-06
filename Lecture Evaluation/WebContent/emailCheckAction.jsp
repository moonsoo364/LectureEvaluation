<%@page import="java.io.PrintWriter"%>
<%@page import="util.SHA256"%>
<%@page import="user.UserDAO" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String code=null;
	UserDAO userDAO =new UserDAO();
	String userID =null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(request.getParameter("code")!=null){
		code=request.getParameter("code");
	}
	System.out.println("request.getParameter(code)="+request.getParameter("code")+"\n");
	if(userID==null){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	String userEmail =userDAO.getUserEmail(userID);
	boolean isRight=(SHA256.getSHA256(userEmail).equals(code)) ? true:false;
	if(isRight == true){
		userDAO.setUserEmailChecked(userID);
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('유효한 코드입니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	%>