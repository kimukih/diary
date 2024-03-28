<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	// 총 문제 수
	int totalQ = 23;
	
	// 맞은 문제 수
	int correctA = 0;
	
	// 각 문제의 정답
	String ooooA = "x";
	String oootA = "o";
	String ooothA = "o";
	String ooofA = "o";
	
	int ootoA = 3;
	
	String otooA = "o";
	String ototA = "o";
	String otothA = "x";
	String otofA = "o";
	
	int othoA = 2134;
	
	String othtoA = "o";
	String othttA = "o";
	String othtthA = "x";
	String othtfA = "o";
	
	String oththoA = "o";
	String oththtA = "o";
	String othththA = "x";
	String oththfA = "o";
	
	String othfoA = "o";
	String othftA = "o";
	String othfthA = "x";
	String othffA = "o";
	
	String[] othfiA = {"3", "4"};
	
	// 1-1장 1번 문제
	String oooo = request.getParameter("oooo");
	String ooot = request.getParameter("ooot");
	String oooth = request.getParameter("oooth");
	String ooof = request.getParameter("ooof");
	
	System.out.println("oooo");
	System.out.println("ooot");
	System.out.println("oooth");
	System.out.println("ooof");
	
	// 1-1장 2번 문제
	int ooto = Integer.parseInt(request.getParameter("ooto"));
	System.out.println("ooto");
	
	// 1-2장 1번 문제
	String otoo = request.getParameter("otoo");
	String otot = request.getParameter("otot");
	String ototh = request.getParameter("ototh");
	String otof = request.getParameter("otof");
	
	System.out.println("otoo");
	System.out.println("otot");
	System.out.println("ototh");
	System.out.println("otof");
	
	// 1-3장 1번 문제
	int otho = Integer.parseInt(request.getParameter("otho"));
	System.out.println("otho");
	
	// 1-3장 2번 문제
	String othto = request.getParameter("othto");
	String othtt = request.getParameter("othtt");
	String othtth = request.getParameter("othtth");
	String othtf = request.getParameter("othtf");
	
	System.out.println("othto");
	System.out.println("othtt");
	System.out.println("othtth");
	System.out.println("othtf");
	
	// 1-3장 3번 문제
	String oththo = request.getParameter("oththo");
	String oththt = request.getParameter("oththt");
	String oththth = request.getParameter("oththth");
	String oththf = request.getParameter("oththf");
	
	System.out.println("oththo");
	System.out.println("oththt");
	System.out.println("oththth");
	System.out.println("oththf");
	
	// 1-3장 4번 문제
	String othfo = request.getParameter("othfo");
	String othft = request.getParameter("othft");
	String othfth = request.getParameter("othfth");
	String othff = request.getParameter("othff");
	
	System.out.println("othfo");
	System.out.println("othft");
	System.out.println("othfth");
	System.out.println("othff");
	
	// 1-3장 5번 문제
	String[] othfi = request.getParameterValues("othfi");
	System.out.println(Arrays.toString(othfi));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>채점 결과</h1>
	총 문제 수 : <%=totalQ%> 문제
	<br>
	<br> 1-1장 1번 문제
	<br>
	<%
	if(oooo.equals(ooooA)){
		correctA += 1;
	%>
		1 : 정답
	<%
	}else{
	%>
		1 : 오답
	<%
	}
	
	if(ooot.equals(oootA)){
		correctA += 1;
	%>
		2 : 정답
	<%
	}else{
	%>
		2 : 오답
	<%
	}
	
	if(oooth.equals(ooothA)){
		correctA += 1;
	%>
		3 : 정답
	<%
	}else{
	%>
		3 : 오답
	<%
	}
	
	if(ooof.equals(ooofA)){
		correctA += 1;
	%>
		4 : 정답
	<%
	}else{
	%>
		4 : 오답
	<%
	}
	%>
	<br>
	<br> 1-1장 2번 문제
	<br>
	<%
	if(ooto == ootoA){
		correctA += 1;
	%>
		1 : 정답
	<%
	}else{
	%>
		1 : 오답
	<%
	}
	%>
	<br>
	<br> 1-2장 1번 문제
	<br>
	<%
	if(otoo.equals(otooA)){
		correctA += 1;
	%>
		1 : 정답
	<%
	}else{
	%>
		1 : 오답
	<%
	}
	
	if(otot.equals(ototA)){
		correctA += 1;
		%>
		2 : 정답
	<%
	}else{
		%>
		2 : 오답
	<%
	}
	
	if(ototh.equals(otothA)){
		correctA += 1;
		%>
		3 : 정답
	<%
	}else{
		%>
		3 : 오답
	<%
	}
	
	if(otof.equals(otofA)){
		correctA += 1;
		%>
		4 : 정답
	<%
	}else{
		%>
		4 : 오답
	<%
	}
		%>
	<br>
	<br> 1-3장 1번 문제
	<br>
	<%
	if(otho == othoA){
		correctA += 1;
	%>
		1. 정답
	<%
	}else{
	%>
		1. 오답
	<%
	}
	%>
	<br>
	<br> 1-3장 2번 문제
	<br>
	<%
	if(othto.equals(othtoA)){
		correctA += 1;
		%>
		1. 정답
	<%
	}else{
		%>
		1. 오답
	<%
	}
	
	if(othtt.equals(othttA)){
		correctA += 1;
		%>
		2. 정답
	<%
	}else{
		%>
		2. 오답
	<%
	}
	
	if(othtth.equals(othtthA)){
		correctA += 1;
		%>
		3. 정답
	<%
	}else{
		%>
		3. 오답
	<%
	}
	
	if(othtf.equals(othtfA)){
		correctA += 1;
		%>
		4. 정답
	<%
	}else{
		%>
		4. 오답
	<%
	}
		%>
	<br>
	<br> 1-3장 3번 문제
	<br>
	<%
	if(oththo.equals(oththoA)){
		correctA += 1;
		%>
		1. 정답
	<%
	}else{
		%>
		1. 오답
	<%
	}
	
	if(oththt.equals(oththtA)){
		correctA += 1;
		%>
		2. 정답
	<%
	}else{
		%>
		2. 오답
	<%
	}
	
	if(oththth.equals(othththA)){
		correctA += 1;
		%>
		3. 정답
	<%
	}else{
		%>
		3. 오답
	<%
	}
	
	if(oththf.equals(oththfA)){
		correctA += 1;
		%>
		4. 정답
	<%
	}else{
		%>
		4. 오답
	<%
	}
		%>
	<br>
	<br> 1-3장 4번 문제
	<br>
	<%
	if(othfo.equals(othfoA)){
		correctA += 1;
		%>
		1. 정답
	<%
	}else{
		%>
		1. 오답
	<%
	}
	
	if(othft.equals(othftA)){
		correctA += 1;
		%>
		2. 정답
	<%
	}else{
		%>
		2. 오답
	<%
	}
	
	if(othfth.equals(othfthA)){
		correctA += 1;
		%>
		3. 정답
	<%
	}else{
		%>
		3. 오답
	<%
	}
	
	if(othff.equals(othffA)){
		correctA += 1;
		%>
		4. 정답
	<%
	}else{
		%>
		4. 오답
	<%
	}
		%>
	<br>
	<br> 1-3장 5번 문제
	<br>
	<%
	if(Arrays.equals(othfi, othfiA)){
		correctA += 1;
		%>
		1. 정답
	<%
	}else{
		%>
		1. 오답
	<%
	}
	%>
	<br>
	<br> 맞은 문제 수 : <%=correctA%> 문제
</body>
</html>