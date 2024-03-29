<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 요청값 분석
	String checkDate = request.getParameter("checkDate");
	System.out.println("checkDate : " + checkDate);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	String sql = "SELECT lunch_date lunchDate FROM lunch WHERE lunch_date = ?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, checkDate);
	
	rs = stmt.executeQuery();
	
	if(rs.next()){
		String msg = URLEncoder.encode("이미 투표를 완료한 날짜입니다.", "utf-8");
		response.sendRedirect("/diary/voteLunchForm.jsp?msg=" + msg);
	}else{
		String msg = URLEncoder.encode("투표 가능한 날짜입니다.", "utf-8");
		response.sendRedirect("/diary/voteLunchForm.jsp?lunchDate=" + checkDate + "&msg=" + msg);
	}
%>