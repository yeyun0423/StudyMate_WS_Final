<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<%
    String userName = (String) session.getAttribute("userName");
    if (userName == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("user_name".equals(c.getName())) {
                    userName = c.getValue();
                    break;
                }
            }
        }
    }
    String userId = (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 질문 작성</title>
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
        .btn-secondary {
            border-radius: 12px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp"/>

    <div class="section-card">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="fw-bold mb-0">✏️ 질문 작성</h3>
        </div>

        <form action="QnABoardWriteServlet" method="post">
            <input type="hidden" name="writer" value="<%= userId %>">
            <p class="mb-3"><strong id="labelWriter">작성자:</strong> <span id="writerName"><%= userName != null ? userName : "알 수 없음" %></span></p>

            <div class="mb-3">
                <label class="form-label fw-bold" for="inputTitle">제목</label>
                <input type="text" id="inputTitle" name="title" class="form-control" placeholder="제목을 입력하세요." required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold" for="inputContent">내용</label>
                <textarea id="inputContent" name="content" class="form-control" rows="6" placeholder="내용을 입력하세요." required></textarea>
            </div>

            <div class="form-check mb-4">
                <input type="checkbox" class="form-check-input" id="privateCheck" name="isPrivate">
                <label class="form-check-label" for="privateCheck">🔒 비공개 질문으로 작성</label>
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-primary">등록</button>
                <a href="qnaboard.jsp" class="btn btn-secondary ms-2">목록으로</a>
            </div>
        </form>
    </div>
</div>

<script>
    const USER_ID = "<%= userId %>";
    const USER_NAME = "<%= userName %>";
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
