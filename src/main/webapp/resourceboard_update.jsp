<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, java.io.*, jakarta.servlet.http.Part" %>
<%
    request.setCharacterEncoding("UTF-8");

    int id = Integer.parseInt(request.getParameter("id"));
    String oldFilename = request.getParameter("oldFilename");

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String filename = oldFilename;

    try {
        // 파일 업로드 처리
        Part filePart = request.getPart("uploadFile");
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = filePart.getSubmittedFileName();
            filename = System.currentTimeMillis() + "_" + submittedFileName;

            // WEB-INF/upload 경로로 설정
            String uploadPath = application.getRealPath("/resources/upload");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + filename);
        }

        // DB 업데이트
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
