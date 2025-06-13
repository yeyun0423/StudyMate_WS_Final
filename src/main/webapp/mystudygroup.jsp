<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.StudyGroupDAO, dto.StudyGroupDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String loginUserId = (String) session.getAttribute("userId");
    if (loginUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String search = request.getParameter("search");
    int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    int limit = 3;

    StudyGroupDAO dao = new StudyGroupDAO();
    List<StudyGroupDTO> myGroups = dao.getStudyGroupsByUser(loginUserId);

    if (search != null && !search.trim().isEmpty()) {
        myGroups.removeIf(g -> !g.getSubject().toLowerCase().contains(search.toLowerCase()));
    }

    int totalGroups = myGroups.size();
    int totalPages = (int) Math.ceil((double) totalGroups / limit);
    int startIndex = (currentPage - 1) * limit;
    int endIndex = Math.min(startIndex + limit, totalGroups);
    List<StudyGroupDTO> groups = myGroups.subList(startIndex, endIndex);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 스터디 그룹</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        * { font-family: 'SUIT', sans-serif; }
        body { background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff); }
        .section-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }
        .study-card {
            border: 1px solid #ddd;
            padding: 24px;
            border-radius: 16px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .study-card:hover {
            transform: translateY(-4px);
        }
        .subject-badge {
            font-size: 1rem;
            padding: 6px 12px;
            border-radius: 20px;
        }
        .member-line i { color: #6c63ff; }
        .action-buttons { text-align: right; }
        .btn-exit {
            background-color: #f87171;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 6px 12px;
        }
        .btn-exit:hover { background-color: #ef4444; }
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
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-3">🏫 나의 스터디 그룹</h3>

        <!-- 검색창 + 전체 목록 버튼 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <% if (search != null && !search.trim().isEmpty()) { %>
                <a href="mystudygroup.jsp" class="btn btn-secondary btn-sm">전체 목록 보기</a>
            <% } else { %>
                <div></div>
            <% } %>
            <form action="mystudygroup.jsp" method="get" class="d-flex">
                <input type="text" name="search" class="form-control me-2" style="width: 250px;"
                       placeholder="과목명 검색" value="<%= search != null ? search : "" %>">
                <button class="btn btn-outline-primary btn-sm">검색</button>
            </form>
        </div>

        <% if (groups.isEmpty()) { %>
            <div class="text-center text-muted fw-semibold" style="padding: 40px;">
                가입한 스터디 그룹이 없습니다.<br>
                <a href="home.jsp#study-group" class="btn btn-primary mt-3">스터디 만들러 가기</a>
            </div>
        <% } else {
            for (StudyGroupDTO group : groups) {
                String subject = group.getSubject();
                String leader = group.getLeaderName();
                List<String> members = group.getMemberNames();
                String createdAt = group.getCreatedAt().substring(0, 10);
                boolean isLeader = loginUserId.equals(group.getLeaderId());
        %>
        <div class="study-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="badge bg-primary subject-badge"><%= subject %></span>
                <small class="text-muted">생성일: <%= createdAt %></small>
            </div>
            <div class="member-line mb-2">
                <i class="bi bi-person-fill-check"></i> <strong><%= leader %></strong>
                <% for (String m : members) { %>
                    <span class="ms-2"><i class="bi bi-person"></i> <%= m %></span>
                <% } %>
            </div>
            <div class="action-buttons">
                <% if (isLeader) { %>
                    <form action="StudyDeleteServlet" method="post" onsubmit="return confirm('스터디를 삭제하시겠습니까?\n관련 정보가 모두 삭제됩니다.');">
                        <input type="hidden" name="groupId" value="<%= group.getGroupId() %>">
                        <button type="submit" class="btn btn-exit">스터디 삭제</button>
                    </form>
                <% } else { %>
                    <form action="StudyExitServlet" method="post" onsubmit="return confirm('해당 스터디에서 탈퇴하시겠습니까?');">
                        <input type="hidden" name="groupId" value="<%= group.getGroupId() %>">
                        <input type="hidden" name="userId" value="<%= loginUserId %>">
                        <button type="submit" class="btn btn-exit">탈퇴</button>
                    </form>
                <% } %>
            </div>
        </div>
        <% } } %>

        <!-- 페이지네이션 -->
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <% if (currentPage > 1) { %>
                    <li class="page-item">
                        <a class="page-link" href="mystudygroup.jsp?page=<%= currentPage - 1 %>&search=<%= search != null ? search : "" %>">이전</a>
                    </li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <a class="page-link" href="mystudygroup.jsp?page=<%= i %>&search=<%= search != null ? search : "" %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentPage < totalPages) { %>
                    <li class="page-item">
                        <a class="page-link" href="mystudygroup.jsp?page=<%= currentPage + 1 %>&search=<%= search != null ? search : "" %>">다음</a>
                    </li>
                <% } %>
            </ul>
        </nav>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
