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

	String sql = "INSERT INTO diary(diary_date, title, weather, feeling, content, update_date, create_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
	PreparedStatement stmt = null;
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, title);
	stmt.setString(3, weather);
	stmt.setString(4, feeling);
	stmt.setString(5, content);
	System.out.println("stmt : " + stmt);
	
	int row = stmt.executeUpdate();
	
	if(row==1){
		System.out.println("일기 쓰기 성공");
		response.sendRedirect("/diary/diary.jsp");
	}else{
		System.out.println("일기 쓰기 실패");
		response.sendRedirect("/diary/addDiaryAction.jsp");
	}
%>