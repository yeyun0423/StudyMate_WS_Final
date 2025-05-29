<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(postId);

    String loginUserId = (String) session.getAttribute("userId");
    if (post == null || !loginUserId.equals(post.getWriterId())) {
        response.sendRedirect("freeboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자유게시판 글 수정</title>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="fw-bold mb-0">✏ 글 수정</h3>
        </div>

        <form action="freeboard_update.jsp" method="post">
            <input type="hidden" name="id" value="<%= post.getPostId() %>">

            <div class="mb-3">
                <label for="inputEditTitle" class="form-label fw-bold" id="labelEditTitle">제목</label>
                <input type="text" id="inputEditTitle" name="title" class="form-control" value="<%= post.getTitle() %>" required>
            </div>

            <div class="mb-3">
                <label for="inputEditContent" class="form-label fw-bold" id="labelEditContent">내용</label>
                <textarea id="inputEditContent" name="content" class="form-control" rows="8" required><%= post.getContent() %></textarea>
            </div>

            <div class="text-end">
                <button id="btnEditSubmit" type="submit" class="btn btn-primary">수정 완료</button>
                <a id="btnEditCancel" href="freeboard.jsp" class="btn btn-secondary ms-2">취소</a>
            </div>
        </form>
    </div>
</div>
<script>
    const USER_ID = "<%= session.getAttribute("userId") %>";
    const USER_NAME = "<%= session.getAttribute("userName") %>";
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
