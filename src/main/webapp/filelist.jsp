<%@page import="fileUpload.MyFileDTO"%>
<%@page import="java.util.List"%>
<%@page import="fileUpload.MyFileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>DB에 등록된 파일 목록 보기</h2>
	<a href="fileUpload.jsp">파일 등록하기</a> 
	<%
		MyFileDAO dao = new MyFileDAO();
		List<MyFileDTO> fileList = dao.myfilelist();
		dao.close();
		String saveD = application.getRealPath("/uploads");
	%>
	
	<table border="1">
	 	<tr>
	 		<td>번호</td>
	 		<td>작성자</td>
	 		<td>제목</td>
	 		<td>카테고리</td>
	 		<td>원본파일명</td>
	 		<td>저장된파일명</td>
	 		<td>이미지</td>
	 		<td>작성일</td>
	 	</tr>
	 	<% for(MyFileDTO f: fileList) {
	 	%>
	 		<tr>
		 		<td><%= f.getIdx() %></td>
		 		<td><%= f.getName() %></td>
		 		<td><a href="fileView.jsp?idx=<%= f.getIdx()%>"><%= f.getTitle() %></a></td>
		 		<td><%= f.getCate() %></td>
		 		<td><%= f.getOfile() %></td>
		 		<td><%= f.getSfile() %></td>
		 		<td><a href="fileView.jsp?idx=<%= f.getIdx()%>"><img src="./uploads/<%=f.getSfile()%>" width="100"></a></td>
		 		<td><%= f.getPostdate() %></td>
	 		</tr>
	 	<% 
	 	}%>
	</table>
</body>
</html>