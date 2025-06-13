<%@ page import="java.io.*, java.nio.charset.StandardCharsets, jakarta.servlet.http.Part" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

	String uploadPath = getServletContext().getRealPath("/resources/upload");
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs(); // 폴더 없으면 생성

   
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String writer = request.getParameter("writer");
    String filename = "";

    try {
        //파일 처리
        Part filePart = request.getPart("uploadFile");
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = filePart.getSubmittedFileName();
            filename = System.currentTimeMillis() + "_" + submittedFileName;
            filePart.write(uploadPath + File.separator + filename);
        }

        //DTO 저장
        BoardPostDTO post = new BoardPostDTO();
        post.setBoardType("RESOURCE");
        post.setTitle(title);
        post.setWriterId(writer);
        post.setContent(content);
        post.setFilename(filename);

        new BoardPostDAO().insertPost(post);
%>
<script>
    if (confirm("자료가 정상적으로 등록되었습니다!")) {
        location.href = "resourceboard.jsp";
    } else {
        history.back();
    }
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
<script>
    alert("자료 등록 중 오류가 발생했습니다.");
    history.back();
</script>
<% } %>
