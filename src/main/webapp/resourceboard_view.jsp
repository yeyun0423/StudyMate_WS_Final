<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(postId);

    String loginUserId = (String) session.getAttribute("userId");

    if (post == null || !"RESOURCE".equals(post.getBoardType())) {
        response.sendRedirect("resourceboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>자료실 글 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>


    <h3 id="resourceViewTitle" class="fw-bold mb-4">📚 자료실</h3>

    <div class="fw-bold mb-3">
        <label id="labelResourceTitle" class="form-label">제목</label>
        <p class="form-control"><%= post.getTitle() %></p>
    </div>

    <div class="fw-bold mb-3">
        <label id="labelResourceWriter" class="form-label">작성자</label>
        <p class="form-control" id="resourceWriterName"><%= post.getWriterName() %></p>
    </div>

    <div class="fw-bold mb-3">
        <label id="labelResourceFile" class="form-label">첨부파일</label>
        <p class="form-control" id="resourceFileArea">
            <% if (post.getFilename() != null && !post.getFilename().isEmpty()) { %>
                <a id="resourceFileLink" href="upload/<%= post.getFilename() %>" download>
                    <%= post.getFilename().substring(post.getFilename().indexOf("_") + 1) %>
                </a>
            <% } else { %>
                <span id="noFileText">첨부파일 없음</span>
            <% } %>
        </p>
    </div>

    <div class="mb-3">
        <label id="labelResourceContent" class="form-label fw-bold">내용</label>
        <p class="form-control text-start" style="min-height: 200px; margin: 0; line-height: 1.4;"><%= post.getContent().trim() %></p>
    </div>

    <div class="d-flex justify-content-between mt-4">
        <a id="btnBack" href="resourceboard.jsp" class="btn btn-secondary">목록으로</a>

        <% if (loginUserId != null && loginUserId.equals(post.getWriterId())) { %>
            <div class="d-flex gap-2">
                <form action="resourceboard_edit.jsp" method="get">
                    <input type="hidden" name="id" value="<%= post.getPostId() %>">
                    <button id="btnEdit" type="submit" class="btn btn-warning btn-sm">수정</button>
                </form>
                <form action="resourceboard_delete.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="id" value="<%= post.getPostId() %>">
                    <button id="btnDelete" type="submit" class="btn btn-danger btn-sm">삭제</button>
                </form>
            </div>
        <% } %>
    </div>
</div>

<script>
    const USER_ID = "<%= session.getAttribute("userId") %>";
    const USER_NAME = "<%= session.getAttribute("userName") %>";
</script>
<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
