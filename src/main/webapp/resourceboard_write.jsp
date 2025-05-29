<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
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

    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 자료실 글쓰기</title>
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
        .btn-outline-primary {
            border-radius: 12px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <h3 class="fw-bold mb-4">📁 자료실 글쓰기</h3>

        <form method="post" action="resourceboard_save.jsp" enctype="multipart/form-data">
            <input type="hidden" name="writer" value="<%= userId %>">

            <div class="mb-3">
                <p><strong id="resourcelabelWriter">작성자:</strong> <span id="writerName"><%= userName %></span></p>
            </div>

            <div class="mb-3">
                <label for="inputTitle" id="resourcelabelTitle" class="form-label fw-bold">제목</label>
                <input type="text" name="title" class="form-control" id="inputTitle" placeholder="제목을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label for="inputContent" id="resourcelabelContent" class="form-label fw-bold">내용</label>
                <textarea name="content" class="form-control" id="inputContent" placeholder="내용을 입력하세요" rows="5" required></textarea>
            </div>

            <div class="mb-4">
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
</div>

<script>
    const USER_ID = "<%= userId %>";
    const USER_NAME = "<%= userName %>";

    document.getElementById("inputFile").addEventListener("change", function () {
        const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
        document.getElementById("fileNameDisplay").textContent = fileName;
    });
</script>
<script src="resources/js/lang.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
