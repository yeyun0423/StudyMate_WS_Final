<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String userName = null;

    // 쿠키에서 user_name 읽기
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) {
                userName = c.getValue();
                break;
            }
        }
    }

    // 로그인 안 된 사용자 차단
    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>StudyMate 홈페이지</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/home.css">
</head>
<body class="bg-light">

<div class="container py-4">

    <jsp:include page="navbar.jsp" />

    <!-- 스터디 그룹 만들기 -->
    <h3 id="titleStudy" class="mb-3 fw-bold">🤓 스터디 그룹 만들기</h3>

    <div class="d-flex flex-wrap gap-3 align-items-center mb-4">
        <select class="form-select w-auto" id="subjectSelect" onchange="fetchRecommendedFriends()">
            <option selected disabled id="optionSubjectDefault">과목 선택</option>
            <option value="데이터베이스">데이터베이스</option>
            <option value="웹서버컴퓨팅">웹서버컴퓨팅</option>
            <option value="네트워크프로그래밍">네트워크프로그래밍</option>
            <option value="자료구조및실습">자료구조및실습</option>
            <option value="시스템프로그래밍">시스템프로그래밍</option>
            <option value="스프링프레임워크">스프링프레임워크</option>
            <option value="자바프로그래밍">자바프로그래밍</option>
        </select>

        <!-- 인원 수 조절 -->
        <div class="d-flex align-items-center gap-2">
            <button class="btn btn-outline-secondary" onclick="decreaseMember()">-</button>
            <span id="memberCount" class="fw-bold fs-5">1</span>
            <button class="btn btn-outline-secondary" onclick="increaseMember()">+</button>
        </div>
    </div>

    <!-- 추천 친구 박스 -->
    <h5 class="fw-bold mb-2" id="labelRecommended">추천 친구</h5>
    <div class="border p-4 rounded" style="min-height: 250px;" id="recommendedContainer">
        <p class="text-muted">과목을 선택하면 추천 친구가 표시됩니다.</p>
    </div>

    <!-- 경고 메시지 -->
    <div id="warningMessage" class="text-danger fw-bold mt-2 mb-4"></div>

    <div class="mb-5 mt-4">
        <button id="createBtn" class="btn btn-primary" onclick="createStudyGroup()">스터디 만들기</button>
    </div>

    <!-- 랜덤 생성 버튼 -->
    <h3 class="fw-bold mt-5 mb-3" id="titleRandom">🔀 랜덤 스터디 그룹 만들기</h3>
    <div class="mb-5">
        <button id="randomBtn" class="btn btn-secondary">랜덤 생성</button>
    </div>

</div>

<!-- 부트스트랩 JS -->
<script src="resources/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정보 전달 -->
<script>
    const USER_NAME = "<%= userName %>";
    const USER_ID = "<%= userId %>";
</script>

<!-- 추천 친구/스터디 로직 JS -->
<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>

</body>
</html>
