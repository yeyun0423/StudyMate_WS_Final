<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.util.List" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(id);

    String loginUserId = (String) session.getAttribute("userId");
    boolean isAdmin = false;
    Object adminAttr = session.getAttribute("isAdmin");
    if (adminAttr != null) {
        isAdmin = (boolean) adminAttr;
    }

    boolean isWriter = loginUserId != null && loginUserId.equals(post.getWriterId());

    // 비공개 글 접근 제한
    if (post.isPrivate() && !isAdmin && !isWriter) {
%>
    <script>
        alert("비공개 글입니다. 작성자 또는 관리자만 열람할 수 있습니다.");
        history.back();
    </script>
<%
        return;
    }

    // 댓글 목록 불러오기
    List<BoardReplyDTO> replies = new BoardReplyDAO().getRepliesByPostId(post.getPostId());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 게시글 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 class="fw-bold mb-4">
        <%= post.getTitle() %> <%= post.isPrivate() ? "🔒" : "" %>
    </h3>

    <div class="mb-3">
        <p class="mb-1"><strong>작성자:</strong> <%= post.getWriterName() %></p>
        <p class="mb-1"><strong>작성일:</strong> <%= post.getCreatedAt().toString().substring(0, 10) %></p>
    </div>

    <hr>

    <!-- ✅ 본문 내용 -->
    <div class="form-control bg-white" style="min-height: 100px;">
        <%= post.getContent().replaceAll("\n", "<br>") %>
    </div>

    <!-- ✅ 댓글 목록 -->
    <h5 class="mt-5 fw-bold">💬 댓글</h5>
    <div class="border rounded p-3 bg-white">
        <% if (replies.isEmpty()) { %>
            <p class="text-muted">댓글이 없습니다.</p>
        <% } else {
            for (BoardReplyDTO r : replies) {
        %>
            <div class="mb-2">
                <strong><%= r.getWriterId() %></strong> |
                <small class="text-muted"><%= r.getCreatedAt().toString().substring(0, 16) %></small><br>
                <div><%= r.getContent().replaceAll("\n", "<br>") %></div>
            </div>
            <hr>
        <% } } %>
    </div>

    <!-- ✅ 관리자 전용 댓글 작성 -->
    <% if (isAdmin) { %>
    <form action="ReplyInsertServlet" method="post" class="mt-3">
        <input type="hidden" name="postId" value="<%= post.getPostId() %>">
        <input type="hidden" name="writerId" value="<%= loginUserId %>">
        <div class="mb-2">
            <textarea name="content" rows="3" class="form-control" placeholder="댓글을 입력하세요" required></textarea>
        </div>
        <div class="text-end">
            <button type="submit" class="btn btn-primary btn-sm">댓글 등록</button>
        </div>
    </form>
    <% } %>

    <!-- ✅ 목록으로 돌아가기 -->
    <div class="mt-4 text-end">
        <a href="qnaboard.jsp" class="btn btn-secondary">목록으로</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
