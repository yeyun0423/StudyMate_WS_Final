<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            margin: 0;
        }

        .signup-container {
            width: 500px;
            padding: 60px 40px;
            border: 2px solid #000;
            border-radius: 24px;
            box-sizing: border-box;
            position: relative;
            text-align: center;
        }

        .signup-header {
            margin-bottom: 30px;
        }

        .signup-header img {
            width: 70px;
            vertical-align: middle;
        }

        .signup-header h2 {
            display: inline-block;
            margin: 0 10px;
            font-size: 34px;
            font-weight: bold;
            position: relative;
            top: 10px;
        }

        .signup-form input {
            width: 100%;
            padding: 16px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .dob-container {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .dob-container input {
            flex: 1;
        }

        .signup-button {
            background-color: black;
            color: white;
            border: none;
            padding: 16px;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
            border-radius: 8px;
            cursor: pointer;
        }

        .signup-button:hover {
            background-color: #333;
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            font-size: 15px;
            color: #777;
        }

        .login-link a {
            text-decoration: underline;
            color: #777;
        }

        .login-link a:hover {
            text-decoration: none;
        }

        .logo {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 95px;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <img src="${pageContext.request.contextPath}/resources/images/signup_icon.png" alt="회원가입 아이콘">
            <h2>회원가입</h2>
        </div>
        <form class="signup-form" action="signup_process.jsp" method="post">
            <input type="text" name="name" placeholder="이름을 입력하세요" required>
            <input type="email" name="email" placeholder="이메일을 입력하세요" required>
            <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
            <input type="password" name="confirmPassword" placeholder="비밀번호를 재입력 해주세요" required>
            <div class="dob-container">
                <input type="text" name="year" placeholder="년" required>
                <input type="text" name="month" placeholder="월" required>
                <input type="text" name="day" placeholder="일" required>
            </div>
            <input type="text" name="interest" placeholder="관심 스터디 분야:" required>
            <button class="signup-button" type="submit">회원가입</button>
        </form>
        <div class="login-link">
            이미 회원이신가요? <a href="login.jsp">로그인</a>
        </div>
        <img class="logo" src="${pageContext.request.contextPath}/resources/images/studymate_logo.png" alt="StudyMate 로고">
    </div>
</body>
</html>
