<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TimetableDAO" %>
<%@ page import="dto.TimetableDTO" %>
<%@ page import="java.util.List" %>
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
    TimetableDAO timetableDAO = new TimetableDAO();
    List<TimetableDTO> subjectList = timetableDAO.getTimetableByUser(userId);
    request.setAttribute("subjectList", subjectList);
%>

<html>
<head>
    <fmt:setLocale value="<%= lang %>" />
    <fmt:setBundle basename="bundle.messages" />
    <meta charset="UTF-8">
    <title>StudyMate 홈페이지</title>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/home.css">
</head>
<body class="bg-light">

<div class="container py-4">

    <jsp:include page="navbar.jsp" />

    <h3 id="titleStudy" class="mb-3 fw-bold"><fmt:message key="home.title.study"/></h3>

    <div class="d-flex flex-wrap gap-3 align-items-center mb-4">
        <select class="form-select w-auto" id="subjectSelect" onchange="fetchRecommendedFriends()">
            <option selected disabled id="optionSubjectDefault"><fmt:message key="home.subject.select" /></option>
            <c:forEach var="subject" items="${subjectList}">
                <option value="${subject.subject}">${subject.subject}</option>
            </c:forEach>
        </select>

        <div class="d-flex align-items-center gap-2">
            <button class="btn btn-outline-secondary" onclick="decreaseMember()">-</button>
            <span id="memberCount" class="fw-bold fs-5">2</span>
            <button class="btn btn-outline-secondary" onclick="increaseMember()">+</button>
        </div>
    </div>

    <h5 class="fw-bold mb-2" id="labelRecommended"><fmt:message key ="home.label.recommended" /></h5>
    <div class="border p-4 rounded" style="min-height: 250px;" id="recommendedContainer">
        <p class="text-muted"><fmt:message key="placeholder.recommendfriends" /></p>
    </div>

    <div id="warningMessage" class="text-danger fw-bold mt-2 mb-4"></div>

    <div class="mb-5 mt-4 d-flex align-items-center gap-3">
        <button id="createBtn" class="btn btn-primary" onclick="createStudyGroup()"><fmt:message key="home.button.create" /></button>
        <span id="alreadyJoinedMsg" class="text-danger fw-bold" style="display: none;">⚠ 이미 참여중입니다</span>
    </div>

    <h3 class="fw-bold mt-5 mb-3" id="titleRandom"><fmt:message key="home.title.random" /></h3>
    <div class="mb-5">
        <button id="randomBtn" class="btn btn-secondary"><fmt:message key="home.button.random" /></button>
    </div>

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
                            <c:forEach var="subject" items="${subjectList}">
                                <option value="${subject.subject}">${subject.subject}</option>
                            </c:forEach>
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

<script src="resources/js/bootstrap.bundle.min.js"></script>
<script>
    const USER_NAME = "<%= userName %>";
    const USER_ID = "<%= userId %>";
</script>
<script src="resources/js/home.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/random-modal.js"></script>

</body>
</html>
