<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="shrink-to-fit=no,width=device-width, initial-scale=1">
<title>회원 가입</title>

<!-- 부트스트랩 CSS 추가하기 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!--  커스텀 CSS 추가하기 -->
<link rel="stylesheet" href="./css/custom.css">

</head>
<body>
<%
String userID =null;
if(session.getAttribute("userID")!=null){
	userID=(String) session.getAttribute("userID");
}
System.out.println("userID="+userID+"\n");
	

System.out.printf("index에 세션되었습니다, userID=%s\n",userID);
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의 평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp" href="index.jsp">메인</a>
				</li>
			<%if(userID ==null){%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원 관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
					</div>
				</li>
			<%}else{ %>
			<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						<%=userID %>님 환영합니다!
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="userLogout.jsp">로그 아웃</a>
					</div>
				</li>
			<%}%>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" aria-label="search">
				<button class="btn btn-outline-sussess my-2 my-sm-0" type="submit">검색</button>
			</form>
	
	</nav>
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userRegisterAction.jsp">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="userID" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword" class="form-control">
			</div>
			<div class="form-group">
				<label>이메일</label>
				<input type="email" name="userEmail" class="form-control"
				>
			</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</form>		
	</section>

	
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2021 홍길동 All Rights Reserved.
	</footer>
	<!-- 제이 쿼리 자바 스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바 스크립트 추가하기 -->
	<script src="./js/popper.min.js"></script>
	<!-- bootstrap 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>

	
</body>
</html>