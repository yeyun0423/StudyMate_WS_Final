<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postsPerPage = 5;
    int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

    BoardPostDAO dao = new BoardPostDAO();
    int totalPosts = dao.getFreePostCount();
    int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

    List<BoardPostDTO> posts = dao.getFreePostsByPage(currentPage, postsPerPage);
%>
<html>
<head>
    <title>자유게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 id="freeboardTitle" class="fw-bold mb-4">📋 자유게시판</h3>

    <% for (BoardPostDTO post : posts) { %>
    <div class="post-row">
        <div class="circle-profile">
            <%= post.getWriterName().substring(0, 1) %>
        </div>
        <div class="post-info">
            <strong>
            <a href="freeboard_view.jsp?id=<%= post.getPostId() %>" class="text-dark text-decoration-none">
            <%= post.getTitle() %></a></strong>
            <%= post.getWriterName() %>
        </div>
        <div class="post-date">
            <%= post.getCreatedAt().toString().substring(0, 10) %>
        </div>
    </div>
    <% } %>

    <!-- ✅ 페이징 영역 -->
    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                <a class="page-link" id="btnPrev" href="freeboard.jsp?page=<%= currentPage - 1 %>">이전</a>
            </li>
            <% for (int i = 1; i <= totalPages; i++) { %>
                <li class="page-item <%= currentPage == i ? "active" : "" %>">
                    <a class="page-link" href="freeboard.jsp?page=<%= i %>"><%= i %></a>
                </li>
            <% } %>
            <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                <a class="page-link" id="btnNext" href="freeboard.jsp?page=<%= currentPage + 1 %>">다음</a>
            </li>
        </ul>
    </nav>

    <!-- 글쓰기 버튼 -->
    <form action="freeboard_write.jsp" method="get" class="text-end mt-4">
        <button id="btnWrite" type="submit" class="btn btn-primary">글쓰기</button>
    </form>
</div>
<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
