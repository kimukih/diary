<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 0-1) 로그인(인증) 분기 session 사용으로 변경
	// 로그인 성공시 session에 loginMember라는 변수를 만들고 값으로 로그인 아이디를 저장
	String loginMember = (String)session.getAttribute("loginMember");
	// session.getAttribute()는 찾는 변수가 없으면 null값을 반환
	// null값이면 한번도 로그인 한적이 없는상태, null이 아니면 로그인 상태
	System.out.println("loginMember : " + loginMember);
	
	// loginForm페이지는 로그아웃 상태에서만 출력되는 페이지
	// session변수가 null이 아니다 > session 변수가 존재한다 > 로그인 상태이다
	if(loginMember != null){
		response.sendRedirect("/diary/diary.jsp");
		return;	// 코드 진행을 끝내는 문법 ex) 메서드 끝낼 때 return 사용
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
					
					<form method="post" action="/diary/action/loginAction.jsp">
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