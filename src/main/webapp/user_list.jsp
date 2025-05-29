<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.UserDAO, dto.UserDTO" %>
<%
    int currentpage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    int limit = 5;
    UserDAO dao = new UserDAO();
    List<UserDTO> users = dao.getUsersByPage(currentpage, limit);
    int totalUsers = dao.getUserCount();
    int totalPages = (int)Math.ceil((double)totalUsers / limit);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전체 유저 목록</title>
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
        .btn-primary { background-color: #4f46e5; border: none; border-radius: 8px; }
        .btn-danger { border-radius: 8px; }
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
    <jsp:include page="navbar.jsp"/>

    <div class="table-card">
        <h3 class="fw-bold mb-4">👥 전체 유저 목록</h3>

        <table class="table table-bordered text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>비밀번호</th>
                    <th>가입일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <% int index = (currentpage - 1) * limit + 1;
                   for (UserDTO u : users) { %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= u.getUserId() %></td>
                    <td><%= u.getName() %></td>
                    <td><%= u.getPassword() %></td>
                    <td><%= u.getJoinDate().toString().substring(0, 10) %></td>
                    <td>
                        <a href="user_timetable.jsp?userId=<%= u.getUserId() %>" class="btn btn-primary btn-sm">시간표</a>
                        <a href="user_delete.jsp?userId=<%= u.getUserId() %>" class="btn btn-danger btn-sm"
                           onclick="return confirm('해당 사용자의 게시글을 포함한 모든 활동 기록이 삭제됩니다.\n정말 탈퇴 처리하시겠습니까?');">
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
                    <li class="page-item"><a class="page-link" href="user_list.jsp?page=<%= currentpage - 1 %>">이전</a></li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= i == currentpage ? "active" : "" %>">
                        <a class="page-link" href="user_list.jsp?page=<%= i %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentpage < totalPages) { %>
                    <li class="page-item"><a class="page-link" href="user_list.jsp?page=<%= currentpage + 1 %>">다음</a></li>
                <% } %>
            </ul>
        </nav>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
