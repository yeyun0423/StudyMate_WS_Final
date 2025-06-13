<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO, dao.BoardReplyDAO, dto.BoardReplyDTO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(id);

    String loginUserId = (String) session.getAttribute("userId");
    boolean isAdmin = false;
    Object adminAttr = session.getAttribute("isAdmin");
    if (adminAttr != null) isAdmin = (Boolean) adminAttr;

    boolean isWriter = loginUserId != null && loginUserId.equals(post.getWriterId());

    if (post.isPrivate() && !isAdmin && !isWriter) {
%>
<script>
    alert("비공개 글입니다. 작성자 또는 관리자만 열람할 수 있습니다.");
    history.back();
</script>
<%
        return;
    }

    List<BoardReplyDTO> replies = new BoardReplyDAO().getRepliesByPostId(post.getPostId());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 게시글 보기</title>
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
        .btn-primary { background-color: #4f46e5; border: none; border-radius: 10px; }
        .btn-primary:hover { background-color: #4338ca; }
        .btn-secondary { border-radius: 10px; }
        .reply-box { background-color: #f9fafb; border-radius: 12px; padding: 16px; }
        .reply-item { padding-bottom: 12px; border-bottom: 1px solid #eaeaea; margin-bottom: 12px; }
        .reply-writer { font-weight: 600; }
        .reply-date { font-size: 0.85rem; color: #6b7280; }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp"/>

    <div class="section-card">
        <h3 class="fw-bold mb-3">
            <%= post.getTitle() %> <%= post.isPrivate() ? "🔒" : "" %>
        </h3>

        <p class="mb-1"><strong>작성자:</strong> <%= post.getWriterName() %></p>
        <p class="mb-3"><strong>작성일:</strong> <%= post.getCreatedAt().toString().substring(0, 10) %></p>

        <hr>

        <div class="form-control bg-white text-start" style="min-height: 120px;">
            <%= post.getContent().replaceAll("\n", "<br>") %>
        </div>

        <h5 class="mt-5 fw-bold">💬 댓글</h5>
        <div class="reply-box">
            <% if (replies.isEmpty()) { %>
                <p class="text-muted">댓글이 없습니다.</p>
            <% } else {
                for (BoardReplyDTO r : replies) { %>
                    <div class="reply-item">
                        <span class="reply-writer"><%= r.getWriterId() %></span>
                        <span class="reply-date">| <%= r.getCreatedAt().toString().substring(0, 16) %></span>
                        <div class="mt-1"><%= r.getContent().replaceAll("\n", "<br>") %></div>
                    </div>
            <% } } %>
        </div>

        <% if (isAdmin) { %>
        <form action="ReplyInsertServlet" method="post" class="mt-4">
            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
            <input type="hidden" name="writerId" value="<%= loginUserId %>">
            <textarea name="content" rows="3" class="form-control mb-2" placeholder="댓글을 입력하세요" required></textarea>
            <div class="text-end">
                <button type="submit" class="btn btn-primary btn-sm">댓글 등록</button>
            </div>
        </form>
        <% } %>

        <div class="text-end mt-4">
            <a href="qnaboard.jsp" class="btn btn-secondary">목록으로</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
