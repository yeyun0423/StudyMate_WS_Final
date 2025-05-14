<%@ page contentType="text/html; charset=utf-8" %>


<html>
<head>
  <title>자유게시판 글쓰기</title>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
</head>
<body class="bg-light">
  <main class="container my-4">
  <%@ include file="navbar.jsp" %>
    <div class="p-4 bg-body rounded shadow-sm">
      <h6 class="border-bottom pb-2 mb-4 fw-bold">✍ 자유게시판 글쓰기</h6>

      <form action="freeboardWriteAction.jsp" method="post">
        <div class="mb-3">
          <label for="title" class="form-label">제목</label>
          <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" required />
        </div>

        <div class="mb-3">
          <label for="writer" class="form-label">작성자</label>
          <input type="text" class="form-control" id="writer" name="writer" placeholder="작성자 이름" required />
        </div>

        <div class="mb-3">
          <label for="content" class="form-label">내용</label>
          <textarea class="form-control" id="content" name="content" rows="6" placeholder="내용을 입력하세요" required></textarea>
        </div>

        <div class="d-flex justify-content-between">
          <a href="${pageContext.request.contextPath}/view/free_board_list.jsp" class="btn btn-secondary">목록으로</a>
          <button type="submit" class="btn btn-primary">작성 완료</button>
        </div>
      </form>
    </div>
  </main>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
