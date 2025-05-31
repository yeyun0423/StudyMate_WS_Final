<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardPostDAO, dto.BoardPostDTO, java.net.URLEncoder" %>
<%
    request.setCharacterEncoding("UTF-8");

    int postId = Integer.parseInt(request.getParameter("id"));
    BoardPostDTO post = new BoardPostDAO().getPostById(postId);

    String loginUserId = (String) session.getAttribute("userId");

    if (post == null || !"RESOURCE".equals(post.getBoardType())) {
        response.sendRedirect("resourceboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자료실</title>
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .btn-secondary, .btn-warning, .btn-danger {
            border-radius: 12px;
        }
        .form-control[readonly] {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-4">📚 자료실</h3>

        <div class="mb-3">
            <label class="form-label fw-bold" id="labelResourceTitle">제목</label>
            <p class="form-control" readonly><%= post.getTitle() %></p>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold" id="labelResourceWriter">작성자</label>
            <p class="form-control" readonly id="resourceWriterName"><%= post.getWriterName() %></p>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold" id="labelResourceFile">첨부파일</label>
            <p class="form-control" id="resourceFileArea">
                <% if (post.getFilename() != null && !post.getFilename().isEmpty()) { %>
                    <a id="resourceFileLink"
                       href="<%= request.getContextPath() %>/DownloadServlet?file=<%= URLEncoder.encode(post.getFilename(), "UTF-8") %>">
                        <%= post.getFilename().substring(post.getFilename().indexOf("_") + 1) %>
                    </a>
                <% } else { %>
                    <span id="noFileText">첨부파일 없음</span>
                <% } %>
            </p>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold" id="labelResourceContent">내용</label>
            <p class="form-control text-start" style="min-height: 200px; margin: 0; line-height: 1.4;" readonly><%= post.getContent().trim() %></p>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a id="btnBack" href="resourceboard.jsp" class="btn btn-secondary">목록으로</a>

            <% if (loginUserId != null && loginUserId.equals(post.getWriterId())) { %>
                <div class="d-flex gap-2">
                    <form action="resourceboard_edit.jsp" method="get">
                        <input type="hidden" name="id" value="<%= post.getPostId() %>">
                        <button id="btnEdit" type="submit" class="btn btn-warning btn-sm">수정</button>
                    </form>
                    <form action="resourceboard_delete.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="id" value="<%= post.getPostId() %>">
                        <button id="btnDelete" type="submit" class="btn btn-danger btn-sm">삭제</button>
                    </form>
                </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    const USER_ID = "<%= session.getAttribute("userId") %>";
    const USER_NAME = "<%= session.getAttribute("userName") %>";
</script>
<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
