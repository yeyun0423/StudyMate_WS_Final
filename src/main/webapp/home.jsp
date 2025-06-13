<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.TimetableDAO" %>
<%@ page import="dto.TimetableDTO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String userName = null;

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

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate 홈페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'SUIT', sans-serif; }
        body { background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff); }
        .section-box {
            background: white;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
            margin-bottom: 40px;
        }
        .section-title { font-size: 1.5rem; font-weight: 700; }
        .form-select, .btn { border-radius: 8px; }
        .recommend-card {
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            padding: 16px;
            background-color: #f8fafc;
            width: 200px;
            text-align: center;
        }
        
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <!-- 스터디 그룹 만들기 -->
    <div class="section-box">
       <h3 id="titleStudy" class="section-title mb-4">
        <i class="bi bi-people-fill text-primary me-2"></i>
        🤓 스터디 그룹 만들기
    </h3>

        <div class="d-flex flex-wrap align-items-center gap-4 mb-4">
            <select class="form-select w-auto" id="subjectSelect" onchange="fetchRecommendedFriends()">
                <option selected disabled id="optionSubjectDefault">과목 선택</option>
                <c:forEach var="subject" items="${subjectList}">
                    <option value="${subject.subject}">${subject.subject}</option>
                </c:forEach>
            </select>

            <div class="d-flex align-items-center gap-2">
                <button class="btn btn-outline-secondary px-3" onclick="decreaseMember()">-</button>
                <span id="memberCount" class="fw-bold fs-5">2</span>
                <button class="btn btn-outline-secondary px-3" onclick="increaseMember()">+</button>
            </div>
        </div>

        <h5 class="fw-bold mb-2" id="labelRecommended">추천 친구</h5>
        <div id="recommendedContainer" class="d-flex flex-wrap gap-3 mb-3">
            <p class="text-muted">과목을 선택하면 추천 친구가 표시됩니다.</p>
        </div>

        <div id="warningMessage" class="text-danger fw-bold mb-3"></div>

        <div class="d-flex gap-3">
            <button id="createBtn" class="btn btn-primary px-4" onclick="createStudyGroup()">스터디 만들기</button>
            <span id="alreadyJoinedMsg" class="text-danger fw-bold align-self-center" style="display: none;">⚠ 이미 참여중입니다</span>
        </div>
    </div>

    <!-- 랜덤 스터디 만들기 -->
    <div class="section-box">
        <h3 id="titleRandom" class="section-title mb-3">
            <i class="bi bi-shuffle text-primary me-2"></i>
           🔀 랜덤 스터디 그룹 만들기
        </h3>

        <div class="alert alert-info small text-center mb-4" role="alert">
            🤔 어떤 친구들과 스터디 하게 될까요?<br>
            <strong>과목과 인원을 선택</strong>한 후 <strong>랜덤 생성</strong>을 눌러보세요!
        </div>

        <button id="randomBtn" class="btn btn-secondary px-4" data-bs-toggle="modal" data-bs-target="#randomStudyModal">
            랜덤 생성
        </button>
    </div>

    <!-- 랜덤 스터디 모달 -->
    <div class="modal fade" id="randomStudyModal" tabindex="-1" aria-labelledby="randomStudyModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content p-3">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-shuffle text-primary me-2"></i>🔀 랜덤 스터디 그룹 옵션 선택
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="randomSubject" class="form-label">과목 선택</label>
                        <select class="form-select" id="randomSubject">
                            <option selected disabled>과목 선택</option>
                            <c:forEach var="subject" items="${subjectList}">
                                <option value="${subject.subject}">${subject.subject}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">인원 수</label>
                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn btn-outline-secondary px-3" onclick="decreaseRandomMember()">-</button>
                            <span id="randomMemberCount" class="fw-bold fs-5">2</span>
                            <button type="button" class="btn btn-outline-secondary px-3" onclick="increaseRandomMember()">+</button>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="generateRandomStudyGroup()">랜덤 생성</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const USER_NAME = "<%= userName %>";
    const USER_ID = "<%= userId %>";
    const CONTEXT_PATH = "<%= request.getContextPath() %>";

    const randomModal = document.getElementById('randomStudyModal');
    randomModal.addEventListener('hidden.bs.modal', function () {
        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
        document.body.classList.remove('modal-open');
        document.body.style = '';
    });
</script>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/home.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/random-modal.js"></script>
</body>
</html>