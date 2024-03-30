<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String checkDate = request.getParameter("checkDate");

	String sql1 = "SELECT my_session mySession FROM login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	System.out.println("stmt1 : " + stmt1);
	
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	
	String sql2 = "SELECT diary_date AS diaryDate FROM diary WHERE diary_date = ?";
	// 결과값이 이미 있으면 그 날짜에는 더 이상 일기를 입력할 수 없음
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	System.out.println("stmt2 : " + stmt2);
	
	rs2 = stmt2.executeQuery();

	if(rs2.next()){
		// 일기 작성 불가
		response.sendRedirect("/diary/form/addDiaryForm.jsp?checkDate=" + checkDate + "&ck=disable");
	}else{
		// 일기 작성 가능
		response.sendRedirect("/diary/form/addDiaryForm.jsp?checkDate=" + checkDate + "&ck=able");
	}
%>