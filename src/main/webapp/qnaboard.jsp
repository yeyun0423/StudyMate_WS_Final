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
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 게시판</title>
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
            background: #f8f9fa;
            border-radius: 12px;
            margin-bottom: 12px;
        }
        .circle-profile {
            width: 40px;
            height: 40px;
            background-color: #6c63ff;
            color: white;
            font-weight: bold;
            font-size: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .post-info {
            flex-grow: 1;
            margin-left: 16px;
        }
        .post-date {
            text-align: right;
            min-width: 100px;
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
                    </a>
                </strong>
                <div><%= post.getWriterName() %></div>
            </div>
            <div class="post-date">
                <span class="text-muted"><%= post.isPrivate() ? "\uD83D\uDD12 비공개" : "\uD83D\uDD13 공개" %></span><br>
                <%= post.getCreatedAt().toString().substring(0, 10) %>
            </div>
        </div>
        <% } %>

        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <% if (currentPage > 1) { %>
                    <li class="page-item"><a class="page-link" href="qnaboard.jsp?page=<%= currentPage - 1 %>">이전</a></li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= currentPage == i ? "active" : "" %>">
                        <a class="page-link" href="qnaboard.jsp?page=<%= i %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentPage < totalPages) { %>
                    <li class="page-item"><a class="page-link" href="qnaboard.jsp?page=<%= currentPage + 1 %>">다음</a></li>
                <% } %>
            </ul>
        </nav>

        <form action="qnawrite.jsp" method="get" class="text-end mt-4">
            <button type="submit" class="btn btn-primary">글쓰기</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
