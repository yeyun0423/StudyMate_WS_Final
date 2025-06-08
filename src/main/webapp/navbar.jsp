<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String userName = null;
    String lang = "ko";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) userName = c.getValue();
            else if ("lang".equals(c.getName())) lang = c.getValue();
        }
    }

    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null) isAdmin = false;
%>

<fmt:setLocale value="<%= lang %>" />
<fmt:setBundle basename="bundle.messages" />

<style>
  .logo-img {
    height: 120px;
    width: auto;
  }
  .navbar {
    background-color: #ffffff !important;
    box-shadow: 0 4px 16px rgba(0,0,0,0.05);
    border-radius: 16px;
    padding: 12px 24px;
  }
  .navbar-nav .nav-link {
    font-weight: 600;
    color: #1e1b4b !important;
  }
  .dropdown-menu a {
    font-weight: 500;
  }
  #logoutBtn {
    background-color: #4f46e5;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 6px 16px;
    font-weight: 600;
  }
</style>

<div class="d-flex align-items-center mb-3">
    <img src="<%= request.getContextPath() %>/resources/images/studymate logo.png" alt="logo" class="logo-img me-3">
    <h1 class="fw-bold">StudyMate</h1>
</div>

<nav class="navbar navbar-expand-lg navbar-light mb-4">
    <div class="container-fluid">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-4">
            <li class="nav-item">
                <a id="menuHome" class="nav-link fw-bold" href="<%= request.getContextPath() %>/home.jsp">
                    <fmt:message key="menuHome" />
                </a>
            </li>

            <li class="nav-item dropdown">
                <a id="menuMyPage" class="nav-link dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                    <fmt:message key="menuMyPage" />
                </a>
                <ul class="dropdown-menu">
                    <li><a id="menuStudy" class="dropdown-item" href="<%= request.getContextPath() %>/mystudygroup.jsp"><fmt:message key="menuStudy" /></a></li>
                    <li><a id="menuProfile" class="dropdown-item" href="<%= request.getContextPath() %>/profile.jsp"><fmt:message key="menuProfile" /></a></li>
                    <li><a id="menuTimetable" class="dropdown-item" href="<%= request.getContextPath() %>/timetable.jsp"><fmt:message key="menuTimetable" /></a></li>
                </ul>
            </li>

            <li class="nav-item dropdown">
                <a id="menuBoard" class="nav-link dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                    <fmt:message key="menuBoard" />
                </a>
                <ul class="dropdown-menu">
                    <li><a id="menuFree" class="dropdown-item" href="<%= request.getContextPath() %>/freeboard.jsp"><fmt:message key="menuFree" /></a></li>
                    <li><a id="menuFiles" class="dropdown-item" href="<%= request.getContextPath() %>/resourceboard.jsp"><fmt:message key="menuFiles" /></a></li>
                    <li><a id="menuQna" class="dropdown-item" href="<%= request.getContextPath() %>/qnaboard.jsp"><fmt:message key="menuQna" /></a></li>
                </ul>
            </li>

            <% if (Boolean.TRUE.equals(isAdmin)) { %>
                <li class="nav-item dropdown">
                    <a id="menuAdmin" class="nav-link dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                        <fmt:message key="menuAdmin" />
                    </a>
                    <ul class="dropdown-menu">
                        <li><a id="menuUserList" class="dropdown-item" href="<%=request.getContextPath()%>/admin/user_list.jsp"><fmt:message key="menuUserList" /></a></li>
                        <li><a id="menuMatchList" class="dropdown-item" href="<%=request.getContextPath()%>/admin/matchlist.jsp"><fmt:message key="menuMatchList" /></a></li>
                        <li><a id="menuQnaAnswer" class="dropdown-item" href="<%=request.getContextPath()%>/admin/qna_answer_list.jsp"><fmt:message key="menuQnaAnswer" /></a></li>
                    </ul>
                </li>
            <% } %>
        </ul>

        <!-- 우측: 언어 스위치 + 환영 문구 + 로그아웃 -->
        <div class="d-flex align-items-center gap-3">
            <div class="lang-toggle d-flex align-items-center gap-1">
                <span class="me-1">KR</span>
                <form action="<%= request.getContextPath() %>/changeLang" method="post" class="m-0 p-0">
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

            <span id="welcomeText" class="fw-bold">
                <%= userName != null ? userName + "님, " : "" %><fmt:message key="menuWelcome" />
            </span>
            <button id="logoutBtn" class="btn btn-primary btn-sm"
                    onclick="location.href='<%= request.getContextPath() %>/logout'"><fmt:message key="logout" /></button>
        </div>
    </div>
</nav>
<script>
    const userId = "<%= userId != null ? userId : "" %>";
    const userName = "<%= userName != null ? userName : "" %>";
</script>
<script src="<%= request.getContextPath() %>/resources/js/lang-toggle.js"></script>
