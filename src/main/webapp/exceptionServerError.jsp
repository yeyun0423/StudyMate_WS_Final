<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>서버 오류</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'SUIT', sans-serif; }
        body {
            background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff);
            margin: 0;
            padding: 0;
        }
        .section-box {
            background: white;
            border-radius: 16px;
            height: 400px;
            padding: 0;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
            margin-top: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .error-title {
            font-size: 32px;
            font-weight: 700;
            color: #dc3545;
        }
        .error-desc {
            font-size: 18px;
            margin-top: 12px;
        }
        .error-btn {
            margin-top: 24px;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <%@ include file="navbar.jsp" %>

        <div class="section-box">
            <div class="error-title">⚠️ 서버 오류가 발생했습니다</div>
            <div class="error-desc">요청을 처리하는 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.</div>
            <div class="error-btn">
                <a href="home.jsp" class="btn btn-primary px-4">🏠 홈으로 돌아가기</a>
            </div>
        </div>
    </div>
</body>
</html>
