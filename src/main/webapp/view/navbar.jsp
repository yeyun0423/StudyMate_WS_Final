<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>네비게이션바</title>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/view/home.jsp">StudyMate</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <!-- 왼쪽 메뉴 -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/view/home.jsp">홈</a>
        </li>
        <!-- 마이페이지 드롭다운 -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            마이페이지
          </a>
          <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/study_room.jsp">나의 스터디방</a></li>
           <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/profile_edit.jsp">프로필 수정</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/schedule_view.jsp">시간표 등록</a></li>
          </ul>
        </li>
      
        <!-- 게시판 드롭다운 -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            게시판
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/free_board_list.jsp">자유게시판</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/home.jsp">자료실</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/home.jsp">관리자 Q&A</a></li>
          </ul>
        </li>

        <!-- 관리자 드롭다운 -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            관리자 페이지
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/admin_page_user.jsp">전체 유저 목록</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/admin_page_matching.jsp">전체 매칭 목록</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/admin_page_answer.jsp">관리자 답변 목록</a></li>
          </ul>
        </li>
      </ul>

      <!-- 오른쪽 영역 -->
      <div class="ms-auto d-flex align-items-center gap-3">
    <div class="d-flex align-items-center ms-3">
  <label class="me-2 mb-0" for="langSwitch" id="langLabel">Korean</label>
  <div class="form-check form-switch mb-0">
    <input class="form-check-input" type="checkbox" role="switch" id="langSwitch">
  </div>
</div>
        <span class="text-decoration-underline">최예윤</span>님 환영합니다.

        <div class="position-relative d-inline-block">
          <img src="${pageContext.request.contextPath}/resources/images/알림.png" alt="Inbox Icon" width="44" height="44" class="img-thumbnail">
          <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
            99+
            <span class="visually-hidden">unread messages</span>
          </span>
        </div>

        <a class="btn btn-sm btn-outline-secondary" href="#">로그아웃</a>
      </div>
    </div>
  </div>
</nav>
<script src="${pageContext.request.contextPath}/resources/js/lang_switch.js"></script>
</body>
</html>
