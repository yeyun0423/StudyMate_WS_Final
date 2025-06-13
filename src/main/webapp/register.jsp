<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>[StudyMate 회원가입]</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        * {
            font-family: 'SUIT', sans-serif;
        }

        body {
            background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-card {
            background: #ffffff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 460px;
        }

        .logo-wrapper {
            height: 150px;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .logo-wrapper img {
            max-height: 100%;
        }

        .form-control {
            border-radius: 12px;
            height: 46px;
        }

        .btn-primary {
            border-radius: 12px;
            height: 48px;
            font-weight: 600;
            background-color: #4f46e5;
            border: none;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        .btn-secondary {
            border-radius: 12px;
            height: 46px;
        }

        .form-text a {
            color: #4f46e5;
            font-weight: 600;
            text-decoration: none;
        }

        .form-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<div class="register-card text-center">
 
    <div class="logo-wrapper">
        <img src="resources/images/studymate logo.png" alt="StudyMate Logo" />
    </div>

  
    <h4 class="fw-bold mb-4">회원가입</h4>


    <form action="register" method="post">
        <div class="mb-3">
            <input type="text" name="name" class="form-control" placeholder="이름을 입력하세요." required>
        </div>

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

        <button type="submit" class="btn btn-primary w-100">회원가입</button>
    </form>

    <p class="form-text mt-4">
        이미 회원이신가요? <a href="login.jsp">로그인 화면으로</a>
    </p>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/register.js"></script>
</body>
</html>
