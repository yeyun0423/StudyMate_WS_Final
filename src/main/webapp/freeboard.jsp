<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String search = request.getParameter("search");
    int postsPerPage = 5;
    int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

    BoardPostDAO dao = new BoardPostDAO();
    List<BoardPostDTO> posts = (search == null || search.trim().isEmpty()) ?
        dao.getFreePostsByPage(currentPage, postsPerPage) :
        dao.searchFreePostsByPage(search, currentPage, postsPerPage);

    int totalPosts = (search == null || search.trim().isEmpty()) ?
        dao.getFreePostCount() : dao.getSearchFreePostCount(search);

    int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자유게시판</title>
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
      * { font-family: 'SUIT', sans-serif; }
        body { background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff); }
        .section-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }
        .post-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 0;
            border-bottom: 1px solid #eee;
        }
        .circle-profile {
            width: 40px;
            height: 40px;
            background-color: #4f46e5;
            color: white;
            font-weight: bold;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            flex-shrink: 0;
        }
        .post-info {
            flex-grow: 1;
        }
        .post-date {
            color: #888;
            font-size: 0.875rem;
            white-space: nowrap;
            text-align: right;
        }
        .btn-primary {
            background-color: #4f46e5;
            border: none;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .pagination .page-link {
            border-radius: 10px;
            color: #4f46e5;
        }
        .pagination .active .page-link {
            background-color: #4f46e5;
            color: white;
            border: none;
        }
    </style>
 
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-4">📋 자유게시판</h3>

        <!-- 검색창 + 전체 목록 보기 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <% if (search != null && !search.trim().isEmpty()) { %>
                <a href="freeboard.jsp" class="btn btn-secondary btn-sm">전체 목록 보기</a>
            <% } else { %>
                <div></div>
            <% } %>
            <form action="freeboard.jsp" method="get" class="d-flex">
                <input type="text" name="search" class="form-control me-2" style="width: 250px;" placeholder="제목 또는 작성자 검색" value="<%= search != null ? search : "" %>">
                <button class="btn btn-outline-primary btn-sm">검색</button>
            </form>
        </div>

        <% for (BoardPostDTO post : posts) { %>
        <div class="post-row">
            <div class="circle-profile">
                <%= post.getWriterName().substring(0, 1) %>
            </div>
            <div class="post-info">
                <strong>
                <a href="freeboard_view.jsp?id=<%= post.getPostId() %>" class="text-dark text-decoration-none">
                    <%= post.getTitle() %>
                </a></strong>
                <div class="text-muted small">
                    <%= post.getWriterName() %> · 댓글 <%= post.getCommentCount() %>개 · 조회수 <%= post.getViews() %>
                </div>
            </div>
            <div class="post-date">
                <%= post.getCreatedAt().toString().substring(0, 10) %>
            </div>
        </div>
        <% } %>

        <!-- 페이지네이션 -->
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <% if (currentPage > 1) { %>
                    <li class="page-item"><a class="page-link" href="freeboard.jsp?page=<%= currentPage - 1 %>&search=<%= search != null ? search : "" %>">이전</a></li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= currentPage == i ? "active" : "" %>">
                        <a class="page-link" href="freeboard.jsp?page=<%= i %>&search=<%= search != null ? search : "" %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentPage < totalPages) { %>
                    <li class="page-item"><a class="page-link" href="freeboard.jsp?page=<%= currentPage + 1 %>&search=<%= search != null ? search : "" %>">다음</a></li>
                <% } %>
            </ul>
        </nav>

        <!-- 글쓰기 버튼 -->
        <form action="freeboard_write.jsp" method="get" class="text-end mt-4">
            <button type="submit" class="btn btn-primary">글쓰기</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
