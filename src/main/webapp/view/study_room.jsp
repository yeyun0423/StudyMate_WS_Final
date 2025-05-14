<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>홈</title>
</head>
<body>
  <%@ include file="navbar.jsp"%>
  
  <main class="container my-5">
    <div class="my-3 p-3 bg-body rounded shadow-sm">
      <h6 class="border-bottom pb-2 mb-0">내가 가입한 스터디 그룹</h6>

      <!-- 스터디 그룹 항목들 -->
      <div class="d-flex text-body-secondary pt-3">
        <svg aria-label="Placeholder: 32x32" class="bd-placeholder-img flex-shrink-0 me-2 rounded" height="32" width="32" xmlns="http://www.w3.org/2000/svg">
          <rect width="100%" height="100%" fill="#007bff"></rect>
          <text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text>
        </svg>
        <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
          <strong class="d-block text-gray-dark">@username</strong>
          Some representative placeholder content, with some information about this user. Imagine this being some sort of status update, perhaps?
        </div>
      </div>

      <div class="d-flex text-body-secondary pt-3">
        <svg aria-label="Placeholder: 32x32" class="bd-placeholder-img flex-shrink-0 me-2 rounded" height="32" width="32" xmlns="http://www.w3.org/2000/svg">
          <rect width="100%" height="100%" fill="#e83e8c"></rect>
          <text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text>
        </svg>
        <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
          <strong class="d-block text-gray-dark">@username</strong>
          Some more representative placeholder content, related to this other user. Another status update, perhaps.
        </div>
      </div>

      <div class="d-flex text-body-secondary pt-3">
        <svg aria-label="Placeholder: 32x32" class="bd-placeholder-img flex-shrink-0 me-2 rounded" height="32" width="32" xmlns="http://www.w3.org/2000/svg">
          <rect width="100%" height="100%" fill="#6f42c1"></rect>
          <text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text>
        </svg>
        <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
          <strong class="d-block text-gray-dark">@username</strong>
          This user also gets some representative placeholder content. Maybe they did something interesting, and you really want to highlight this in the recent updates.
        </div>
      </div>

      <small class="d-block text-end mt-3">
        <a href="#">모든 업데이트 보기</a>
      </small>
    </div>
  </main>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
