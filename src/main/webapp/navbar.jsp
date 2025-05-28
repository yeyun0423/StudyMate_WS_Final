<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 쿠키에서 user_name, lang 읽기
    String userName = null;
    String lang = "ko";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) userName = c.getValue();
            else if ("lang".equals(c.getName())) lang = c.getValue();
        }
    }

    // 세션에서 userId, isAdmin 확인
    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null) isAdmin = false;
%>

<fmt:setLocale value="<%= lang %>" />
<fmt:setBundle basename="bundle.messages" />

<style>
  .logo-img {
    height: 80px;
    width: auto;
  }
</style>


<!-- 로고 & 제목 -->
<div class="d-flex align-items-center mb-3">
    <img src="<%= request.getContextPath() %>/resources/images/studymate logo.png" alt="logo" class="logo-img me-3">
    <h1 class="fw-bold">StudyMate</h1>
</div>

<!-- 네비게이션 -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm rounded px-3 mb-4">
    <div class="container-fluid">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-4">
            <li class="nav-item">
                <a id="menuHome" class="nav-link fw-bold" href="home.jsp">
                    <fmt:message key="menuHome" />
                </a>
            </li>

            <li class="nav-item dropdown">
                <a id="menuMyPage" class="nav-link dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                    <fmt:message key="menuMyPage" />
                </a>
                <ul class="dropdown-menu">
                    <li><a id="menuStudy" class="dropdown-item" href="#"><fmt:message key="menuStudy" /></a></li>
                    <li><a id="menuProfile" class="dropdown-item" href="profile.jsp"><fmt:message key="menuProfile" /></a></li>
                    <li><a id="menuTimetable" class="dropdown-item" href="timetable.jsp"><fmt:message key="menuTimetable" /></a></li>
                </ul>
            </li>

            <li class="nav-item dropdown">
                <a id="menuBoard" class="nav-link dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                    <fmt:message key="menuBoard" />
                </a>
                <ul class="dropdown-menu">
                    <li><a id="menuFree" class="dropdown-item" href="freeboard.jsp"><fmt:message key="menuFree" /></a></li>
                    <li><a id="menuFiles" class="dropdown-item" href="resourceboard.jsp"><fmt:message key="menuFiles" /></a></li>
                    <li><a id="menuQna" class="dropdown-item" href="qnaboard.jsp"><fmt:message key="menuQna" /></a></li>
                </ul>
            </li>

            <% if (Boolean.TRUE.equals(isAdmin)) { %>
                <li class="nav-item dropdown">
                    <a id="menuAdmin" class="nav-link dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                        <fmt:message key="menuAdmin" />
                    </a>
                    <ul class="dropdown-menu">
                        <li><a id="menuUserList" class="dropdown-item" href="user_list.jsp"><fmt:message key="menuUserList" /></a></li>
                        <li><a id="menuMatchList" class="dropdown-item" href="#"><fmt:message key="menuMatchList" /></a></li>
                        <li><a id="menuQnaAnswer" class="dropdown-item" href="qna_answer_list.jsp"><fmt:message key="menuQnaAnswer" /></a></li>
                    </ul>
                </li>
            <% } %>
        </ul>

        <!-- 우측: 언어 스위치 + 환영 문구 + 로그아웃 -->
        <div class="d-flex align-items-center gap-3">
            <!-- KR/EN 언어 스위치 -->
            <div class="lang-toggle d-flex align-items-center gap-1">
                <span class="me-1">KR</span>
                <form action="changeLang" method="post" class="m-0 p-0">
                    <input type="hidden" name="user_id" value="<%= userId %>" />
                    <input type="hidden" id="lang_code" name="lang_code" value="ko" />
                    <div class="form-check form-switch mb-0">
                        <input class="form-check-input" type="checkbox"
                               onchange="toggleLang(this)"
                               <%= "en".equals(lang) ? "checked" : "" %> >
                    </div>
                </form>
                <span class="ms-0">EN</span>
            </div>

            <!-- 환영 메시지 + 로그아웃 -->
            <span id="welcomeText" class="fw-bold">
                <%= userName != null ? userName + "님, " : "" %><fmt:message key="menuWelcome" />
            </span>
           <button id="logoutBtn" class="btn btn-primary btn-sm" onclick="location.href='logout'">로그아웃</button>
           
        </div>
    </div>
</nav>

<script>
    const userId = "<%= userId != null ? userId : "" %>";
    const userName = "<%= userName != null ? userName : "" %>";
</script>

<!-- lang-toggle.js -->
<script src="<%= request.getContextPath() %>/resources/js/lang-toggle.js"></script>

