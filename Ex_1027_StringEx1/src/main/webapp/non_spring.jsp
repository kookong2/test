<%@page import="vo.PersonVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		//기존방식
		//1. 기본생성자 + setter
		PersonVO p1 = new PersonVO();
		p1.setName("홍길동");
		p1.setAge(30);
		p1.setTel("010-1111-1111");
		
		//2. 오버로딩된 생성자 사용
		PersonVO p2 = new PersonVO("김길동" ,20, "010-2222-2222");
		
		//body에서 el로 표현하기 위해 page영역에 저장
		pageContext.setAttribute("p1", p1);
		request.setAttribute("p2", p2);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>${p1.name}/${p1.age}/${p1.tel}</p>
	<p>${p2.name}/${p2.age}/${p2.tel}</p>
</body>
</html>