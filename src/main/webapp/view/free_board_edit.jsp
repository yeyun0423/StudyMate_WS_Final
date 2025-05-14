<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>자유게시판 글 수정</title>
</head>
<body class="bg-light">
  <%@ include file="navbar.jsp" %>

  <main class="container mt-5" style="max-width: 700px;">
    <div class="card shadow-sm rounded-4 p-4">
      <h2 class="text-center mb-4 fw-bold" style="color:#052c65">글 수정</h2>

      <%
        // 임시로 사용되는 예시 데이터 (실제로 DB에서 가져오거나 request로 데이터를 받음)
        String title = request.getParameter("title");
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");
        String date = request.getParameter("date");
        String postId = request.getParameter("postId"); // 수정할 글의 ID (DB에서 필요)

        if (title == null || writer == null || content == null || date == null) {
          title = "제목 없음";
          writer = "작성자 없음";
          content = "내용 없음";
          date = "날짜 없음";
        }
      %>

      <form action="freeboardUpdate.jsp" method="post">
        <input type="hidden" name="postId" value="<%= postId %>" />

        <div class="mb-3">
          <label for="title" class="form-label">제목</label>
          <input type="text" class="form-control" id="title" name="title" value="<%= title %>" required>
        </div>

        <div class="mb-3">
          <label for="content" class="form-label">내용</label>
          <textarea class="form-control" id="content" name="content" rows="5" required><%= content %></textarea>
        </div>

        <div class="mb-3">
          <label for="writer" class="form-label">작성자</label>
          <input type="text" class="form-control" id="writer" name="writer" value="<%= writer %>" disabled>
        </div>

        <div class="mb-3">
          <label for="date" class="form-label">작성일</label>
          <input type="text" class="form-control" id="date" name="date" value="<%= date %>" disabled>
        </div>

        <button type="submit" class="btn btn-primary w-100 mb-3">수정 완료</button>
        <a href="freeboardList.jsp" class="btn btn-outline-secondary w-100">목록으로 돌아가기</a>
      </form>
    </div>
  </main>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
