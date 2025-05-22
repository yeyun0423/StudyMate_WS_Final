<%@ page import="java.io.*, java.nio.charset.StandardCharsets, jakarta.servlet.http.Part" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String uploadPath = application.getRealPath("/upload"); // 실제 서버 경로
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs(); // 폴더 없으면 생성

    String title = "", content = "", writer = "", filename = "";

    try {
        Part titlePart = request.getPart("title");
        if (titlePart != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(titlePart.getInputStream(), StandardCharsets.UTF_8));
            title = reader.readLine();
        }

        Part contentPart = request.getPart("content");
        if (contentPart != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(contentPart.getInputStream(), StandardCharsets.UTF_8));
            content = reader.readLine();
        }

        Part writerPart = request.getPart("writer");
        if (writerPart != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(writerPart.getInputStream(), StandardCharsets.UTF_8));
            writer = reader.readLine();
        }

        Part filePart = request.getPart("uploadFile");
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = filePart.getSubmittedFileName();
            filename = System.currentTimeMillis() + "_" + submittedFileName;
            filePart.write(uploadPath + File.separator + filename);
        }

        // DTO에 저장
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
