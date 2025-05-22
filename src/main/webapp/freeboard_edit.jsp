<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(postId);

    String loginUserId = (String) session.getAttribute("userId");
    if (post == null || !loginUserId.equals(post.getWriterId())) {
        response.sendRedirect("freeboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>글 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=2">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp"/>
    
     <!-- ✅ 언어 전환 스위치 -->
    <div class="form-check form-switch text-end mb-3">
        <input class="form-check-input" type="checkbox" id="langSwitch">
        <label class="form-check-label" for="langSwitch">English</label>
    </div>
    
    <h3 id="editTitle" class="fw-bold mb-4">✏ 글 수정</h3>

    <form action="freeboard_update.jsp" method="post">
        <input type="hidden" name="id" value="<%= post.getPostId() %>">

        <div class="mb-3">
            <label id="labelEditTitle">제목</label>
            <input type="text" id="inputEditTitle" name="title" class="form-control" value="<%= post.getTitle() %>">
        </div>

        <div class="mb-3">
            <label id="labelEditContent">내용</label>
            <textarea id="inputEditContent" name="content" class="form-control" rows="8"><%= post.getContent() %></textarea>
        </div>

        <div class="text-end">
            <button id="btnEditSubmit" type="submit" class="btn btn-primary">수정 완료</button>
            <a id="btnEditCancel" href="freeboard.jsp" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>
<script>
    const USER_ID = "<%= session.getAttribute("userId") %>";
    const USER_NAME = "<%= session.getAttribute("userName") %>";
</script>
<script src="resources/js/lang.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const langSwitch = document.getElementById("langSwitch");
        if (langSwitch?.checked) {
            toggleLanguage();
        }
        langSwitch?.addEventListener("change", toggleLanguage);
    });
</script>
</body>
</html>
