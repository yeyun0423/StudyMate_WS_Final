<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
  <title>mypage</title>

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
</head>
<body class="bg-light py-4">
<%@ include file="navbar.jsp"%>

  <div class="container mt-4" style="max-width: 800px;">
    <div class="row g-4">

      <!-- 프로필 이미지 영역 -->
      <div class="col-md-4 text-center">
        <div class="border rounded p-2 bg-white">
          <img src="${pageContext.request.contextPath}/resources/images/프로필 기본 이미지.png"
               alt="Profile Image"
               class="img-fluid rounded" style="max-height: 250px;">
        </div>

        <!-- 이미지 업로드 버튼 -->
        <div class="input-group mt-2">
          <input type="file" class="form-control" id="inputGroupFile02">
          <label class="input-group-text" for="inputGroupFile02">
            <i class="bi bi-upload"></i> 업로드
          </label>
        </div>
      </div>

      <!-- 입력 폼 영역 -->
      <div class="col-md-8 bg-white p-4 rounded shadow-sm">

        <!-- 이름 -->
        <div class="mb-3">
          <input type="text" class="form-control" value="최예윤">
        </div>

        <!-- 아이디 -->
        <div class="mb-3">
          <input type="text" class="form-control" value="maru">
        </div>

        <!-- 생년월일 -->
        <div class="mb-3">
          <label for="birthDate" class="form-label" >생년월일</label>
          <input type="date" class="form-control" value="2003-04-23">
        </div>

        <!-- 현재 비밀번호 -->
        <div class="mb-3">
          <label class="form-label">현재 비밀번호</label>
          <div class="input-group">
            <input type="password" class="form-control" id="currentPassword" placeholder="현재 비밀번호를 입력하세요">
            <button class="btn btn-outline-secondary toggle-password" type="button" data-target="#currentPassword">
              <i class="bi bi-eye"></i>
            </button>
          </div>
        </div>

        <!-- 새 비밀번호 -->
        <div class="mb-3">
          <label class="form-label">새 비밀번호</label>
          <div class="input-group">
            <input type="password" class="form-control" id="newPassword" placeholder="새 비밀번호를 입력하세요">
            <button class="btn btn-outline-secondary toggle-password" type="button" data-target="#newPassword">
              <i class="bi bi-eye"></i>
            </button>
          </div>
          <div class="form-text">비밀번호는 8자 이상, 영문자와 숫자를 포함해야 합니다.</div>
        </div>

        <!-- 새 비밀번호 확인 -->
        <div class="mb-3">
          <label class="form-label">새 비밀번호 확인</label>
          <div class="input-group">
            <input type="password" class="form-control" id="confirmPassword" placeholder="새 비밀번호를 다시 입력하세요">
            <button class="btn btn-outline-secondary toggle-password" type="button" data-target="#confirmPassword">
              <i class="bi bi-eye"></i>
            </button>
          </div>
        </div>

        <!-- 저장 버튼 -->
        <button class="btn btn-primary w-100">저장하기</button>
      </div>
    </div>
  </div>

<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

</body>
</html>
