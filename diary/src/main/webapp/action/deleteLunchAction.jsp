<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 요청값 분석
	String lunchDate = request.getParameter("lunchDate");
	System.out.println("lunchDate : " + lunchDate);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String deleteLunchSql = "DELETE FROM lunch WHERE lunch_date = ?";
	PreparedStatement deleteLunchStmt = null;
	
	deleteLunchStmt = conn.prepareStatement(deleteLunchSql);
	deleteLunchStmt.setString(1, lunchDate);
	System.out.println("deleteLunchStmt : " + deleteLunchStmt);
	
	int row = deleteLunchStmt.executeUpdate();
	if(row == 1){
		System.out.println("메뉴 삭제 성공");
		response.sendRedirect("/diary/statsLunch.jsp");
	}else{
		System.out.println("메뉴 삭제 실패");
		response.sendRedirect("/diary/statsLunch.jsp");
	}
%>