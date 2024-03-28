<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//로그인 인증 분기코드
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
	
	if(mySession.equals("OFF")){
		String errMsg = URLEncoder.encode("접근실패, 로그인 먼저 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg);
		return;		// 로그인 실패시 로그인 창으로 재요청하고 코드진행 중단
	}
	
	// 로그인 상태를 출력하는 코드
	String sessOnSql = "SELECT my_session AS mySession, on_date AS onDate FROM login";
	PreparedStatement sessOnStmt = null;
	ResultSet sessOnRs = null;
	
	sessOnStmt = conn.prepareStatement(sessOnSql);
	System.out.println("sessOnStmt : " + sessOnStmt);
	
	sessOnRs = sessOnStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		a{
			text-decoration: none;
			color: #000000;
			font-weight: bold;
		}
		
		a:hover{color: gray;}
		
		.cell{
			display: table-cell;
			float: left;
			width: 80px; height: 80px;
			border: solid 1px #000000;
			font-size: medium;
			color : #000000;
		}
		
		.yo{
			float: left;
			width: 80px; height: 40px;
			color : #000000;
			text-align: center;
			vertical-align: middle;
			font-size: large;
			padding-left: 50px;
		}
		
		.sun{
			color: #FF0000;
			clear: both;
		}
		
		.sat{
			color: #0000FF;
		}
		
		div.logout{
			display: table-cell;
			float: right;
			padding-top: 10px;
		}
		
		.container{
			text-align: center;
		}
		
		.table{
			text-align: center;
		}
		
		td{
			font-weight: bold;
		}
		
		div.main{
			background-image: url("/diary/img/diarybg.png");
		}
		
		div.page{
			background-image: url("/diary/img/diarypage.png");
		}
		
		@font-face {
		    font-family: 'diary';
		    src: url('/diary/font/PlayfairDisplay-VariableFont_wght.ttf') format('truetype');
		}
		
		h1{
			font-family: 'diary';
			color: #000000;
		}
		
		body{
			font-family: 'diary';
			color: #000000;
			background-color: gray;
		}
		
		div.home{
			display: table-cell;
			float: left;
			padding-top: 10px;
		}
		
		.logstatus{
			font-family: 'diary';
			text-align: left;
			font-weight: bold;
		}
		
		div.cal{
			padding-left: 25px;
		}
		
		div.cell{
			background-color: #F6F6F6;
			border-color: gray;
		}
		
		div.tDay{
			background-image: url("/diary/img/mtcc.png");
			background-size: contain;
		}
		
		#diaryDiv{
            width: 600px;
            height: 500px;
            padding: 0px;
        }
	</style>
</head>
<body>
	<div class="container main">
	<div class="home"><a class="btn btn-dark" href="/diary/diary.jsp">Home</a></div>
	<%
	if(sessOnRs.next()){
	%>
		<div class="logout"><a class="btn btn-dark" href="./logoutAction.jsp?mySession=<%=sessOnRs.getString("mySession")%>">Logout</a></div><br><br>
		<div class="logstatus">Login Status : <%=sessOnRs.getString("mySession")%></div>
		<div class="logstatus">Login Date : <%=sessOnRs.getString("onDate")%></div>
	<%
	}
	%>
		<div class="row">
			<div class="col"></div>	
			<div class="page col-8 mt-5 mb-5 p-3">
			<!-- 메인 내용 시작 -->
				<h1>Vote Today's Lunch</h1>
				<form method="post" action="/diary/voteLunchAction.jsp">
					<input type="radio" name="menu" value="한식">한식
					<input type="radio" name="menu" value="일식">일식
					<input type="radio" name="menu" value="양식">양식
					<input type="radio" name="menu" value="중식">중식
					<input type="radio" name="menu" value="기타">기타
					<br><br>
					<button type="submit" class="btn btn-dark">투표하기</button>
				</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>	
		</div>
	</div>
</body>
</html>