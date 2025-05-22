<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>자료실 글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/home.css?v=1">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 id="resourcewriteTitle" class="fw-bold mb-4">📁 자료실 글쓰기</h3>

    <form method="post" action="resourceboard_save.jsp" enctype="multipart/form-data">
        <input type="hidden" name="writer" value="<%= session.getAttribute("userId") %>">
        <p><strong id="resourcelabelWriter">작성자:</strong> 
            <span id="writerName"><%= session.getAttribute("userName") %></span>
        </p>

        <div class="mb-3">
            <label id="resourcelabelTitle" class="form-label fw-bold">제목</label>
            <input type="text" name="title" class="form-control" id="inputTitle" placeholder="제목을 입력하세요" required>
        </div>

        <div class="mb-3">
            <label id="resourcelabelContent" class="form-label fw-bold">내용</label>
            <textarea name="content" class="form-control" id="inputContent" placeholder="내용을 입력하세요" rows="5" required></textarea>
        </div>

        <div class="mb-3">
    <label id="resourcelabelFile" class="form-label fw-bold">첨부파일</label><br>
    <label for="inputFile" class="btn btn-outline-primary btn-sm" id="filenameLabel">파일 선택</label>
    <span id="fileNameDisplay" class="ms-2">선택된 파일 없음</span>
    <input type="file" name="uploadFile" class="d-none" id="inputFile">
</div>


        <div class="d-flex justify-content-between">
            <a id="btnBack" href="resourceboard.jsp" class="btn btn-secondary">목록으로</a>
            <button id="btnSubmit" type="submit" class="btn btn-primary">작성 완료</button>
        </div>
    </form>
</div>

<script>
    const USER_ID = "<%= session.getAttribute("userId") %>";
    const USER_NAME = "<%= session.getAttribute("userName") %>";
</script>
<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
