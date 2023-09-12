<%@page import="fileUpload.MyFileDTO"%>
<%@page import="fileUpload.MyFileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//요철할 때 idx를 받아옴
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
<h2>수정하기</h2>
<form action="fileEdit_process.jsp" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>작성자<td>
			<td>
			<input type="hidden" name="idx" value="${dto.idx}" />
			<input type="text" name="name" value="${dto.name}" />
			<td>
		</tr>
		<tr>
			<td>제목<td>
			<td><input type="text" name="title" value="${dto.title}" /><td>
		</tr>
		<tr>
			<td>내용<td>
			<td><input type="file" name="attachedFile" required="required" /></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td>
				<input type="checkbox" name="cate" value="사진" /> 사진
				<input type="checkbox" name="cate" value="과제" /> 과제
				<input type="checkbox" name="cate" value="워드" /> 워드
				<input type="checkbox" name="cate" value="음원" /> 음원
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<button type="submit">수정하기</button>
			<button type="reset">취소</button>
			</td>
		</tr>
	</table>
</form>
<script>
	let str = "<%=dto.getCate()%>"; //사진, 과제, 워드
	let strarr = str.split(",");	//["사진","과제","워드"]
	let checks = document.querySelectorAll("input[type='checkbox']");
	checks.forEach(ch=>{
		if(strarr.includes(ch.value)) {
			ch.checked = true;
		}
	})
</script>
</body>
</html>