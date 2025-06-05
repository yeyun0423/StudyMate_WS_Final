<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TimetableDAO, dto.TimetableDTO, dao.UserDAO, dto.UserDTO, java.util.*" %>

<%
    // ✅ 로그인 및 관리자 권한 확인
    String loginUserId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    if (loginUserId == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ 시간표를 볼 대상 유저 ID
    String targetUserId = request.getParameter("userId");
    if (targetUserId == null) {
        response.sendRedirect("user_list.jsp");
        return;
    }

    // ✅ 유저 이름 표시용
    UserDTO user = new UserDAO().getUserById(targetUserId);
    String targetUserName = user != null ? user.getName() : targetUserId;

    // ✅ 시간표 불러오기
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
 <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/home.css?v=1">
    <script src="resources/js/bootstrap.bundle.min.js"></script>
</head>
<<<<<<< Updated upstream:src/main/webapp/user_timetable.jsp
<body class="bg-light">
<div class="container py-4">

    <!-- ✅ 공통 상단바 -->
    <jsp:include page="navbar.jsp" />
=======
<body>
<div class="container py-5">
    <jsp:include page="/navbar.jsp" />
    
>>>>>>> Stashed changes:src/main/webapp/admin/user_timetable.jsp

    <!-- ✅ 제목 및 뒤로가기 버튼 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold">👤 <%= targetUserName %>님의 시간표</h3>
        <a href="user_list.jsp" class="btn btn-secondary btn-sm">← 유저 목록으로</a>
    </div>

    <!-- ✅ 시간표 테이블 -->
    <div class="card p-4 mb-5">
        <table class="table text-center align-middle">
            <thead class="table-primary">
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
            <%
                for (int i = 0; i < 5; i++) {
            %>
                <tr>
                    <th><%= (i + 1) %>교시</th>
                    <% for (int j = 0; j < 5; j++) { %>
                        <td><%= data[i][j] == null ? "" : data[i][j] %></td>
                    <% } %>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
