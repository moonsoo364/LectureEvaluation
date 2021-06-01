<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO"%>

<%@ page import="user.UserDAO"%>

<%@ page import="util.SHA256"%>

<%@ page import="java.io.PrintWriter"%>

<%
String a = "aaa";
String b = a;
String c = new String ("aaa");

System.out.printf( "a=aaa,b=a,c=a\n");
System.out.printf( "a.equals(null):%b\n",a.equals(null));
System.out.printf( "a==b:%b\n",a==b);
System.out.printf( "a==c:%b\n",a==c);
System.out.printf( "a.equals(c):%b\n",a.equals(c));






	 request.setCharacterEncoding("UTF-8");

	String userID = null;

	String userPassword = null;

	String userEmail = null;
	
	

	if(request.getParameter("userID") != null) {

		userID = (String) request.getParameter("userID");

	}

	if(request.getParameter("userPassword") != null) {

		userPassword = (String) request.getParameter("userPassword");

	}

	if(request.getParameter("userEmail") != null) {

		userEmail = (String) request.getParameter("userEmail");

	}

	if (userID == null || userPassword == null || userEmail == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('입력이 안 된 사항이 있습니다.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();

	} else {

		UserDAO userDAO = new UserDAO();

		int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));

		if (result == -1) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('이미 존재재하는 아이디입니다.');");

			script.println("history.back();");

			script.println("</script>");

			script.close();

		} else {

			session.setAttribute("userID", userID);

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("location.href = 'emailSendAction.jsp';");

			script.println("</script>");

			script.close();

		}

	} 

%> --%>





