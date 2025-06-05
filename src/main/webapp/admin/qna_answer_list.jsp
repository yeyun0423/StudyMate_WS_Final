<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    String loginUserId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (loginUserId == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<BoardPostDTO> replies = new BoardPostDAO().getQnaPostsWithStatus();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 답변 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css">
 
</head>
<<<<<<< Updated upstream:src/main/webapp/qna_answer_list.jsp
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>
=======
<body>
<div class="container py-5">
     <jsp:include page="/navbar.jsp"/>
>>>>>>> Stashed changes:src/main/webapp/admin/qna_answer_list.jsp

    <h3 class="fw-bold mb-4">💬 Q&A 답변 목록</h3>

    <table class="table table-bordered text-center align-middle">
        <thead class="table-light">
            <tr>
                <th>#</th>
                <th>작성자</th>
                <th>Q&A 제목</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
<<<<<<< Updated upstream:src/main/webapp/qna_answer_list.jsp
        </thead>
        <tbody>
        <% int no = 1;
   for (BoardPostDTO r : replies) { %>
<tr>
    <td><%= no++ %></td>
    <td><%= r.getWriterName() %></td>
    <td><a href="../qnaview.jsp?id=<%= r.getPostId() %>"><%= r.getTitle() %></a></td>
    <td><%= r.getStatus() %></td>
    <td>
        <a href="reply_edit.jsp?postId=<%= r.getPostId() %>" class="btn btn-sm btn-warning">수정</a>
        <a href="../ReplyDeleteServlet?postId=<%= r.getPostId() %>" class="btn btn-sm btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
    </td>
</tr>
<% } %>
=======
            </thead>
            <tbody>
            <% int index = (currentpage - 1) * limit + 1;
               for (BoardPostDTO post : qnaPosts) {
                   String status = post.getStatus();
                   boolean answered = "답변 완료".equals(status);
            %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= post.getWriterName() %></td>
                    <td><i class="bi bi-chat-dots-fill text-primary me-1"></i><%= post.getTitle() %></td>
                    <td class="<%= answered ? "status-done" : "status-pending" %>">
                        <%= status %>
                    </td>
                    <td>
    <a href="<%= request.getContextPath() %>/qna_edit.jsp?id=<%= post.getPostId() %>" class="btn btn-warning btn-sm" title="답변 수정">수정</a>
    <a href="<%= request.getContextPath() %>/admin/qna_delete.jsp?id=<%= post.getPostId() %>" class="btn btn-danger btn-sm" title="답변 삭제"
       <%= answered ? "onclick=\"return confirmDelete();\"" : "" %>>삭제</a>
</td>
                    
                </tr>
            <% } %>
            </tbody>
        </table>
>>>>>>> Stashed changes:src/main/webapp/admin/qna_answer_list.jsp

        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
