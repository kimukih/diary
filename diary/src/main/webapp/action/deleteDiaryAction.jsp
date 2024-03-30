<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String title = request.getParameter("title");
	String diaryDate = request.getParameter("diaryDate");
	System.out.println("title : " + title);
	System.out.println("diaryDate : " + diaryDate);

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql = "DELETE FROM diary WHERE diary_date = ?";
	PreparedStatement stmt = null;
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	System.out.println("stmt : " + stmt);
	
	int row = stmt.executeUpdate();
	
	if(row==1){
		System.out.println("일기 삭제 성공");
		response.sendRedirect("/diary/diary.jsp");
	}else{
		System.out.println("일기 삭제 실패");
		response.sendRedirect("/diary/form/deleteDiaryForm.jsp?diaryDate=" + diaryDate);
	}
%>