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

	String lunchSql = "SELECT menu, COUNT(*) cnt FROM lunch GROUP BY menu";
	PreparedStatement lunchStmt = null;
	ResultSet lunchRs = null;
	lunchStmt = conn.prepareStatement(lunchSql);
	System.out.println("lunchStmt : " + lunchStmt);
	
	lunchRs = lunchStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">	
	<style>
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
		
		div.logout{
			display: table-cell;
			float: right;
			padding-top: 10px;
		}
	</style>
</head>
<body>
	<div class="container main">
	<div class="home"><a class="btn btn-dark" href="/diary/voteLunchForm.jsp">Vote Lunch</a></div>
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
				<h1>Vote Result</h1>
					<%
						int maxHeight = 500;	// 그래프의 최대 높이는 300px 고정
						int totalCnt = 0;
						while(lunchRs.next()){
							totalCnt += lunchRs.getInt("cnt");
							
						}
						lunchRs.beforeFirst();
					%>
				전체 투표 수 : <%=(int)totalCnt%>
				<table class="table table-hover table-light table-striper" border="1">
					<tr>
					<%
						String[] c = {"red", "orange", "yellow", "green", "pink"};
						int i = 0;
						while(lunchRs.next()){
							double h = maxHeight * (lunchRs.getInt("cnt")/(double)totalCnt);
					%>
							<td style="vertical-align: bottom; text-align: center;">
								<div style="height: <%=h%>px; background-color: <%=c[i]%>;">
									<%=lunchRs.getInt("cnt")%>
								</div>
							</td>
					<%	i++;
						}
					%>
					</tr>
					<tr>
					<%
						lunchRs.beforeFirst();
					
						while(lunchRs.next()){
					%>
							<td><%=lunchRs.getString("menu")%></td>
					<%
						}
					%>
					</tr>
				</table>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>