<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String userName = null;
    String lang = "ko";

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) {
                userName = c.getValue();
                break;
            }
        }
    }

    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 홈</title>
    <fmt:setLocale value="<%= lang %>" />
    <fmt:setBundle basename="bundle.messages" />

    <!-- SUIT Font & Bootstrap -->
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        * {
            font-family: 'SUIT', sans-serif;
        }
        body {
            background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff);
        }
        .section-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            height: 100%;
        }
        .btn-primary {
            background-color: #4f46e5;
            border: none;
            font-weight: 600;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .btn-outline-secondary, .form-select {
            border-radius: 12px;
        }
        #recommendedContainer {
            min-height: 250px;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .friend-card {
            width: 10rem;
        }
        .friend-card img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="row g-4 mb-4">
        <div class="col-lg-6">
            <div class="section-card">
                <h3 class="fw-bold mb-4"><fmt:message key="home.title.study"/></h3>
                <div class="d-flex flex-wrap gap-3 align-items-center mb-4">
                    <select class="form-select w-auto" id="subjectSelect" onchange="fetchRecommendedFriends()">
                        <option selected disabled><fmt:message key="home.subject.select" /></option>
                        <option value="db"><fmt:message key="subject.1"/></option>
                        <option value="web"><fmt:message key="subject.2"/></option>
                        <option value="network"><fmt:message key="subject.3"/></option>
                        <option value="ds"><fmt:message key="subject.4"/></option>
                        <option value="linux"><fmt:message key="subject.5"/></option>
                        <option value="spring"><fmt:message key="subject.6"/></option>
                        <option value="java"><fmt:message key="subject.7"/></option>
                    </select>
                    <div class="d-flex align-items-center gap-2">
                        <button class="btn btn-outline-secondary" onclick="decreaseMember()">-</button>
                        <span id="memberCount" class="fw-bold fs-5">1</span>
                        <button class="btn btn-outline-secondary" onclick="increaseMember()">+</button>
                    </div>
                </div>
                <h5 class="fw-bold mb-2"><fmt:message key="home.label.recommended" /></h5>
                <div id="recommendedContainer">
                    <div class="card shadow-sm p-3 text-center friend-card">
                        <img src="resources/images/default-user.png" alt="profile">
                        <h6 class="fw-bold mt-2">홍길동</h6>
                        <button class="btn btn-sm btn-outline-primary">초대</button>
                    </div>
                </div>
                <div id="warningMessage" class="text-danger fw-bold mt-2 mb-3"></div>
                <button id="createBtn" class="btn btn-primary mt-3" onclick="createStudyGroup()">
                    <fmt:message key="home.button.create" />
                </button>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="section-card">
                <h3 class="fw-bold mb-3"><fmt:message key="home.title.random" /></h3>
                <div class="alert alert-info small text-center mb-4" role="alert">
                    🤔 어떤 친구들과 스터디 하게 될까요?<br>
                    <strong>과목과 인원을 선택</strong>한 후 <strong>랜덤 생성</strong>을 눌러보세요!
                </div>
                <button id="randomBtn" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#randomStudyModal">
                    <fmt:message key="home.button.random" />
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 랜덤 스터디 모달 -->
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
                        <option selected disabled><fmt:message key="home.subject.select" /></option>
                        <option value="db"><fmt:message key="subject.1"/></option>
                        <option value="web"><fmt:message key="subject.2"/></option>
                        <option value="network"><fmt:message key="subject.3"/></option>
                        <option value="ds"><fmt:message key="subject.4"/></option>
                        <option value="linux"><fmt:message key="subject.5"/></option>
                        <option value="spring"><fmt:message key="subject.6"/></option>
                        <option value="java"><fmt:message key="subject.7"/></option>
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

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const USER_NAME = "<%= userName %>";
    const USER_ID = "<%= userId %>";
</script>
<script src="resources/js/home.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/random-modal.js"></script>
</body>
</html>
