<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%
	//0. session 사용 로그인(인증) 분기
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
	
	// 게시물 페이징을 하기 위해 현재 DB에 저장된 게시물의 개수 가져오기
	String countSql = "SELECT COUNT(*) AS countContent FROM diary";
	PreparedStatement countStmt = conn.prepareStatement(countSql);
	System.out.println("countStmt : " + countStmt);
	
	ResultSet countRs = countStmt.executeQuery();
	int totalContent = 0;
	
	while(countRs.next()){
		totalContent = countRs.getInt("countContent");
	}
	System.out.println("총 일기의 개수 : " + totalContent);
	
	// rowPerPage 값을 지정하기 위한 요청값 분석
	String rpp = request.getParameter("rpp");
	System.out.println("rpp : " + rpp);
	
	// 게시물을 10개씩 페이징 하기
	int rowPerPage = 10; // 다음 버튼 누르면 rpp값이 null로 초기화되는것이 문제임
	
	// diary.jsp에서 currentPage값만 받아오고
	// rowPerPage 값은 받아오지 않아서 <select> 로부터 value를 받아도
	// 다음페이지 버튼을 누르면 rowPerPage가 10으로 고정되는 문제 발생
	// diary.jsp에서 rowPerPage 값을 넘기고 diaryList.jsp에서 요청값 분석을 하고
	// 그 후 value값으로 받은 rowPerPage값을 대입시켜 주니 정상적으로 작동함
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	System.out.println("rowPerPage : " + rowPerPage);
	
	// rowPerPage 개수 바꾸는 기능
	if(request.getParameter("rpp") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rpp"));
	}
	System.out.println("rpp rowPerPage : " + rowPerPage);
	
	int currentPage = 1;	// 현재 페이지
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage : " + currentPage);
	
	int lastPage = 0;		// 마지막 페이지
	
	// totalContent가 3이면 lastPage는 1
	// totalContent가 13이면 lastPage는 2
	// totalContent가 53이면 lastPage는 6
	// totalContent가 70이면 lastPage는 7
	// totalContent가 10으로 나누어떨어지지 않으면 --> lastPage = 몫 + 1
	// totalContent가 10으로 나누어떨어지면 --> lastPage = 몫
	if(totalContent%rowPerPage != 0){
		lastPage = (totalContent / rowPerPage) + 1;
	}else{
		lastPage = totalContent / rowPerPage;
	}
	System.out.println("lastPage : " + lastPage);
	
	/*
		페이징 조건
		0 1 2 ~ 8 9 :  		1페이지 LIMIT 0, 10
		10 11 12 ~ 18 19 :  2페이지 LIMIT 10, 10
		20 21 22 ~ 28 29 :  3페이지 LIMIT 20, 10
		LIMIT의 첫번째 물음표에는 (currentPage - 1) * rowPerPage 가 들어가면 됨
	*/
	
	// 일기장 내용 DB에서 가져와서 화면에 출력하기
	String diaryContentSql = "SELECT diary_date AS diaryDate, title, create_date AS createDate FROM diary WHERE title LIKE ? ORDER BY diary_date DESC LIMIT ?, ?";
	PreparedStatement diaryContentStmt = null;
	ResultSet diaryContentRs = null;
	
	String search = "";
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	System.out.println("search : " + search);
	
	diaryContentStmt = conn.prepareStatement(diaryContentSql);
	diaryContentStmt.setString(1, "%"+search+"%");
	diaryContentStmt.setInt(2, (currentPage-1)*rowPerPage);
	diaryContentStmt.setInt(3, rowPerPage);
	System.out.println("diaryContentStmt : " + diaryContentStmt);
	
	diaryContentRs = diaryContentStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>다이어리 리스트</title>
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
			background-image: url("./mtcc.png");
			background-size: contain;
		}
		
		#diaryDiv{
            width: 600px;
            height: 500px;
            padding: 0px;
        }
        
        a.page-link{
        	color: #000000;
        }
        
        ul.pagenation{
        	text-align: center;
        }
        
        div.rpp{
        	text-align: right;
        }
        
	</style>
</head>
<body>
	<div class="container main">
	<span class="home"><a class="btn btn-dark" href="/diary/diary.jsp">Home</a></span>
	<span class="home" style="margin-left: 10px"><a class="btn btn-dark" href="/diary/diary.jsp">Back</a></span>
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
				<h1>All Diary List</h1>
				<div class="rpp">
				<form method="post" action="/diary/diaryList.jsp">
					<select name="rpp">
						<%
						if(rowPerPage == 10){
						%>
							<option value="10" selected>10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						<%
						}else if(rowPerPage == 15){
						%>
							<option value="10">10</option>
							<option value="15" selected>15</option>
							<option value="20">20</option>
						<%
						}else{
						%>
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20" selected>20</option>
						<%
						}
						%>
						
					</select>
					<button type="submit" class="btn btn-dark">Reroad</button>
				</form>
				</div>
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
							<td><a href="/diary/diaryOne.jsp?diaryDate=<%=diaryContentRs.getString("diaryDate")%>"><%=diaryContentRs.getString("title")%></a></td>
							<td><%=diaryContentRs.getString("createDate")%></td>
						</tr>
				<%
					}
				%>			
				</table>
				
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
				<%
				if(currentPage > 1 && currentPage < lastPage){
				%>
				    <li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">&laquo;</a></li>
					<li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">&lsaquo;</a></li>
				    <li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">&rsaquo;</a></li>
				    <li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">&raquo;</a></li>
				<%
				}else if(currentPage == 1){
				%>
					<li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">&rsaquo;</a></li>
					<li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">&raquo;</a></li>
				<%
				}else if(currentPage == lastPage){
				%>
					<li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">&laquo;</a></li>
					<li class="page-item"><a class="page-link" href="/diary/diaryList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">&lsaquo;</a></li>
				<%
				}
				%>
					</ul>
				</nav>
				<br>
				<form method="post" action="/diary/diaryList.jsp">
					Search : 
					<input type="text" name="search">
					<button type="submit" class="btn btn-dark">Search</button>
				</form>
			<!-- 메인 내용 끝 -->	
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>