<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TimetableDAO, dto.TimetableDTO, java.util.*" %>
<%
    String userId = (String) session.getAttribute("userId");
    String userName = null;
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    // 쿠키에서 user_name 값 가져오기
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) {
                userName = c.getValue();
                break;
            }
        }
    }

    // 로그인 여부 확인
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
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 시간표</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=1">

</head>
<body class="bg-light">

<div class="container py-4">

    <jsp:include page="navbar.jsp" />

    <!-- 시간표 영역 -->
    <div class="card p-4 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold" id="titleTimetable">내 시간표</h5>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#timetableModal" id="btnAdd">+ 추가</button>
        </div>
        <table class="table text-center align-middle">
            <thead class="table-primary">
                <tr>
                    <th id="colPeriod">교시</th>
                    <th id="colMon">월요일</th>
                    <th id="colTue">화요일</th>
                    <th id="colWed">수요일</th>
                    <th id="colThu">목요일</th>
                    <th id="colFri">금요일</th>
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
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- 시간표 추가 모달 -->
<div class="modal fade" id="timetableModal" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content p-4" action="timetable" method="post">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold" id="modalTitle">시간표 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label" id="labelDay">요일</label>
                    <select class="form-select" name="day" required>
                        <option selected disabled value="">선택하세요</option>
                        <option value="MON" id="optionMon">월요일</option>
                        <option value="TUE" id="optionTue">화요일</option>
                        <option value="WED" id="optionWed">수요일</option>
                        <option value="THU" id="optionThu">목요일</option>
                        <option value="FRI" id="optionFri">금요일</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label" id="labelPeriod">교시</label>
                    <select class="form-select" name="period" required>
                        <option selected disabled value="">선택하세요</option>
                        <option value="1" id="option1st">1교시</option>
                        <option value="2" id="option2nd">2교시</option>
                        <option value="3" id="option3rd">3교시</option>
                        <option value="4" id="option4th">4교시</option>
                        <option value="5" id="option5th">5교시</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label" id="labelSubject">과목명</label>
                    <select class="form-select" name="subject" required>
                        <option selected disabled value="">선택하세요</option>
                        <option id="subject1">데이터베이스</option>
                        <option id="subject2">웹서버컴퓨팅</option>
                        <option id="subject3">네트워크프로그래밍</option>
                        <option id="subject4">자료구조및실습</option>
                        <option id="subject5">시스템프로그래밍</option>
                        <option id="subject6">스프링프레임워크</option>
                        <option id="subject7">자바프로그래밍</option>
                    </select>
                </div>

                <button class="btn btn-primary w-100" id="btnSubmit">등록</button>
            </div>
        </form>
    </div>
</div>
<script>
	const USER_NAME = "<%= userName %>";
	const USER_ID = "<%= userId %>";
</script>
<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
