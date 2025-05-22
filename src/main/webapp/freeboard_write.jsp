<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String title = request.getParameter("title");
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");

        BoardPostDTO post = new BoardPostDTO();
        post.setBoardType("FREE");
        post.setTitle(title);
        post.setWriterId(writer);
        post.setContent(content);

        new BoardPostDAO().insertPost(post);
%>
<script>
    if (confirm("글이 정상적으로 등록되었습니다!")) {
        location.href = "freeboard.jsp";
    } else {
        history.back();
    }
</script>
<% return; } %>

<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판 글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/home.css?v=1">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>

    <h3 id="writeTitle" class="fw-bold mb-4">✍ 자유게시판 글쓰기</h3>

    <form method="post" action="freeboard_write.jsp">
    <div class="mb-3">
           <input type="hidden" name="writer" value="<%= session.getAttribute("userId") %>">
<p><strong id="labelWriter">작성자:</strong> <span id="writerName"><%= session.getAttribute("userName") %></span></p>

        </div>
    
        <div class="mb-3">
            <label id="labelTitle" class="form-label fw-bold">제목</label>
            <input type="text" name="title" class="form-control" id="inputTitle" placeholder="제목을 입력하세요">
        </div>

        
        <div class="mb-3">
            <label id="labelContent" class="form-label fw-bold">내용</label>
            <textarea name="content" class="form-control" id="inputContent" placeholder="내용을 입력하세요" rows="5"></textarea>
        </div>

        <div class="d-flex justify-content-between">
            <a id ="btnBack" href="freeboard.jsp" class="btn btn-secondary">목록으로</a>
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
