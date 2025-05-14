<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>Login</title>
</head>
<body class="bg-light d-flex justify-content-center align-items-center" style="height: 100vh;">
  <div class="card rounded-4 p-4 shadow-sm" style="width: 100%; max-width: 400px; border: 3px solid #0a58ca;">
   <%--  <div class="text-center mb-3">
      <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="로고" class="img-fluid" style="max-width: 100px;">
    </div> --%>
    <h2 class="text-center fw-bold mb-4"style="color:#052c65">로그인</h2>

    <%
      String error = request.getParameter("error");
      if (error != null) {
    %>
    <div class="alert alert-danger text-center">아이디와 비밀번호를 확인해 주세요</div>
    <%
      }
    %>

    <form action="j_security_check" method="post">
      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="floatingUsername" name="j_username" placeholder="아이디" required>
        <label for="floatingUsername">아이디를 입력하세요</label>
      </div>
      
      <div class="form-floating mb-3">
        <input type="password" class="form-control" id="floatingPassword" name="j_password" placeholder="비밀번호" required>
        <label for="floatingPassword">비밀번호를 입력하세요</label>
      </div>
      
      <button type="submit" class="w-100 mb-2" 
              style="background-color: #0a58ca; color: white; border: none;">
        로그인
      </button>
    </form>

    <div class="text-center text-muted mt-2" style="font-size: 0.9rem;">
      회원이 아니신가요? <a href="${pageContext.request.contextPath}/view/signup.jsp" class="text-decoration-none">회원가입</a>
    </div>
  </div>
</body>
</html>
