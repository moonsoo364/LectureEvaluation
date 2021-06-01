<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDTO" %>
<%@page import="user.UserDAO" %>
<%@page import="util.SHA256" %>
<%@page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
	String userID =null;

	String userPassword =null;
	if(request.getParameter("userID")!=null){
		userID =request.getParameter("userID");
		session.setAttribute("userID", userID);
	}
	if(request.getParameter("userPassword")!=null){
		userPassword=request.getParameter("userPassword");
	}
	
	System.out.printf("id=%s Password=%s\n",userID,userPassword);
	if(userID==null ||userPassword ==null){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('아이디,비밀번호를 등록해주세요');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	UserDAO userDAO =new UserDAO();
	int result =userDAO.login(userID,userPassword);
	if(result==1){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인에 성공하셨습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else if(result==0){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 일치하지 않습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}else if(result==-1){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 일치하지 않습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}else if(result==-2){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('DB오류가 발생했습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
%>
	