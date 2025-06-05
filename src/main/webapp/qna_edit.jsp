<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%@ page import="dao.BoardReplyDAO, dto.BoardReplyDTO" %>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'SUIT', sans-serif; }
        body { background-color: #f0f4ff; }
        .card-box {
            background: white;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }
        .comment-box {
            background-color: #f8f9fa;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 16px;
        }
        .btn-sm {
            border-radius: 10px;
        }
        textarea.form-control {
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="/navbar.jsp"/>

    <div class="card-box">
        <h3 class="fw-bold mb-4">
            <%= post.getTitle() %> <%= post.isPrivate() ? "🔒" : "" %>
        </h3>

        <div class="mb-3">
            <p class="mb-1"><strong>작성자:</strong> <%= post.getWriterName() %></p>
            <p class="mb-1"><strong>작성일:</strong> <%= post.getCreatedAt().toString().substring(0, 10) %></p>
        </div>

        <hr>

        <!-- 본문 -->
        <div class="form-control bg-white" style="min-height: 100px;">
            <%= post.getContent().replaceAll("\n", "<br>") %>
        </div>

        <!-- 댓글 목록 -->
        <h5 class="mt-5 fw-bold">💬 댓글</h5>
        <div class="bg-white rounded p-3 border">
            <% if (replies.isEmpty()) { %>
                <p class="text-muted">댓글이 없습니다.</p>
            <% } else {
                for (BoardReplyDTO r : replies) {
                    boolean isMyReply = isAdmin && loginUserId.equals(r.getWriterId());
            %>
                <div class="comment-box">
                    <strong><%= r.getWriterId() %></strong> |
                    <small class="text-muted"><%= r.getCreatedAt().toString().substring(0, 16) %></small>
                    <% if (request.getParameter("editReplyId") != null &&
                           Integer.parseInt(request.getParameter("editReplyId")) == r.getReplyId()) { %>
                        <form action="ReplyUpdateServlet" method="post" class="mt-2">
                            <input type="hidden" name="replyId" value="<%= r.getReplyId() %>">
                            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                            <textarea name="content" rows="3" class="form-control mb-2"><%= r.getContent() %></textarea>
                            <div class="text-end">
                                <button type="submit" class="btn btn-success btn-sm">저장</button>
                                <a href="qna_edit.jsp?id=<%= post.getPostId() %>" class="btn btn-secondary btn-sm">취소</a>
                            </div>
                        </form>
                    <% } else { %>
                        <div class="mt-2"><%= r.getContent().replaceAll("\n", "<br>") %></div>
                        <% if (isMyReply) { %>
                        <div class="mt-2 text-end">
                            <a href="qna_edit.jsp?id=<%= post.getPostId() %>&editReplyId=<%= r.getReplyId() %>" class="btn btn-outline-primary btn-sm">수정</a>
                        </div>
                        <% } %>
                    <% } %>
                </div>
            <% } } %>
        </div>

        <!-- 댓글 작성 (관리자만) -->
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

        <!-- 목록 -->
        <div class="mt-4 text-end">
            <a href="<%= request.getContextPath() %>/admin/qna_answer_list.jsp" class="btn btn-secondary btn-sm">목록으로</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
