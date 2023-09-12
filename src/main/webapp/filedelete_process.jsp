<%@page import="fileUpload.MyFileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
	MyFileDAO dao = new MyFileDAO();
	int result = dao.deleteFile(idx);
	dao.close();
	if (result == 1) {
%>
		<script>
			alert("게시글이 삭제되었습니다.");
			location.replace("filelist.jsp")
		</script>
<%
	} else {
%>
		<script>
			alert("게시글 삭제를 실패하였습니다.");
			location.replace("filelist.jsp")
		</script>
	<%
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>