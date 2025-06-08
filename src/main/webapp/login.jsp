<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>[StudyMate 로그인]</title>
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
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

        .login-card {
            background: #ffffff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 420px;
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
            height: 48px;
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
    <div class="login-card">
       
        <div class="logo-wrapper">
            <img src="<%= request.getContextPath() %>/resources/images/studymate logo.png" alt="StudyMate Logo" />
        </div>

        
        <h4 class="text-center fw-bold mb-4">로그인</h4>

        <!-- 로그인 폼 -->
        <form action="login" method="post">
            <div class="mb-3">
                <input type="text" name="userId" class="form-control" placeholder="아이디를 입력해주세요." required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="비밀번호를 입력해주세요." required>
            </div>
            <button type="submit" class="btn btn-primary w-100">로그인</button>
        </form>

        <!-- 회원가입 이동-->
        <p class="form-text text-center mt-4">
            계정이 없으신가요? <a href="register.jsp">회원가입</a>
        </p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
