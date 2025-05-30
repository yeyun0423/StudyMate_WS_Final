<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TimetableDAO, dto.TimetableDTO, java.util.*" %>
<%
    String userId = (String) session.getAttribute("userId");
    String userName = null;

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) {
                userName = c.getValue();
                break;
            }
        }
    }

    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<TimetableDTO> timetable = new TimetableDAO().getTimetableByUser(userId);
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

    String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 시간표</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .btn-outline-secondary {
            border-radius: 12px;
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
    <script>
        function exportTimetable() {
            window.print();
        }
    </script>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold">🗓️ 내 시간표</h3>
            <div>
                <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#timetableModal">+ 추가</button>
                <button class="btn btn-outline-secondary" onclick="exportTimetable()">🖨️ 내보내기</button>
            </div>
        </div>

        <table class="table table-bordered text-center align-middle">
            <thead>
                <tr>
                    <th style="background-color: #e0e7ff;">교시</th>
                    <th style="background-color: #e0e7ff;">월요일</th>
                    <th style="background-color: #e0e7ff;">화요일</th>
                    <th style="background-color: #e0e7ff;">수요일</th>
                    <th style="background-color: #e0e7ff;">목요일</th>
                    <th style="background-color: #e0e7ff;">금요일</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (int i = 0; i < 5; i++) {
            %>
            <tr>
                <th style="background-color: #e0e7ff;"><%= (i + 1) %>교시</th>
                <% for (int j = 0; j < 5; j++) { %>
                    <td><%= data[i][j] == null ? "" : data[i][j] %></td>
                <% } %>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="text-end text-muted mt-2">
            <small>📅 <%= today %> 기준</small>
        </div>
    </div>
</div>

<!-- 시간표 추가 모달 -->
<div class="modal fade" id="timetableModal" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content p-4" action="timetable" method="post">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold text-primary">⏰ 시간표 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">요일</label>
                    <select class="form-select" name="day" required>
                        <option selected disabled value="">선택하세요</option>
                        <option value="MON">월요일</option>
                        <option value="TUE">화요일</option>
                        <option value="WED">수요일</option>
                        <option value="THU">목요일</option>
                        <option value="FRI">금요일</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">교시</label>
                    <select class="form-select" name="period" required>
                        <option selected disabled value="">선택하세요</option>
                        <% for (int i = 1; i <= 5; i++) { %>
                            <option value="<%= i %>"><%= i %>교시</option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">과목명</label>
                    <select class="form-select" name="subject" required>
                        <option selected disabled value="">선택하세요</option>
                        <option>데이터베이스</option>
                        <option>웹서버컴퓨팅</option>
                        <option>네트워크프로그래밍</option>
                        <option>자료구조및실습</option>
                        <option>시스템프로그래밍</option>
                        <option>스프링프레임워크</option>
                        <option>자바프로그래밍</option>
                    </select>
                </div>
                <button class="btn btn-primary w-100">등록</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
