<%@page import="fileUpload.MyFileDTO"%>
<%@page import="fileUpload.MyFileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String idx = request.getParameter("idx");
	MyFileDAO dao = new MyFileDAO();
	MyFileDTO dto = dao.selectView(idx);
	pageContext.setAttribute("dto", dto);
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>상세보기</h2>
<table>
	<tr>
		<td>번호<td>
		<td><%= dto.getIdx() %><td>
	</tr>
	<tr>
		<td>작성자<td>
		<td>${dto.name}<td>
	</tr>
	<tr>
		<td>등록일<td>
		<td><%= dto.getPostdate() %><td>
	</tr>
	<tr>
		<td>제목<td>
		<td><%= dto.getTitle() %><td>
	</tr>
	<tr>
		<td>내용<td>
		<td colspan="2"><img src="./uploads/<%= dto.getSfile() %>" width="300"/></td>
	</tr>
	<tr>
		<td colspan="2">
		<form metgod="post" action="fileEdit.jsp">
		<input type="hidden" name="idx" value="${dto.idx}" />
		<button type="submit">수정하기</button>
		</form>
		<form metgod="post" action="filedelete_process.jsp">
		<input type="hidden" name="idx" value="${dto.idx}" />
		<button type="submit">삭제하기</button>
		</form>
		</td>
	</tr>
</table>
</body>
</html>