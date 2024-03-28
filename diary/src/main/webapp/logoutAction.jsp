<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 요청값 분석하기
	String mySession = request.getParameter("mySession");
	System.out.println("mySession : " + mySession);
	
	// 로그아웃 구현
	// mysession이 ON 상태일때 로그아웃 버튼을 누르면
	// mysession을 OFF로 바꾸고 loginForm.jsp로 재요청
	// 로그아웃이 진행된 날짜를 off_date에 저장

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// 로그아웃 완료되면 off_date에 현재 날짜를 DB에 넣는 코드
	if(mySession.equals("ON")){
		String offDateSql = "UPDATE login SET my_session = 'OFF', off_date = NOW()";
		PreparedStatement offDateStmt = null;
				
		offDateStmt = conn.prepareStatement(offDateSql);
		offDateStmt.setString(1, mySession);
		
		System.out.println("offDateStmt : " + offDateStmt);
	
		int offDateRow = offDateStmt.executeUpdate();
		if(offDateRow==1){
			System.out.println("현재 날짜 저장 성공");
			response.sendRedirect("./loginForm.jsp");
		}else{
			System.out.println("현재 날짜 저장 실패");
		}
	}
%>