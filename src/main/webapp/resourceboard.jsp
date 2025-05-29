<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postsPerPage = 5;
    int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

    BoardPostDAO dao = new BoardPostDAO();
    int totalPosts = dao.getResourcePostCount();
    int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

    List<BoardPostDTO> posts = dao.getResourcePostsByPage(currentPage, postsPerPage);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자료실</title>
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
            padding: 16px;
            border-bottom: 1px solid #eee;
        }
        .circle-profile {
            background-color: #4f46e5;
            color: white;
            font-weight: bold;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
        }
        .post-info {
            flex-grow: 1;
        }
        .post-date {
            white-space: nowrap;
            color: #888;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #4f46e5;
            border: none;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-4">📚 자료실</h3>

        <% for (BoardPostDTO post : posts) { %>
        <div class="post-row">
            <div class="d-flex align-items-center">
                <div class="circle-profile"><%= post.getWriterName().substring(0, 1) %></div>
                <div class="post-info">
                    <strong>
                    <a href="resourceboard_view.jsp?id=<%= post.getPostId() %>" class="text-dark text-decoration-none">
                    <%= post.getTitle() %></a></strong><br>
                    <span><%= post.getWriterName() %></span>
                </div>
            </div>
            <div class="post-date"><%= post.getCreatedAt().toString().substring(0, 10) %></div>
        </div>
        <% } %>

        <!-- 페이징 -->
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                    <a class="page-link" href="resourceboard.jsp?page=<%= currentPage - 1 %>">이전</a>
                </li>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= currentPage == i ? "active" : "" %>">
                        <a class="page-link" href="resourceboard.jsp?page=<%= i %>"><%= i %></a>
                    </li>
                <% } %>
                <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                    <a class="page-link" href="resourceboard.jsp?page=<%= currentPage + 1 %>">다음</a>
                </li>
            </ul>
        </nav>

        <!-- 글쓰기 버튼 -->
        <form action="resourceboard_write.jsp" method="get" class="text-end mt-4">
            <button type="submit" class="btn btn-primary">글쓰기</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
