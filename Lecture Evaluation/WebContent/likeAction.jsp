<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="likey.LikeyDAO" %>
<%!

	public static String getClientIP(HttpServletRequest request){
		String ip =request.getHeader("X-FORWARDED-FOR");
		if (ip== null || ip.length() == 0) {
				ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0){
			ip =request.getRemoteAddr();
		}
		System.out.println("ip="+ip+"\n");
		return ip;
		
	
}

%>



<%
  request.setCharacterEncoding("UTF-8");
	UserDAO userDAO = new UserDAO();
	String userID=null;
	
	
	if(session.getAttribute("userID") != null) {//현재 로그인한 계정으로 userID값을 가지고 온다 

		userID = (String) session.getAttribute("userID");
		System.out.println("userID="+userID+"\n");

	}
	
	System.out.println("userID="+session.getAttribute("userID")+"\n");
	
	if(userID == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();

	}


	
	
	String evaluationID =null;
	
	if(request.getParameter("evaluationID")!=null){//현재 로그인한 계정으로 evaluationID값을 가지고 온다
		evaluationID=request.getParameter("evaluationID");
		System.out.println("evaluationID="+evaluationID+"\n");
	}
	
	EvaluationDAO evaluationDAO =new EvaluationDAO();
	LikeyDAO likeyDAO =new LikeyDAO();
	int result =likeyDAO.like(userID, evaluationID,getClientIP(request));
	System.out.println("first result="+result+"\n");
	 if(result ==1)
		{
			result = evaluationDAO.like(evaluationID);
			System.out.println("second result="+result+"\n");
			if (result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('추천이 완료 되었습니다.');");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.');");
				script.println("history.back()");
				script.println("</script>");
				
			}
	   }else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 추천을 누른 글입니다.');");
			script.println("history.back()");
			script.println("</script>");
			
		}
	
	%>









	

		

