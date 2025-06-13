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
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자료실 글 수정</title>
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
        .btn-primary {
            background-color: #4f46e5;
            border: none;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .btn-secondary {
            border-radius: 12px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-4">✍🏻 자료실 글 수정</h3>

        <form action="resourceboard_update.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= post.getPostId() %>">
            <input type="hidden" name="oldFilename" value="<%= post.getFilename() %>">

            <div class="mb-3">
                <label for="title" class="form-label fw-bold">제목</label>
                <input type="text" id="title" name="title" class="form-control" value="<%= post.getTitle() %>" required>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label fw-bold">내용</label>
                <textarea id="content" name="content" class="form-control" rows="8" required><%= post.getContent() %></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">기존 첨부파일</label><br>
                <% if (post.getFilename() != null && !post.getFilename().isEmpty()) { %>
                    <a href="resources/upload/<%= post.getFilename() %>">
                        <%= post.getFilename().substring(post.getFilename().indexOf("_") + 1) %>
                    </a>
                <% } else { %>
                    <span>첨부파일 없음</span>
                <% } %>
            </div>

            <div class="mb-3">
                <label for="uploadFile" class="form-label fw-bold">새 첨부파일 (선택)</label>
                <input type="file" id="uploadFile" name="uploadFile" class="form-control">
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="resourceboard.jsp" class="btn btn-secondary ms-2">취소</a>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
