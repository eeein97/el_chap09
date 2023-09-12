<%@page import="fileUpload.MyFileDAO"%>
<%@page import="fileUpload.MyFileDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.catalina.authenticator.SavedRequest"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//getRealPath() -->  물리적경로를 리턴
    String saveDirector = application.getRealPath("/uploads");
    int maxPostsize = 3500*4500; //파일최대크기
    String encoding ="UTF-8"; //인코딩 방식
    
    try{
    	 //MultipartRequest 객체 생성
        MultipartRequest mr = new MultipartRequest(request, saveDirector, maxPostsize, encoding);
        
        //파일명 생성
        //myphoto.set.png
    	String fileName = mr.getFilesystemName("attachedFile"); //현재파일
    	String ext = fileName.substring(fileName.lastIndexOf("."));
    	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
    	String newFileName = now+ext; //업로드일시.확장자
    	
    	//파일명 변경
    	File oldFile = new File(saveDirector+File.separator+fileName);
    	File newFile = new File(saveDirector+File.separator+newFileName);
    	oldFile.renameTo(newFile); //파일이름 변경
    	
    	//다른 폼값 처리
    	String name = mr.getParameter("name");
    	String title = mr.getParameter("title");
    	String idx = mr.getParameter("idx");
    	String[] cateArray = mr.getParameterValues("cate");
    	//StringBuffer 문자열을 추가하거나 변경할 때 주로 사용하는 자료형
    	//append() 문자열 추가
    	//toString() string자료형으로 리턴
    	StringBuffer cateBuf = new StringBuffer();
    	if(cateArray == null) {
    		cateBuf.append("선택 없음");
    	}else {
    		for(String s: cateArray) {
    			cateBuf.append(s+",");
    		}
    	}
    	
    	//DTO생성
    	MyFileDTO dto = new MyFileDTO();
    	dto.setName(name);
    	dto.setIdx(idx);
    	dto.setTitle(title);
    	dto.setCate(cateBuf.toString());
    	dto.setOfile(fileName);
    	dto.setSfile(newFileName);
    	
    	//DAO를 통해 데이터베이스 반영
    	MyFileDAO dao = new MyFileDAO();
		int result = dao.myfileEdit(dto);
		dao.close();
    	
    	//파일 목록 jsp로 리다이렉션
    	response.sendRedirect("filelist.jsp");
    }
    catch(Exception e){
    	e.printStackTrace();
    	request.setAttribute("erroMassage", "파일 업로드 오류");
    	request.getRequestDispatcher("fileUpload.jsp").forward(request, response);
    }

%>