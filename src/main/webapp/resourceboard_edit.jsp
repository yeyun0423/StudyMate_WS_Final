<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(postId);
    String loginUserId = (String) session.getAttribute("userId");

    if (post == null || !"RESOURCE".equals(post.getBoardType()) || !loginUserId.equals(post.getWriterId())) {
        response.sendRedirect("resourceboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>자료실 글 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 class="fw-bold mb-4">✏ 자료실 글 수정</h3>

    <form action="resourceboard_update.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= post.getPostId() %>">
        <input type="hidden" name="oldFilename" value="<%= post.getFilename() %>">

        <div class="mb-3">
            <label class="form-label fw-bold">제목</label>
            <input type="text" name="title" class="form-control" value="<%= post.getTitle() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">내용</label>
            <textarea name="content" class="form-control" rows="8" required><%= post.getContent() %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">기존 첨부파일</label><br>
            <% if (post.getFilename() != null && !post.getFilename().isEmpty()) { %>
                <a href="upload/<%= post.getFilename() %>" download><%= post.getFilename().substring(post.getFilename().indexOf("_") + 1) %></a>
            <% } else { %>
                없음
            <% } %>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">새 첨부파일 (선택)</label>
            <input type="file" name="uploadFile" class="form-control">
        </div>

        <div class="text-end">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="resourceboard.jsp" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>
</body>
</html>
