<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//0-1) 로그인(인증) 분기 session 사용으로 변경
	// 로그인 성공시 session에 loginMember라는 변수를 만들고 값으로 로그인 아이디를 저장
	String loginMember = (String)session.getAttribute("loginMember");
	// session.getAttribute()는 찾는 변수가 없으면 null값을 반환
	// null값이면 한번도 로그인 한적이 없는상태, null이 아니면 로그인 상태
	System.out.println("loginMember : " + loginMember);
	
	// loginForm페이지는 로그아웃 상태에서만 출력되는 페이지
	if(loginMember != null){
		response.sendRedirect("/diary/diary.jsp");
		return;	// 코드 진행을 끝내는 문법 ex) 메서드 끝낼 때 return 사용
	}
	
	// loginAction.jsp가 실행되었다? --> session loginMember가 null이다
	// session 공간에 loginMember 변수를 생성
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// 1. 요청값 분석하기 -> 로그인 성공 -> session에 loginMember 변수를 생성
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
	
	if(rs2.next()){
		// 로그인 성공
		// loginForm.jsp 에서 받아온 요청값 Id, Pw와
		// DB에 저장되어 있는 Id, Pw값이 일치하는지 확인
		// DB my_session을 ON으로 변경 후 diary 페이지로 요청	
		System.out.println("로그인 성공");
		/*
		stmt3 = conn.prepareStatement(sql3);
		System.out.println("stmt3 : " + stmt3);
		
		rs3 = stmt3.executeQuery();
			if(rs3.next()){
				System.out.println("로그인 상태가 ON이 되었습니다.");
			}
		*/
		// 로그인 성공시 DB값 변경 --> session 변수 설정
		session.setAttribute("loginMember", rs2.getString("memberId"));
		
		response.sendRedirect("/diary/diary.jsp?memberId=" + loginId);
	}else{
		// 로그인 실패
		String errMsg = URLEncoder.encode("로그인 실패, 아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/diary/form/loginForm.jsp?errMsg=" + errMsg); // 에러메시지 출력
	}
%>