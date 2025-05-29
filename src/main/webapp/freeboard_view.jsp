<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(postId);

    String loginUserId = (String) session.getAttribute("userId");
    if (post == null) {
        response.sendRedirect("freeboard.jsp");
        return;
    }
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
        .btn-warning { border-radius: 12px; }
        .btn-danger { border-radius: 12px; }
        .btn-secondary { border-radius: 12px; }
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

        <div class="d-flex justify-content-between mt-4">
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
