<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String memo = request.getParameter("memo");
	String diaryDate = request.getParameter("diaryDate");

	System.out.println("memo : " + memo);
	System.out.println("diaryDate : " + diaryDate);

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql = "INSERT INTO comment(diary_date, memo, update_date, create_date) VALUES(?, ?, NOW(), NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, memo);
	System.out.println("stmt : " + stmt);
	
	int row = stmt.executeUpdate();
	if(row == 1){
		System.out.println("댓글 추가 성공");
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
	}else{
		System.out.println("댓글 추가 실패");
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
	}
%>