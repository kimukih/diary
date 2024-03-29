<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%
	// 0. session 사용 로그인(인증) 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null){
		String errMsg = URLEncoder.encode("로그인 상태가 아닙니다. 로그인을 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg); // 에러메시지 출력
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// 로그인 완료되면 on_date에 현재 날짜를 DB에 넣는 코드
	String onDateSql = "UPDATE login SET on_date = NOW() WHERE my_session = 'ON'";
	PreparedStatement onDateStmt = null;
		
	onDateStmt = conn.prepareStatement(onDateSql);
	System.out.println("onDateStmt : " + onDateStmt);

	int onDateRow = onDateStmt.executeUpdate();
	if(onDateRow==1){
		System.out.println("현재 날짜 저장 성공");
	}else{
		System.out.println("현재 날짜 저장 실패");
	}
	
	// 로그인 상태를 출력하는 코드
	String sessOnSql = "SELECT my_session AS mySession, on_date AS onDate FROM login";
	PreparedStatement sessOnStmt = null;
	ResultSet sessOnRs = null;
	
	sessOnStmt = conn.prepareStatement(sessOnSql);
	System.out.println("sessOnStmt : " + sessOnStmt);
	
	sessOnRs = sessOnStmt.executeQuery();
	
	// 일기장 내용 DB에서 가져와서 화면에 출력하기
	String diaryContentSql = "SELECT diary_date AS diaryDate, title, create_date AS createDate FROM diary ORDER BY diary_date DESC LIMIT 0, 5";
	PreparedStatement diaryContentStmt = null;
	ResultSet diaryContentRs = null;
	
	diaryContentStmt = conn.prepareStatement(diaryContentSql);
	System.out.println("diaryContentStmt : " + diaryContentStmt);
	
	diaryContentRs = diaryContentStmt.executeQuery();
	
	// 캘린더 만들기
	Calendar cal = Calendar.getInstance();
	Calendar tCal = Calendar.getInstance();
	
	int tDay = tCal.get(Calendar.DATE);
	System.out.println("오늘은 : " + tDay + "일 입니다.");
	
	// 특정 달을 입력받을 때 마다 날짜 바꾸어주기
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	System.out.println("targetYear : " + targetYear);
	System.out.println("targetMonth : " + targetMonth);
		
	if(targetYear!=null && targetMonth!=null){
		cal.set(Calendar.YEAR, Integer.parseInt(targetYear));
		cal.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	
	// 올해가 몇년도 인지 구하기
	// 이번달이 무슨달인지 구하기
	int thisYear = cal.get(Calendar.YEAR);
	int thisMonth = cal.get(Calendar.MONTH);
	System.out.println("thisYear : " + thisYear);
	System.out.println("thisMonth : " + thisMonth);
	
	// 요청값 분석하기
	
	// 이번달 1일의 요일코드 구하기
	cal.set(Calendar.DATE, 1);
	
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	System.out.println("3월 1일의 요일 코드는 : " + dayOfWeek);
	
	// 달력의 앞쪽 빈공간 개수 구하기
	int preBlank = dayOfWeek - 1;
	System.out.println("3월 달력의 앞쪽 빈공간 크기는 : " + preBlank);
	
	// 특정 달의 마지막 날 구하기
	int lastDate = cal.getActualMaximum(Calendar.DATE);
	System.out.println("3월의 마지막 날짜는 : " + lastDate);
	
	// 달력의 뒤쪽 빈공간 개수 구하기
	int afterBlank = 7 - (preBlank + lastDate) % 7;
	System.out.println("3월 달력의 뒤쪽 빈공간 크기는 : " + afterBlank);
	
	// 달력 만드는데 필요한 총 td태그의 개수
	int totalTd = preBlank + lastDate + afterBlank;
	System.out.println("달력의 총 칸수는 : " + totalTd);
	
	// DB에서 thisYear와 thisMonth에 해당하는 diary 목록 추출
	String diarySql = "SELECT diary_date as diaryDate, day(diary_date) as day, left(title, 4) as title, feeling FROM diary WHERE YEAR(diary_date) = ? AND MONTH(diary_date) = ?";
	PreparedStatement diaryStmt = null;
	diaryStmt = conn.prepareStatement(diarySql);
	diaryStmt.setInt(1, thisYear);
	diaryStmt.setInt(2, thisMonth+1);
	System.out.println("diaryStmt : " + diaryStmt);
	
	ResultSet diaryRs = null;
	diaryRs = diaryStmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일기장</title>
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
	<div class="home"><a class="btn btn-dark" href="/diary/statsLunch.jsp">Lunch Menu Voting</a></div>
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
				<table class="table table-hover table-light table-striped">
					<tr>
						<th>Diary Date</th>
						<th>Title</th>
						<th>Add Date</th>
					</tr>
				<%
					while(diaryContentRs.next()){
				%>
						<tr>
							<td><%=diaryContentRs.getString("diaryDate")%></td>
							<td><a href="./diaryOne.jsp?diaryDate=<%=diaryContentRs.getString("diaryDate")%>"><%=diaryContentRs.getString("title")%></a></td>
							<td><%=diaryContentRs.getString("createDate")%></td>
						</tr>
				<%
					}
				%>
					
				</table>
				
				<a href="./diaryList.jsp?currentPage=1&rowPerPage=10" class="btn btn-dark">All Diary List</a>
				<a href="./addDiaryForm.jsp" class="btn btn-dark">Add Diary</a>
				
				<hr>
				<a href="/diary/diary.jsp?targetYear=<%=thisYear%>&targetMonth=<%=thisMonth-1%>" class="btn btn-dark">&laquo;</a>
				<a href="/diary/diary.jsp?targetYear=<%=thisYear%>&targetMonth=<%=thisMonth+1%>" class="btn btn-dark">&raquo;</a>
				<h1><%=thisYear%>년 <%=thisMonth+1%>월 달력</h1><br>
			
				<div class="container" id="diaryDiv">
				<div class="yo sun">Sun</div>
				<div class="yo">Mon</div>
				<div class="yo">Tue</div>
				<div class="yo">Wed</div>
				<div class="yo">Thu</div>
				<div class="yo">Fri</div>
				<div class="yo sat">Sat</div>
				<div class="cal">
				<%
					for(int i = 1; i <= totalTd; i++){
						if(i%7==1){
							if(i-preBlank==tDay){
				%>
								<div class="cell sun tDay">
				<%
							}else{
				%>
								<div class="cell sun">
				<%
							}
						}else if(i%7==0){
								if(i-preBlank==tDay){
				%>
									<div class="cell sat tDay">
				<%
								}else{
				%>
									<div class="cell sat">
				<%
								}
						}else{
							if(i-preBlank==tDay){
				%>
								<div class="cell tDay">
				<%
							}else{
				%>
								<div class="cell">
				<%
							}
						}
							if(i-preBlank > 0 && i-preBlank <= lastDate){
				%>
								<%=i-preBlank%>
				<%			
							// 현재 날짜인 i-preBlank의 일기가 diaryRs목록에 있는지 비교
							while(diaryRs.next()){
								// true이면 해당 날짜에 일기가 존재한다는 뜻
								if(diaryRs.getInt("day") == i-preBlank){
				%>
									<div>
										<a href="/diary/diaryOne.jsp?diaryDate=<%=diaryRs.getString("diaryDate")%>">
											<%=diaryRs.getString("feeling")%><%=diaryRs.getString("title")%>...
										</a>
									</div>
				<%
									break;
								}
							}
							diaryRs.beforeFirst();	// ResultSet의 커서 위치를 처음으로 이동시킴
							}else{
				%>
								&nbsp;
				<%				
							}
				%>		
						</div>
				<%
					}
				%>
				</div>
				</div>
				<br><br>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>