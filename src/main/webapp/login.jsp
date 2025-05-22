<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String msg = request.getParameter("message");
    if ("deleted".equals(msg)) {
%>
<script>
    alert("회원 탈퇴가 완료되었습니다.");
</script>
<%
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate 로그인</title>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f6fa;
        }
        .login-card {
            width: 100%;
            max-width: 420px;
            border-radius: 16px;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center min-vh-100">

<div class="card p-4 shadow-sm login-card">
    <!-- 로고 -->
    <div class="d-flex justify-content-center align-items-center mb-3" style="height: 160px;">
        <img src="resources/images/studymate logo.png" alt="StudyMate Logo" class="img-fluid" style="max-height: 100%;">
    </div>

    <!-- 로그인 타이틀 -->
    <h4 class="text-center fw-bold mb-4">로그인</h4>

    <!-- 로그인 폼 -->
    <form action="login" method="post">
        <div class="mb-3">
            <input type="text" name="userId" class="form-control" placeholder="아이디를 입력하세요." required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요." required>
        </div>
        <button type="submit" class="btn btn-primary w-100 fw-bold">로그인</button>
    </form>

    <!-- 회원가입 링크 -->
    <p class="text-center mt-3 mb-0" style="font-size: 14px;">
        회원이 아니신가요? <a href="register.jsp" class="text-decoration-none fw-semibold text-primary">회원가입</a>
    </p>
</div>

<script src="resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
