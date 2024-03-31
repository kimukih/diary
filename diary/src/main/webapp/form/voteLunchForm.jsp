<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 0. session 사용 로그인(인증) 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null){
		String errMsg = URLEncoder.encode("로그인 상태가 아닙니다. 로그인을 해주세요.", "utf-8");
		response.sendRedirect("/diary/form/loginForm.jsp?errMsg=" + errMsg); // 에러메시지 출력
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// 로그인 상태를 출력하는 코드
	String sessOnSql = "SELECT my_session AS mySession, on_date AS onDate FROM login";
	PreparedStatement sessOnStmt = null;
	ResultSet sessOnRs = null;
	
	sessOnStmt = conn.prepareStatement(sessOnSql);
	System.out.println("sessOnStmt : " + sessOnStmt);
	
	sessOnRs = sessOnStmt.executeQuery();
	
	// 요청값 분석
	String msg = request.getParameter("msg");
	String errMsg = request.getParameter("errMsg");
	String lunchDate = request.getParameter("lunchDate");
	System.out.println("msg : " + msg);
	System.out.println("errMsg : " + errMsg);
	System.out.println("lunchDate : " + lunchDate);
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
		
		span.home{
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
	<span class="home"><a class="btn btn-dark" href="/diary/diary.jsp">Home</a></span>
	<span class="home" style="margin-left: 10px"><a class="btn btn-dark" href="/diary/statsLunch.jsp">Back</a></span>
	<%
	if(sessOnRs.next()){
	%>
		<div class="logout"><a class="btn btn-dark" href="/diary/action/logoutAction.jsp?mySession=<%=sessOnRs.getString("mySession")%>">Logout</a></div><br><br>
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
				<form method="post" action="/diary/action/checkLunchDateAction.jsp">
					<input type="date" name="checkDate">
					<button type="submit" class="btn btn-dark">Check</button><br>
					<%
					if(msg != null){
					%>
						<%=msg%>
					<%
					}
					%>
				</form>
				<form method="post" action="/diary/action/voteLunchAction.jsp">
					<input type="date" name="lunchDate" value="<%=lunchDate%>" readonly="readonly"><br><br>
					<input type="radio" name="menu" value="한식"> 한식&nbsp;&nbsp;
					<input type="radio" name="menu" value="일식"> 일식&nbsp;&nbsp;
					<input type="radio" name="menu" value="양식"> 양식&nbsp;&nbsp;
					<input type="radio" name="menu" value="중식"> 중식&nbsp;&nbsp;
					<input type="radio" name="menu" value="기타"> 기타
					<br><br>
					<button type="submit" class="btn btn-dark">Vote</button>
				</form>
				<br>
				<%
				if(errMsg != null){
				%>
					<%=errMsg%>
				<%
				}
				%>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>	
		</div>
	</div>
</body>
</html>