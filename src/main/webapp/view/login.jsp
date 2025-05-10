<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate 로그인</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            width: 500px;
            padding: 60px 40px;
            border: 2px solid #000;
            border-radius: 24px;
            box-sizing: border-box;
            text-align: center;
        }

        .logo {
            width: 80%;
            max-width : 280px;
            margin-bottom: 0px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 34px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 16px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .login-button {
            width: 100%;
            padding: 16px;
            background-color: #000;
            color: #fff;
            font-weight: bold;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .login-button:hover {
            background-color: #333;
        }

        .signup-link {
            margin-top: 25px;
            font-size: 15px;
            color: #777;
        }

        .signup-link a {
            color: #777;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="<%= request.getContextPath() %>/resources/images/studymate_logo.png" alt="StudyMate Logo" class="logo">
        <h2>로그인</h2>
        <form action="loginProcess.jsp" method="post">
            <input type="text" name="email" placeholder="이메일을 입력하세요" required>
            <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
            <button type="submit" class="login-button">로그인</button>
        </form>
        <div class="signup-link">
            회원이 아니신가요? <a href="signup.jsp">회원가입</a>
        </div>
    </div>
</body>
</html>
