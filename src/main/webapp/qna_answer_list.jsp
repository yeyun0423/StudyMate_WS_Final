<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    if (userName == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("user_name".equals(c.getName())) {
                    userName = c.getValue();
                    break;
                }
            }
        }
    }

    if (userId == null || userName == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }

    int currentpage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    int limit = 5;
    BoardPostDAO dao = new BoardPostDAO();
    List<BoardPostDTO> qnaPosts = dao.getQnaPostsWithStatus(currentpage, limit);
    int totalPosts = dao.getQnaPostCount();
    int totalPages = (int)Math.ceil((double)totalPosts / limit);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 답변 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'SUIT', sans-serif; }
        body { background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff); }
        .table-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }
        .btn-warning { border-radius: 8px; }
        .btn-danger { border-radius: 8px; }
        .status-done { color: #2563eb; font-weight: bold; }  /* 파랑 */
        .status-pending { color: #6b7280; font-weight: bold; }  /* 회색 */
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
    <script>
        function confirmDelete() {
            return confirm("해당 Q&A에 대한 답변을 정말 삭제하시겠습니까?");
        }
    </script>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp"/>

    <div class="table-card">
        <h3 class="fw-bold mb-4">💬 Q&A 답변 목록</h3>

        <table class="table table-bordered text-center align-middle">
            <thead class="table-light">
            <tr>
                <th>#</th>
                <th>작성자</th>
                <th>제목</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
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
                    <td><%= post.getTitle() %></td>
                    <td class="<%= answered ? "status-done" : "status-pending" %>">
                        <%= status %>
                    </td>
                    <td>
                        <a href="qna_edit.jsp?id=<%= post.getPostId() %>" class="btn btn-warning btn-sm">수정</a>
                        <a href="qna_delete.jsp?id=<%= post.getPostId() %>"
                           class="btn btn-danger btn-sm"
                           <%= answered ? "onclick=\"return confirmDelete();\"" : "" %>>
                            삭제
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <!-- 페이지네이션 -->
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <% if (currentpage > 1) { %>
                    <li class="page-item"><a class="page-link" href="qna_answer_list.jsp?page=<%= currentpage - 1 %>">이전</a></li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= i == currentpage ? "active" : "" %>">
                        <a class="page-link" href="qna_answer_list.jsp?page=<%= i %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentpage < totalPages) { %>
                    <li class="page-item"><a class="page-link" href="qna_answer_list.jsp?page=<%= currentpage + 1 %>">다음</a></li>
                <% } %>
            </ul>
        </nav>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
