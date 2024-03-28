<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인 인증 분기코드
	// 모든 페이지에 들어갈 코드
	// 로그인 상태가 ON 인지 OFF 인지
	// diary.login.my_session => 'OFF' => Redirect("loginForm.jsp");
	// diary.login.my_session => 'ON' => Redirect("diary.jsp");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String loginSql = "SELECT my_session AS mySession FROM login";
	PreparedStatement loginStmt = null;
	ResultSet loginRs = null;

	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	loginStmt = conn.prepareStatement(loginSql);
	System.out.println("loginStmt : " + loginStmt);
	
	loginRs = loginStmt.executeQuery();
	
	String mySession = null;
	if(loginRs.next()){
		mySession = loginRs.getString("mySession");
	}
	
	if(mySession.equals("ON")) {
		response.sendRedirect("/diary/loginForm.jsp");
		return; 	// 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	
	// 1. 요청값 분석하기
	String errMsg = request.getParameter("errMsg");
	System.out.println("errMsg : " + errMsg);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		.container{
			text-align: center;
		}
		
		.table{
			text-align: center;
		}
		
		div.main{
			background-image: url("./diarybg.png");
		}
		
		div.page{
			background-image: url("./diarypage.png");
		}
		
		@font-face {
		    font-family: 'diary';
		    src: url('./PlayfairDisplay-VariableFont_wght.ttf') format('truetype');
		}
		
		h1{
			font-family: 'diary';
			color: #000000;
		}
		
		h1.cover{
			padding-top: 30px;
		}
		
		body{
			font-family: 'diary';
			color: #000000;
			background-color: gray;
		}
		
		td.login{
			font-weight: large;
		}
		
		div.cover{
			
		}
	</style>
</head>
<body>
	<div class="container main">
		<h1 class="cover">Every Moment In Your Life</h1>
		<div class="row">
			<div class="col"></div>			
			<div class="page col-8 mt-5 mb-5 p-3">
				<!-- 메인 내용 시작 -->
					<div>
						<%
							if(errMsg != null){
						%>
								<%=errMsg%>
						<%
							}
						%>
					</div>
					
					<form method="post" action="./loginAction.jsp">
						<h1>Login</h1>
						<br>
						<table class="table table-hover table-striped table-light">
							<tr>
								<td><b>ID : </b></td>
								<td><input type="text" name="loginId" placeholder="Please enter your ID" size="30px"></td>
							</tr>
							<tr>	
								<td><b>PW : </b></td>
								<td><input type="password" name="loginPw" placeholder="Please enter your PW" size="30px"></td>
							</tr>
						</table>
						<br>
						<button type="submit" class="btn btn-dark" style="color: #FFFFF0;">Login</button>
						<a href="" class="btn btn-dark">Sign Up</a>
					</form>
				<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
		<br><br><br><br><br><br><br><br><br><br><br><br>
	</div>
</body>
</html>