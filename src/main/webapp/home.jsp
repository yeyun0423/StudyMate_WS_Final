<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String userName = null;
    String lang = "ko";

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
	<fmt:setLocale value="<%= lang %>" />
	<fmt:setBundle basename="bundle.messages" />
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
	<h3 id="titleStudy" class="mb-3 fw-bold"><fmt:message key="home.title.study"/></h3>
	
    <div class="d-flex flex-wrap gap-3 align-items-center mb-4">
       <select class="form-select w-auto" id="subjectSelect" onchange="fetchRecommendedFriends()">
    <option selected disabled id="optionSubjectDefault"><fmt:message key="home.subject.select" /></option>
    <option value="db"><fmt:message key="subject.1"/></option>
    <option value="web"><fmt:message key="subject.2"/></option>
    <option value="network"><fmt:message key="subject.3"/></option>
    <option value="ds"><fmt:message key="subject.4"/></option>
    <option value="linux"><fmt:message key="subject.5"/></option>
    <option value="spring"><fmt:message key="subject.6"/></option>
    <option value="java"><fmt:message key="subject.7"/></option>
</select>

        <!-- 인원 수 조조 -->
        <div class="d-flex align-items-center gap-2">
            <button class="btn btn-outline-secondary" onclick="decreaseMember()">-</button>
            <span id="memberCount" class="fw-bold fs-5">1</span>
            <button class="btn btn-outline-secondary" onclick="increaseMember()">+</button>
        </div>
    </div>

    <!-- 추천 차원 박스 -->
    <h5 class="fw-bold mb-2" id="labelRecommended"><fmt:message key ="home.label.recommended" /></h5>
    <div class="border p-4 rounded" style="min-height: 250px;" id="recommendedContainer">
        <p class="text-muted"><fmt:message key="placeholder.recommendfriends" /></p>
    </div>

    <!-- 경고 메시지 -->
    <div id="warningMessage" class="text-danger fw-bold mt-2 mb-4"></div>

	<!-- 스터디 생성 버튼 -->
    <div class="mb-5 mt-4 d-flex align-items-center gap-3">
        <button id="createBtn" class="btn btn-primary" onclick="createStudyGroup()"><fmt:message key="home.button.create" /></button>
        <span id="alreadyJoinedMsg" class="text-danger fw-bold" style="display: none;">⚠ 이미 참여중입니다</span>
    </div>

    <!-- 랜덤 생성 버튼 -->
    <h3 class="fw-bold mt-5 mb-3" id="titleRandom"><fmt:message key="home.title.random" /></h3>
    <div class="mb-5">
        <button id="randomBtn" class="btn btn-secondary"><fmt:message key="home.button.random" /></button>
    </div>
    
    <!-- 랜덤 스터디 그룹 모달 -->
	<div class="modal fade" id="randomStudyModal" tabindex="-1" aria-labelledby="randomStudyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="randomStudyModalLabel">랜덤 스터디 그룹 옵션 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="randomSubject" class="form-label"><fmt:message key="home.subject.select" /></label>
                    <select class="form-select" id="randomSubject">
                     <option selected disabled id="optionSubjectDefault"><fmt:message key="home.subject.select" /></option>
            		<option value="데이터베이스"><fmt:message key="subject.1"/></option>
            		<option value="웹서버컨트립"><fmt:message key="subject.2"/></option>
            		<option value="네트워크프로그마인"><fmt:message key="subject.3"/></option>
            		<option value="자료구조및실습"><fmt:message key="subject.4"/></option>
            		<option value="시스템프로그마인"><fmt:message key="subject.5"/></option>
            		<option value="스프링프레임워크"><fmt:message key="subject.6"/></option>
            		<option value="자바프로그마인"><fmt:message key="subject.7"/></option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">인원 수</label>
                    <div class="d-flex align-items-center gap-2">
                        <button type="button" class="btn btn-outline-secondary" onclick="decreaseRandomMember()">-</button>
                        <span id="randomMemberCount" class="fw-bold fs-5">2</span>
                        <button type="button" class="btn btn-outline-secondary" onclick="increaseRandomMember()">+</button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="generateRandomStudyGroup()">랜덤 생성</button>
            </div>
        </div>
    </div>
</div>
    

</div>

<!-- 부트스트랜 JS -->
<script src="resources/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정보 전달 -->
<script>
    const USER_NAME = "<%= userName %>";
    const USER_ID = "<%= userId %>";
</script>

<!-- 추천 차원/스터디 로직 JS -->
<script src="resources/js/home.js"></script>

<!--  랜덤 모달 제어 JS -->
<script src="<%= request.getContextPath() %>/resources/js/random-modal.js"></script>

</body>
</html>