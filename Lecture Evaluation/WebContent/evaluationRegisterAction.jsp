<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="evaluation.EvaluationDTO" %>
<%@page import="evaluation.EvaluationDAO" %>
<%@page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
	String userID =null;

	
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	System.out.printf("userID=%s\n",userID);
	if(userID == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 해주세요.');");

		script.println("location.href = 'userLogin.jsp'");

		script.println("</script>");

		script.close();

	

	}



	
	
	String lectureName=null;
	String professorName=null;
	int lectureYear=0;
	String semesterDivide=null;
	String lectureDivide=null;
	String evaluationTitle=null;
	String evaluationContent=null;
	String totalScore=null;
	String creditScore=null;
	String comfortableScore=null;
	String lectureScore=null;
	
	if(request.getParameter("lectureName")!=null){
		lectureName=request.getParameter("lectureName");
	}
	if(request.getParameter("professorName")!=null){
		professorName=request.getParameter("professorName");
	}
	if(request.getParameter("lectureYear")!=null){
		try{
			lectureYear=Integer.parseInt(request.getParameter("lectureYear"));
		}catch (Exception e){
			System.out.println("강의 연도 데이터 오류\n");
		}
	}
	if(request.getParameter("semesterDivide")!=null){
		semesterDivide=request.getParameter("semesterDivide");
	}
	if(request.getParameter("lectureDivide")!=null){
		lectureDivide=request.getParameter("lectureDivide");
	}
	if(request.getParameter("evaluationTitle")!=null){
		evaluationTitle=request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent")!=null){
		evaluationContent=request.getParameter("evaluationContent");
	}
	if(request.getParameter("totalScore")!=null){
		totalScore=request.getParameter("totalScore");
	}
	if(request.getParameter("creditScore")!=null){
		creditScore=request.getParameter("creditScore");
	}
	if(request.getParameter("comfortableScore")!=null){
		comfortableScore=request.getParameter("comfortableScore");
	}
	if(request.getParameter("lectureScore")!=null){
		lectureScore=request.getParameter("lectureScore");
	}
	
	System.out.printf("lectureName=%s\n",lectureName);
	System.out.printf("professorName=%s\n",professorName);
	System.out.printf("lectureYear=%s\n",lectureYear);
	System.out.printf("semesterDivide=%s\n",semesterDivide);
	System.out.printf("lectureDivide=%s\n",lectureDivide);
	System.out.printf("evaluationTitle=%s\n",evaluationTitle);
	System.out.printf("evaluationContent=%s\n",evaluationContent);
	System.out.printf("totalScore=%s\n",totalScore);
	System.out.printf("creditScore=%s\n",creditScore);
	System.out.printf("comfortableScore=%s\n",comfortableScore);
	System.out.printf("lectureScore=%s\n",lectureScore);
	System.out.printf("lectureName=%s\n",lectureName);
	
	if(lectureName==null || professorName ==null || lectureYear==0 || semesterDivide == null ||
		 lectureDivide == null || evaluationTitle ==null || evaluationContent == null || totalScore ==null||
		 creditScore ==null || comfortableScore==null || lectureScore == null||
		evaluationContent.equals("")||evaluationTitle.equals("")){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 데이터가 있습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		
	}

	EvaluationDAO evaluationDAO=new EvaluationDAO();
	int result =evaluationDAO.write(new EvaluationDTO(0,userID,lectureName,professorName
			,lectureYear,semesterDivide,lectureDivide,evaluationTitle,evaluationContent,
			totalScore,creditScore,comfortableScore,lectureScore,0));
	if(result==-1){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('강의 평가 등록에 실패했습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		
	
	}else{
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('강의 평가 등록에 성공했습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		
	}

	%>
	