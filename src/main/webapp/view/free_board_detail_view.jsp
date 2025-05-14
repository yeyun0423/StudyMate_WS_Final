<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>자유게시판 글 상세보기</title>
</head>
<body class="bg-light">
  <%@ include file="navbar.jsp" %>

  <main class="container mt-5" style="max-width: 700px;">
    <div class="card shadow-sm rounded-4 p-4">
      <h2 class="text-center mb-4 fw-bold" style="color:#052c65">글 상세보기</h2>

      <%
        // 임시로 사용되는 예시 데이터 (실제로 DB에서 가져오거나 request로 데이터를 받음)
        String title = request.getParameter("title");
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");
        String date = request.getParameter("date");

        if (title == null || writer == null || content == null || date == null) {
          title = "제목 없음";
          writer = "작성자 없음";
          content = "내용 없음";
          date = "날짜 없음";
        }
      %>

      <div class="mb-3">
        <strong>제목: </strong>
        <span><%= title %></span>
      </div>

      <div class="mb-3">
        <strong>작성자: </strong>
        <span><%= writer %></span>
      </div>

      <div class="mb-3">
        <strong>작성일: </strong>
        <span><%= date %></span>
      </div>

      <div class="mb-3">
        <strong>내용: </strong>
        <p><%= content %></p>
      </div>

      <a href="freeboardList.jsp" class="btn btn-outline-primary">목록으로 돌아가기</a>
      <a href="freeboardWrite.jsp" class="btn btn-outline-secondary">글 수정</a>
    </div>
  </main>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
