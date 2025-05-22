<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String loginUserId = (String) session.getAttribute("userId");
    boolean isAdmin = false;
    Object adminAttr = session.getAttribute("isAdmin");
    if (adminAttr != null) {
        isAdmin = (Boolean) adminAttr;
    }

    int postsPerPage = 5;
    int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

    BoardPostDAO dao = new BoardPostDAO();
    int totalPosts = dao.getQnACount(); // board_type = 'Q&A'
    int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

    List<BoardPostDTO> posts = dao.getQnAByPage(currentPage, postsPerPage);
%>

<html>
<head>
    <title>Q&A 게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 class="fw-bold mb-4">❓ Q&A 게시판</h3>

    <% for (BoardPostDTO post : posts) { 
        boolean canView = !post.isPrivate() || post.getWriterId().equals(loginUserId) || isAdmin;
    %>
    <div class="post-row">
        <div class="circle-profile">
            <%= post.getWriterName().substring(0, 1) %>
        </div>
        <div class="post-info">
            <strong>
            <% if (canView) { %>
                <a href="qnaview.jsp?id=<%= post.getPostId() %>" class="text-dark text-decoration-none">
            <% } else { %>
                <a href="#" class="text-dark text-decoration-none" onclick="alert('비공개 글입니다. 작성자 또는 관리자만 열람할 수 있습니다.'); return false;">
            <% } %>
                <%= post.getTitle() %>
                <%= post.isPrivate() ? "" : "" %>
            </a></strong>
            <%= post.getWriterName() %>
        </div>
        <div class="post-date text-end">
    <span class="text-muted"><%= post.isPrivate() ? "🔒 비공개" : "🔓 공개" %></span><br>
    <%= post.getCreatedAt().toString().substring(0, 10) %>
</div>
    </div>
    <% } %>

    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                <a class="page-link" href="qnaboard.jsp?page=<%= currentPage - 1 %>">이전</a>
            </li>
            <% for (int i = 1; i <= totalPages; i++) { %>
                <li class="page-item <%= currentPage == i ? "active" : "" %>">
                    <a class="page-link" href="qnaboard.jsp?page=<%= i %>"><%= i %></a>
                </li>
            <% } %>
            <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                <a class="page-link" href="qnaboard.jsp?page=<%= currentPage + 1 %>">다음</a>
            </li>
        </ul>
    </nav>

    <form action="qnawrite.jsp" method="get" class="text-end mt-4">
        <button type="submit" class="btn btn-primary">글쓰기</button>
    </form>
</div>
<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
