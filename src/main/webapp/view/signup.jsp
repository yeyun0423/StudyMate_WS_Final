<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>signUp</title>
</head>
<body class="bg-light d-flex justify-content-center align-items-center" style="height: 100vh;">
  <div class="card rounded-4 p-4 shadow-sm" style="width: 100%; max-width: 420px; border: 3px solid #0a58ca;">
  <%--   <div class="text-center mb-3">
      <img src="${pageContext.request.contextPath}/resources/img/signup_icon.png" alt="회원가입 아이콘" class="img-fluid" style="max-width: 60px;">
    </div> --%>
    <h2 class="text-center fw-bold mb-4"style="color:#052c65">회원가입</h2>

    <form action="signup.do" method="post">
      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
        <label for="name">이름을 입력하세요</label>
      </div>

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="username" name="username" placeholder="아이디" required>
        <label for="username">아이디를 입력하세요</label>
      </div>

      <div class="form-floating mb-3">
        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
        <label for="password">비밀번호를 입력하세요</label>
      </div>

      <div class="form-floating mb-3">
        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
        <label for="confirmPassword">비밀번호를 재입력 해주세요</label>
      </div>

      <!-- 생년월일 달력 입력 -->
      <div class="mb-3">
        <label for="birthDate" class="form-label">생년월일</label>
        <input type="date" class="form-control" id="birthDate" name="birthDate" required>
      </div>

      <!-- 관리자 여부 스위치 -->
      <div class="form-check form-switch mb-4">
        <input class="form-check-input" type="checkbox" id="isAdmin" name="isAdmin">
        <label class="form-check-label" for="isAdmin">관리자인가요?</label>

        <!-- 관리자용 필드 -->
        <div class="mb-3" id="adminFields" style="display: none;">
          <label for="adminCode" class="form-label"></label>
          <input type="password" class="form-control" id="adminCode" name="adminCode" placeholder="관리자 인증코드">
        </div>  
      </div>

      <button type="submit" class="btn w-100 mb-2" style="background-color: #0a58ca; color: white;">회원가입</button>
    </form>

    <div class="text-center text-muted mt-2" style="font-size: 0.9rem;">
      회원이신가요? <a href="${pageContext.request.contextPath}/view/login.jsp" class="text-decoration-none">로그인</a>
    </div>
  </div>
    <script src="${pageContext.request.contextPath}/resources/js/signup_admin.js"></script>
</body>
</html>
