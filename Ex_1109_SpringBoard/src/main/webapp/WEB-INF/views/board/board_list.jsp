<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			a{text-decoration:none;}
			table{border-collapse:collapse;}
		</style>
	</head>
	<body>
		<table border="1" width="700">
			<tr>
				<td colspan="5"><img src="resources/img/title_04.gif"></td>
			</tr>
			<tr>
				<th>번호</th>
				<th width="400">제목</th>
				<th width="70">작성자</th>
				<th width="100">작성일자</th>
				<th width="50">조회수</th>
			</tr>
			<c:forEach var="vo" items="${list}">
			<tr>
				<td align="center">${vo.idx}</td>
				<!-- 댓글일 경우에는 들여쓰기 -->
				<td>
					<c:forEach begin="1" end="${vo.depth}">&nbsp;</c:forEach>
					<!-- 댓글기호 -->
					<c:if test="${vo.depth ne 0 }">ㄴ</c:if>
					
					<c:if test="${vo.del_info ne -1 }">
					<a href="view.do?idx=${vo.idx}&page=${param.page}">
						<font color="black"> ${vo.subject}</font>
					</a>
					</c:if>
					
					<!-- 삭제된 게시물은 클릭할 수 없도록 처리 -->
					<c:if test="${vo.del_info eq -1 }">
						<font color="gray"> ${vo.subject}</font>
					</c:if>
					
				</td>
				<td>${vo.name}</td>
				
				<!-- 삭제가 되지 않은 게시물은 정상적으로 표시 -->
				<c:if test="${vo.del_info ne -1}">
				<td>${fn:split(vo.regidate,' ')[0]}</td>
				</c:if>
				
				<!-- 삭제가 된 게시물은 unknown으로 표시 -->
				<c:if test="${vo.del_info eq -1}">
				<td>unknown</td>
				</c:if>
				
				<td align="center">${vo.readhit}</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="5" align="center"> 
					${pageMenu}
				</td>
			</tr>
			<tr>
				<td colspan="5" align="right">
					<img src="resources/img/btn_reg.gif" onclick="location.href='insert_form.do'"
					 style="cursor:pointer;">
				</td>
			</tr>
		</table>
	</body>
</html>








