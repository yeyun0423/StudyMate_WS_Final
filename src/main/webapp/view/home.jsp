<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css" />
  <title>홈</title>
</head>
<body>
  <%@ include file="navbar.jsp"%>

  <main class="container my-5">
    <%@ include file="custom_study.jsp" %>
    <%@ include file="random_study_modal.jsp" %>
  </main>
<div id="toastContainer" class="position-fixed start-50 translate-middle-x p-3" style="top: 5%; z-index: 1055;">
  <div id="limitToast" class="toast align-items-center text-white bg-danger border-0" role="alert">
    <div class="d-flex">
      <div class="toast-body" id="toastBody"></div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  </div>
</div>
  

  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</body>
</html>
