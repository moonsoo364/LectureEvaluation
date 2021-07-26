<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="likey.LikeyDTO" %>



<%

	UserDAO userDAO = new UserDAO();
	
	String userID = null;
	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}
	System.out.println("userID="+userID+"\n");
	if(userID == null) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();

	}

	
	request.setCharacterEncoding("UTF-8");
	String evaluationID =null;
	
	if(request.getParameter("evaluationID")!=null){
		evaluationID=request.getParameter("evaluationID");
	}
	
	System.out.println("evaluationID="+evaluationID+"\n");
	
	EvaluationDAO evaluationDAO =new EvaluationDAO();
	
	
	if(userID.equals(evaluationDAO.getUserID(evaluationID))){
		int result = new EvaluationDAO().delete(evaluationID);
		System.out.println("result="+result+"\n");
		if (result ==1)
		{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제가 완료 되었습니다.');");
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
		script.println("alert('자신이 쓴 글만 삭제할 수 있습니다.');");
		script.println("history.back()");
		script.println("</script>");
	}
	

%>








	

		

