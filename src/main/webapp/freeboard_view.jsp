<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO, dao.BoardCommentDAO, dto.BoardCommentDTO, java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDAO postDao = new BoardPostDAO();
    postDao.increaseViews(postId); 

    BoardPostDTO post = postDao.getPostById(postId);
    String loginUserId = (String) session.getAttribute("userId");

    if (post == null) {
        response.sendRedirect("freeboard.jsp");
        return;
    }

    // 댓글 목록 불러오기
    List<BoardCommentDTO> comments = new BoardCommentDAO().getCommentsByPostId(postId);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자유게시판 글 보기</title>
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
        .form-control-static {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            padding: 12px 16px;
            border-radius: 12px;
        }
        .btn-warning, .btn-danger, .btn-secondary, .btn-primary {
            border-radius: 12px;
        }
        .comment-box {
            background-color: #f9fafb;
            padding: 16px;
            border-radius: 12px;
            border: 1px solid #ddd;
            margin-bottom: 12px;
        }
        .comment-author {
            font-weight: bold;
            margin-bottom: 4px;
        }
        .comment-date {
            font-size: 0.8rem;
            color: #888;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-4">📋 자유게시판</h3>

        <div class="mb-3">
            <label class="form-label fw-bold">제목</label>
            <div class="form-control-static"><%= post.getTitle() %></div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">작성자</label>
            <div class="form-control-static"><%= post.getWriterName() %></div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">내용</label>
            <div class="form-control-static" style="min-height: 200px; white-space: pre-line;"><%= post.getContent().trim() %></div>
        </div>

        <!-- 댓글 목록 -->
        <hr class="my-4">
        <h5 class="fw-bold mb-3">💬 댓글</h5>
        <% if (comments.isEmpty()) { %>
            <p class="text-muted">아직 댓글이 없습니다.</p>
        <% } else { 
            for (BoardCommentDTO c : comments) { %>
            <div class="comment-box">
                <div class="comment-author"><%= c.getWriterName() %></div>
                <div class="comment-date"><%= c.getCreatedAt().toString().substring(0, 16) %></div>
                <div><%= c.getContent() %></div>
            </div>
        <% }} %>

        <!-- 댓글 작성 폼 -->
        <% if (loginUserId != null) { %>
            <form action="<%= request.getContextPath() %>/FreeboardCommentServlet" method="post" class="mt-4">
                <input type="hidden" name="postId" value="<%= postId %>">
                <textarea name="content" class="form-control mb-2" rows="3" placeholder="댓글을 입력하세요" required></textarea>
                <button type="submit" class="btn btn-primary btn-sm">댓글 등록</button>
            </form>
        <% } else { %>
            <p class="text-muted">로그인 후 댓글을 작성할 수 있습니다.</p>
        <% } %>

        <!-- 버튼 영역 -->
        <div class="d-flex justify-content-between mt-5">
            <a href="freeboard.jsp" class="btn btn-secondary">목록으로</a>

            <% if (loginUserId != null && loginUserId.equals(post.getWriterId())) { %>
                <div class="d-flex gap-2">
                    <form action="freeboard_edit.jsp" method="get">
                        <input type="hidden" name="id" value="<%= post.getPostId() %>">
                        <button type="submit" class="btn btn-warning btn-sm">수정</button>
                    </form>
                    <form action="freeboard_delete.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="id" value="<%= post.getPostId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                    </form>
                </div>
            <% } %>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

