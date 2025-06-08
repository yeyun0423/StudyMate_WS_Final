<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.UserDAO, dto.UserDTO" %>
<%
    int currentpage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    String search = request.getParameter("search");
    int limit = 5;
    UserDAO dao = new UserDAO();
    List<UserDTO> users = (search == null || search.trim().isEmpty()) 
                          ? dao.getUsersByPage(currentpage, limit) 
                          : dao.searchUsersByPage(search, currentpage, limit);
    int totalUsers = dao.getUserCount();
    int filteredUsers = (search == null || search.trim().isEmpty()) 
                          ? totalUsers 
                          : dao.getSearchUserCount(search);
    int totalPages = (int) Math.ceil((double) filteredUsers / limit);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전체 유저 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
        .profile-img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="/navbar.jsp"/>

    <div class="table-card">
        <h3 class="fw-bold mb-3">👥 전체 유저 목록</h3>
        <p class="text-muted">총 가입 유저 수: <strong><%= totalUsers %></strong>명</p>

        <!-- 검색창 + 전체 목록 버튼 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <% if (search != null && !search.trim().isEmpty()) { %>
                <a href="<%= request.getContextPath() %>/admin/users_list.jsp" class="btn btn-secondary btn-sm">전체 목록 보기</a>
            <% } else { %>
                <div></div>
            <% } %>
            <form action="<%= request.getContextPath() %>/admin/user_list.jsp" method="get" class="d-flex">
                <input type="text" name="search" class="form-control me-2" style="width: 250px;"
                       placeholder="아이디/이름 검색" value="<%= search != null ? search : "" %>">
                <button class="btn btn-outline-primary btn-sm">검색</button>
            </form>
        </div>

        <!-- 유저 테이블 -->
        <table class="table table-bordered text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>프로필</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>비밀번호</th>
                    <th>가입일 <i class="bi bi-sort-down"></i></th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int index = (currentpage - 1) * limit + 1;
                    for (UserDTO u : users) {
                        String profileImg = (u.getProfileImage() != null && !u.getProfileImage().isEmpty()) 
                                            ? u.getProfileImage() : "default.png";
                %>
                <tr>
                    <td><%= index++ %></td>
                    <td>
                        <img src="<%= request.getContextPath() %>/resources/images/<%= profileImg %>" class="profile-img">
                    </td>
                    <td><%= u.getUserId() %></td>
                    <td><%= u.getName() %></td>
                    <td><%= u.getPassword() %></td>
                    <td><%= u.getJoinDate().toString().substring(0, 10) %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/admin/user_timetable.jsp?userId=<%= u.getUserId() %>" class="btn btn-primary btn-sm">
                            <i class="bi bi-calendar-week"></i> 시간표
                        </a>
                        <a href="<%= request.getContextPath() %>/admin/user_delete.jsp?userId=<%= u.getUserId() %>" class="btn btn-danger btn-sm"
                           onclick="return confirm('해당 사용자의 게시글을 포함한 모든 활동 기록이 삭제됩니다.\n정말 탈퇴 처리하시겠습니까?');">
                            <i class="bi bi-person-x-fill"></i> 삭제
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
                    <li class="page-item">
                        <a class="page-link" href="<%= request.getContextPath() %>/admin/user_list.jsp?page=<%= currentpage - 1 %>&search=<%= search != null ? search : "" %>">이전</a>
                    </li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= i == currentpage ? "active" : "" %>">
                        <a class="page-link" href="<%= request.getContextPath() %>/admin/user_list.jsp?page=<%= i %>&search=<%= search != null ? search : "" %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentpage < totalPages) { %>
                    <li class="page-item">
                        <a class="page-link" href="<%= request.getContextPath() %>/admin/user_list.jsp?page=<%= currentpage + 1 %>&search=<%= search != null ? search : "" %>">다음</a>
                    </li>
                <% } %>
            </ul>
        </nav>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
