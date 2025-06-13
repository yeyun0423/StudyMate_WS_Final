<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TimetableDAO, dto.TimetableDTO, dao.UserDAO, dto.UserDTO, java.util.*" %>
<%
    String loginUserId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    if (loginUserId == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }

    String targetUserId = request.getParameter("userId");
    if (targetUserId == null) {
        response.sendRedirect("user_list.jsp");
        return;
    }

    UserDTO user = new UserDAO().getUserById(targetUserId);
    String targetUserName = user != null ? user.getName() : targetUserId;

    List<TimetableDTO> timetable = new TimetableDAO().getTimetableByUser(targetUserId);
    String[][] data = new String[5][5];
    for (TimetableDTO t : timetable) {
        int row = t.getPeriod() - 1;
        int col = -1;
        switch (t.getDayOfWeek()) {
            case "MON": col = 0; break;
            case "TUE": col = 1; break;
            case "WED": col = 2; break;
            case "THU": col = 3; break;
            case "FRI": col = 4; break;
        }
        if (row >= 0 && col >= 0) {
            data[row][col] = t.getSubject();
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 유저 시간표</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
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
            font-weight: 600;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .table th, .table td {
            vertical-align: middle;
            border-color: #dee2e6;
        }
        .table thead th {
            background-color: #e0e7ff;
            color: #1e1b4b;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="/navbar.jsp" />
    

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold">👤 <%= targetUserName %> 님의 시간표</h3>
        <a href="user_list.jsp" class="btn btn-secondary btn-sm rounded-pill">← 유저 목록으로</a>
    </div>

    <div class="section-card">
        <table class="table table-bordered text-center align-middle">
            <thead>
                <tr>
                    <th>교시</th>
                    <th>월요일</th>
                    <th>화요일</th>
                    <th>수요일</th>
                    <th>목요일</th>
                    <th>금요일</th>
                </tr>
            </thead>
            <tbody>
                <% for (int i = 0; i < 5; i++) { %>
                <tr>
                    <th><%= (i + 1) %>교시</th>
                    <% for (int j = 0; j < 5; j++) { %>
                        <td><%= data[i][j] == null ? "" : data[i][j] %></td>
                    <% } %>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
