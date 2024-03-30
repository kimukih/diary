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
	
	if(mySession.equals("OFF")){
		String errMsg = URLEncoder.encode("접근실패, 로그인 먼저 해주세요.", "utf-8");
		response.sendRedirect("/diary/form/loginForm.jsp?errMsg=" + errMsg);
		return;		// 로그인 실패시 로그인 창으로 재요청하고 코드진행 중단
	}
	
	// 로그인 상태를 출력하는 코드
	String sessOnSql = "SELECT my_session AS mySession, on_date AS onDate FROM login";
	PreparedStatement sessOnStmt = null;
	ResultSet sessOnRs = null;
	
	sessOnStmt = conn.prepareStatement(sessOnSql);
	System.out.println("sessOnStmt : " + sessOnStmt);
	
	sessOnRs = sessOnStmt.executeQuery();

	// 요청값 분석
	String menu = request.getParameter("menu");
	String lunchDate = request.getParameter("lunchDate");
	System.out.println("menu : " + menu);
	System.out.println("lunchDate : " + lunchDate);
	
	String voteMenuSql = "INSERT INTO lunch(lunch_date, menu, update_date, create_date) VALUES(?, ?, NOW(), NOW())";
	PreparedStatement voteMenuStmt = null;
	voteMenuStmt = conn.prepareStatement(voteMenuSql);
	voteMenuStmt.setString(1, lunchDate);
	voteMenuStmt.setString(2, menu);
	System.out.println("voteMenuStmt : " + voteMenuStmt);
	
	int row = voteMenuStmt.executeUpdate();
	if(row==1){
		response.sendRedirect("/diary/statsLunch.jsp");
		System.out.println("투표 성공");
	}else{
		response.sendRedirect("/diary/form/voteLunchForm.jsp");
		System.out.println("투표 실패");
	}
	
%>