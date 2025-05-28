<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate 회원가입</title>
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!--   <link rel="stylesheet" href="resources/css/bootstrap.min.css"> -->
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">

<div class="container" style="max-width: 440px;">
    <div class="bg-white p-4 rounded-4 shadow-sm text-center">
        <!-- 로고 -->
        <div class="mb-4">
            <img src="resources/images/studymate logo.png" alt="StudyMate Logo" class="img-fluid" style="max-height: 170px;">
        </div>

        <!-- 제목 -->
        <h2 class="fw-bold mb-4">회원가입</h2>

        <!-- 폼 -->
        <form action="register" method="post">
            <div class="mb-3">
                <input type="text" name="name" class="form-control" placeholder="이름을 입력하세요." required>
            </div>

            <!-- 아이디 + 중복 확인 -->
            <div class="row g-2 mb-2">
                <div class="col-8">
                    <input type="text" name="userId" id="userId" class="form-control" placeholder="아이디를 입력하세요." required>
                </div>
                <div class="col-4">
                    <button type="button" class="btn btn-secondary w-100" onclick="checkDuplicateId()">중복 확인</button>
                </div>
            </div>

            <div class="mb-3">
                <span id="idCheckResult" class="text-danger small"></span>
            </div>

            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요." required>
            </div>
            <div class="mb-3">
                <input type="password" name="password2" class="form-control" placeholder="비밀번호 재입력 해주세요." required>
            </div>
            <div class="mb-3">
                <input type="date" name="birthDate" class="form-control" required>
            </div>
            <div class="mb-4">
                <input type="text" name="adminCode" class="form-control" placeholder="관리자 코드 (선택)">
            </div>

            <button type="submit" class="btn btn-primary w-100 fw-bold">회원가입</button>
        </form>

        <p class="mt-3 small">
            이미 회원이신가요? <a href="login.jsp" class="text-decoration-none fw-semibold text-primary">로그인 화면으로</a>
        </p>
    </div>
</div>

<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/register.js"></script>
</body>
</html>
