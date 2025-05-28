<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<html>
<head>
    <title>Q&A 글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 class="fw-bold mb-4">✏️ 질문 작성</h3>
    
    <div class="mb-3">
           <input type="hidden" name="writer" value="<%= session.getAttribute("userId") %>">
<p><strong id="labelWriter">작성자:</strong> <span id="writerName"><%= session.getAttribute("userName") %></span></p>

        </div>

    <form action="QnABoardWriteServlet" method="post">
        <div class="mb-3">
            <label class="form-label fw-bold">제목</label>
            <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요." required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-bold">내용</label>
            <textarea name="content" class="form-control" rows="6" placeholder="내용을 입력하세요." required></textarea>
        </div>
        <div class="form-check mb-4">
            <input type="checkbox" class="form-check-input" id="privateCheck" name="isPrivate">
            <label class="form-check-label" for="privateCheck">
                🔒 비공개 질문으로 작성
            </label>
        </div>
        <div class="text-end">
            <button type="submit" class="btn btn-primary">등록</button>
            <a href="qnaboard.jsp" class="btn btn-secondary ms-2">목록으로</a>
        </div>
    </form>
</div>

<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
