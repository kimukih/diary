<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>혼자 공부하는 자바</h1>
	<h1>1장 OX 퀴즈</h1>
	<form method="post" action="/diary/honjavaAction.jsp">
		1-1장 1번 문제 : <br>
		1. 소스 파일이란 컴퓨터가 이해하는 기계어로 구성된 파일이다. 
		<input type="radio" name="oooo" value="o">O
		<input type="radio" name="oooo" value="x">X
		<br>
		2. 자바 언어로 프로그램을 개발하기 위해서는 JDK를 설치해야 한다.
		<input type="radio" name="ooot" value="o">O
		<input type="radio" name="ooot" value="x">X
		<br>
		3. JDK가 설치되면 기본적으로 C:\Program Files\Java 폴더가 생성된다.
		<input type="radio" name="oooth" value="o">O
		<input type="radio" name="oooth" value="x">X
		<br>
		4. 자바 컴파일러와 실행 명령어는 JDK 설치 폴더\bin 폴더에 있다.
		<input type="radio" name="ooof" value="o">O
		<input type="radio" name="ooof" value="x">X
		<br>
		<br><br>
		
		1-1장 2번 문제<br>
		JDK 설치 폴더 안의 bin 폴더를 Path 환경 변수에 등록하는 이유는 무엇입니까?<br>
		<input type="radio" name="ooto" value="1">
		1. 자동 부팅을 하기 위해
		<br>
		<input type="radio" name="ooto" value="2">
		2. 자동 업데이트를 하기 위해
		<br>
		<input type="radio" name="ooto" value="3">
		3. 다른 경로에서 bin 폴더 안에 있는 명령어를 사용할 수 있도록 하기 위해
		<br>
		<input type="radio" name="ooto" value="4">
		4. 컴파일한 바이트 코드를 저장하기 위해
		<br>
		<br><br>
		
		1-2장 1번 문제 : <br>
		1. 이클립스는 무료이며 통합 개발 환경(IDE)을 제공한다.
		<input type="radio" name="otoo" value="o">O
		<input type="radio" name="otoo" value="x">X
		<br>
		2. 이클립스를 실행할 때에는 워크스페이스를 지정해야 한다.<input type="radio" name="otot" value="o">O
		<input type="radio" name="otot" value="x">X
		<br>
		3. 이클립스는 자바 프로그램만 개발할 수 있다.<input type="radio" name="ototh" value="o">O
		<input type="radio" name="ototh" value="x">X
		<br>
		4. 퍼스펙티브는 뷰들을 미리 묶어 이름을 붙여 놓은 것이다.<input type="radio" name="otof" value="o">O
		<input type="radio" name="otof" value="x">X
		<br>
		<br><br>
		
		1-3장 1번 문제<br>
		자바 프로그램 개발 과정을 순서대로 적어보세요.<br>
		<ol start="1">
			<li>javac 명령어로 컴파일한다.</li>
			<li>소스파일(~.java)을 작성한다</li>
			<li>java 명령어로 실행한다.</li>
			<li>실행결과를 확인한다.</li>
	 	</ol>
		<input type="text" name="otho">
		<br>
		<br><br>
		
		1-3장 2번 문제 : <br>
		1. 컴파일하면 '클래스이름. class 라는 바이트 코드 파일이 생성된다. 
		<input type="radio" name="othto" value="o">O
		<input type="radio" name="othto" value="x">X
		<br>
		2. main() 메소드는 반드시 클래스 블록 내부에서 작성해야 한다.
		<input type="radio" name="othtt" value="o">O
		<input type="radio" name="othtt" value="x">X
		<br>
		3. main() 메소드를 작성할 때 중괄호 블록을 만들지 않아도 된다.
		<input type="radio" name="othtth" value="o">O
		<input type="radio" name="othtth" value="x">X
		<br>
		4. 컴파일 후 실행을 하려면 반드시 main() 메소드가 있어야 한다.
		<input type="radio" name="othtf" value="o">O
		<input type="radio" name="othtf" value="x">X
		<br>
		<br><br>
		
		1-3장 3번 문제 : <br>
		1. //뒤의 라인 내용은 모두 주석이 된다.
		<input type="radio" name="oththo" value="o">O
		<input type="radio" name="oththo" value="x">X
		<br>
		2. /*부터 시작해서 */까지 모든 내용이 주석이 된다.
		<input type="radio" name="oththt" value="o">O
		<input type="radio" name="oththt" value="x">X
		<br>
		3. 주석이 많으면 바이트 코드 파일의 크기가 커지므로 꼭 필요할 경우에만 작성한다.
		<input type="radio" name="oththth" value="o">O
		<input type="radio" name="oththth" value="x">X
		<br>
		4. 문자열 안에는 주석을 만들 수 없다.
		<input type="radio" name="oththf" value="o">O
		<input type="radio" name="oththf" value="x">X
		<br>
		<br><br>
		
		1-3장 4번 문제 : <br>
		1. 기본적으로 소스 파일과 바이트 코드 파일이 저장되는 풀더가 다르다. 
		<input type="radio" name="othfo" value="o">O
		<input type="radio" name="othfo" value="x">X
		<br>
		2. 자바 소스 파일을 작성하는 폴더는 src이다.
		<input type="radio" name="othft" value="o">O
		<input type="radio" name="othft" value="x">X
		<br>
		3. 선언되는 클래스 이름은 소스 파일 이름과 달라도 상관없다.
		<input type="radio" name="othfth" value="o">O
		<input type="radio" name="othfth" value="x">X
		<br>
		4. 올바르게 작성된 소스 파일을 저장하면 자동으로 컴파일되고, 바이트 코드 파일이 생성된다. 
		<input type="radio" name="othff" value="o">O
		<input type="radio" name="othff" value="x">X
		<br>
		<br><br>
		
		1-3장 5번 문제<br>
		이클립스에서 바이트 코드 파일을 실행하는 방법 모두 선택해보세요.<br>
		<input type="checkbox" name="othfi" value="1">Package Explorer 뷰에서 소스 파일을 더블클릭한다.
		<br>
		<input type="checkbox" name="othfi" value="2">Package Explorer 뷰에서 바이트 코드 파일을 선택하고, 툴 바에서 Run 아이곤을 클릭한다
		<br>
		<input type="checkbox" name="othfi" value="3">Package Explorer 뷰에서 소스 파일을 선택하고, 툴 바에서 Run 아이콘을 클릭한다.
		<br>
		<input type="checkbox" name="othfi" value="4">Package Explorer 뷰에서 소스 파일을 선택하고, 마우스 오른쪽 버튼을 클릭한 후 <br>[]Run As] - [Java Application)을 선택한다.
		<br>
		<br><br>
		
		<button type="submit">답안제출</button>
	</form>
</body>
</html>