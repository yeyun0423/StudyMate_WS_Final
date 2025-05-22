<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, java.io.*, jakarta.servlet.http.Part, java.nio.charset.StandardCharsets" %>
<%
    request.setCharacterEncoding("UTF-8");

    int id = Integer.parseInt(request.getParameter("id"));
    String oldFilename = request.getParameter("oldFilename");

    String title = "", content = "", filename = oldFilename;

    try {
        // 제목
        Part titlePart = request.getPart("title");
        if (titlePart != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(titlePart.getInputStream(), StandardCharsets.UTF_8));
            title = reader.readLine();
        }

        // 내용
        Part contentPart = request.getPart("content");
        if (contentPart != null) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(contentPart.getInputStream(), StandardCharsets.UTF_8));
            content = reader.readLine();
        }

        // 새 첨부파일이 있는 경우
        Part filePart = request.getPart("uploadFile");
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = filePart.getSubmittedFileName();
            filename = System.currentTimeMillis() + "_" + submittedFileName;

            String uploadPath = application.getRealPath("/upload");
            filePart.write(uploadPath + File.separator + filename);
        }

        new BoardPostDAO().updatePost(id, title, content, filename);
        response.sendRedirect("resourceboard_view.jsp?id=" + id);

    } catch (Exception e) {
        e.printStackTrace();
%>
<script>
    alert("수정 중 오류가 발생했습니다.");
    history.back();
</script>
<% } %>
