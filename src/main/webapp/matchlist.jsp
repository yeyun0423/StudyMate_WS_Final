<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dao.StudyGroupDAO, dto.StudyGroupDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String search = request.getParameter("search");
    String sort = request.getParameter("sort"); // subject or date
    String order = request.getParameter("order"); // asc or desc
    int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    int limit = 5;

    StudyGroupDAO dao = new StudyGroupDAO();
    List<StudyGroupDTO> allGroups = dao.getAllStudyGroupsWithMembers();
    int totalGroups = allGroups.size();

    // 과목별 통계 요약 계산
    Map<String, Integer> subjectCountMap = new HashMap<>();
    for (StudyGroupDTO g : allGroups) {
        subjectCountMap.put(g.getSubject(), subjectCountMap.getOrDefault(g.getSubject(), 0) + 1);
    }

    List<StudyGroupDTO> filteredGroups = new ArrayList<>();
    if (search != null && !search.trim().isEmpty()) {
        for (StudyGroupDTO g : allGroups) {
            if (g.getSubject().contains(search)) filteredGroups.add(g);
        }
    } else {
        filteredGroups = new ArrayList<>(allGroups);
    }

    // 정렬
    if ("subject".equals(sort)) {
        filteredGroups.sort(Comparator.comparing(StudyGroupDTO::getSubject));
    } else if ("date".equals(sort)) {
        filteredGroups.sort(Comparator.comparing(StudyGroupDTO::getCreatedAt));
    }
    if ("desc".equals(order)) {
        Collections.reverse(filteredGroups);
    }

    int totalPages = (int) Math.ceil((double) filteredGroups.size() / limit);
    int startIndex = (currentPage - 1) * limit;
    int endIndex = Math.min(startIndex + limit, filteredGroups.size());
    List<StudyGroupDTO> groups = filteredGroups.subList(startIndex, endIndex);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>스터디 매칭 목록</title>
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
        <h3 class="fw-bold mb-3">🌐 전체 스터디 매칭 목록</h3>
        <p class="text-muted">매칭된 스터디 수: <strong><%= totalGroups %></strong>개</p>

        <!-- 과목별 통계 요약 -->
        <div class="mb-3">
            <% for (Map.Entry<String, Integer> entry : subjectCountMap.entrySet()) { %>
                <span class="badge bg-info text-dark me-1"><%= entry.getKey() %>: <%= entry.getValue() %>개</span>
            <% } %>
        </div>

        <!-- 검색창 + 전체 목록 버튼 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <% if (search != null && !search.trim().isEmpty()) { %>
                <a href="matchlist.jsp" class="btn btn-secondary btn-sm">전체 목록 보기</a>
            <% } else { %>
                <div></div>
            <% } %>
            <form action="matchlist.jsp" method="get" class="d-flex">
                <input type="text" name="search" class="form-control me-2" style="width: 250px;"
                       placeholder="과목명 검색" value="<%= search != null ? search : "" %>">
                <button class="btn btn-outline-primary btn-sm">검색</button>
            </form>
        </div>

        <!-- 정렬 옵션 -->
        <div class="d-flex justify-content-end mb-2">
            <a href="matchlist.jsp?sort=subject&order=asc" class="btn btn-outline-dark btn-sm me-2">과목 오름차순</a>
            <a href="matchlist.jsp?sort=subject&order=desc" class="btn btn-outline-dark btn-sm me-2">과목 내림차순</a>
            <a href="matchlist.jsp?sort=date&order=desc" class="btn btn-outline-dark btn-sm">최신순</a>
        </div>

        <!-- 테이블 -->
        <table class="table table-bordered text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>과목</th>
                    <th>리더</th>
                    <th>멤버</th>
                    <th>생성일</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int idx = startIndex + 1;
                    for (StudyGroupDTO g : groups) {
                        String members = String.join(", ", g.getMemberNames());
                %>
                <tr>
                    <td><%= idx++ %></td>
                    <td><span class="badge bg-primary"><%= g.getSubject() %></span></td>
                    <td><%= g.getLeaderName() %></td>
                    <td><%= members %></td>
                    <td><%= g.getCreatedAt().substring(0, 10) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- 페이지네이션 -->
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <% if (currentPage > 1) { %>
                    <li class="page-item">
                        <a class="page-link" href="matchlist.jsp?page=<%= currentPage - 1 %>&search=<%= search != null ? search : "" %>&sort=<%= sort != null ? sort : "" %>&order=<%= order != null ? order : "" %>">이전</a>
                    </li>
                <% } %>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <a class="page-link" href="matchlist.jsp?page=<%= i %>&search=<%= search != null ? search : "" %>&sort=<%= sort != null ? sort : "" %>&order=<%= order != null ? order : "" %>"><%= i %></a>
                    </li>
                <% } %>
                <% if (currentPage < totalPages) { %>
                    <li class="page-item">
                        <a class="page-link" href="matchlist.jsp?page=<%= currentPage + 1 %>&search=<%= search != null ? search : "" %>&sort=<%= sort != null ? sort : "" %>&order=<%= order != null ? order : "" %>">다음</a>
                    </li>
                <% } %>
            </ul>
        </nav>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    [...tooltipTriggerList].forEach(t => new bootstrap.Tooltip(t));
</script>
</body>
</html>