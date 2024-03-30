<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String feeling = request.getParameter("feeling");
	String content = request.getParameter("content");
	
	System.out.println("diaryDate : " + diaryDate);
	System.out.println("title : " + title);
	System.out.println("weather : " + weather);
	System.out.println("feeling : " + feeling);
	System.out.println("content : " + content);

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql = "UPDATE diary SET title = ?, weather = ?, feeling = ?, content = ?, update_date = NOW() WHERE diary_date = ?";
	PreparedStatement stmt = null;
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, title);
	stmt.setString(2, weather);
	stmt.setString(3, feeling);
	stmt.setString(4, content);
	stmt.setString(5, diaryDate);
	System.out.println("stmt : " + stmt);
	
	int row = stmt.executeUpdate();
	
	if(row==1){
		System.out.println("일기 수정 성공");
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
	}else{
		System.out.println("일기 수정 실패");
		response.sendRedirect("/diary/form/updateDiaryForm.jsp?diaryDate=" + diaryDate);
	}
%>