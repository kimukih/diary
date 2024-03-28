<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//로그인 인증 분기코드
	// 모든 페이지에 들어갈 코드
	// 로그인 상태가 ON 인지 OFF 인지
	// diary.login.my_session => 'OFF' => Redirect("loginForm.jsp");
	// diary.login.my_session => 'ON' => Redirect("diary.jsp");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql = "SELECT my_session AS mySession FROM login";
	PreparedStatement stmt = null;
	ResultSet rs = null;

	stmt = conn.prepareStatement(sql);
	System.out.println("stmt : " + stmt);
	
	rs = stmt.executeQuery();
	
	String mySession = null;
	if(rs.next()){
		mySession = rs.getString("mySession");
	}
	
	if(mySession.equals("ON")) {
		response.sendRedirect("/diary/loginForm.jsp");
		rs.close(); // 자원반납
		stmt.close();
		conn.close();
		return; 	// 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	
	// 1. 요청값 분석하기
	String loginId = request.getParameter("loginId");
	String loginPw = request.getParameter("loginPw");
	System.out.println("loginId : " + loginId);
	System.out.println("loginPw : " + loginPw);
	
	String sql2 = "SELECT member_id AS memberId, member_pw AS memberPw FROM member WHERE member_id = ? AND member_pw = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;

	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, loginId);
	stmt2.setString(2, loginPw);
	System.out.println("stmt2 : " + stmt2);

	rs2 = stmt2.executeQuery();
	
	String sql3 = "UPDATE login SET my_session = 'ON'";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	
	if(rs2.next()){
		// 로그인 성공
		// loginForm.jsp 에서 받아온 요청값 Id, Pw와
		// DB에 저장되어 있는 Id, Pw값이 일치하는지 확인
		// DB my_session을 ON으로 변경 후 diary 페이지로 요청	
		System.out.println("로그인 성공");
		stmt3 = conn.prepareStatement(sql3);
		System.out.println("stmt3 : " + stmt3);
		
		rs3 = stmt3.executeQuery();
			if(rs3.next()){
				System.out.println("로그인 상태가 ON이 되었습니다.");
			}
		response.sendRedirect("/diary/diary.jsp?memberId=" + loginId);
	}else{
		// 로그인 실패
		String errMsg = URLEncoder.encode("로그인 실패, 아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" + errMsg); // 에러메시지 출력
	}
%>