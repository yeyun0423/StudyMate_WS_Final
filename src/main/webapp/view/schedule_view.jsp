<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>

<%
  
  Map<String, String[]> timetable = new HashMap<>();
  timetable.put("월요일", new String[]{"자료구조", "", "운영체제", ""});
  timetable.put("화요일", new String[]{"", "", "", ""});
  timetable.put("수요일", new String[]{"", "웹프로그래밍", "", ""});
  timetable.put("목요일", new String[]{"데이터베이스", "", "", ""});
  timetable.put("금요일", new String[]{"", "", "", "소프트웨어공학"});
%>

<html>
<head>
  <title>시간표 보기</title>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/schedule_view.css" />
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>

<main class="container my-4">
  <div class="p-3 bg-body rounded shadow-sm">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h6 class="fw-bold border-bottom pb-2">📅 내 시간표</h6>
      <button class="btn btn-primary rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#addTimetableModal">
        ＋ 추가
      </button>
    </div>

    <div class="table-responsive">
      <table class="table table-bordered">
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
        <% for(int i = 0; i < 4; i++) { %>
          <tr>
            <td class="fw-semibold text-center"><%= (i + 1) %>교시</td>
            <td class="timetable-cell"><%= timetable.get("월요일")[i] %></td>
            <td class="timetable-cell"><%= timetable.get("화요일")[i] %></td>
            <td class="timetable-cell"><%= timetable.get("수요일")[i] %></td>
            <td class="timetable-cell"><%= timetable.get("목요일")[i] %></td>
            <td class="timetable-cell"><%= timetable.get("금요일")[i] %></td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<%@ include file="schedule_add_modal.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
