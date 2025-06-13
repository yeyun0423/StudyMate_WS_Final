<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.UserDAO" %>
<%
    // 로그인 여부 및 관리자 권한 체크
    String loginUserId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    if (loginUserId == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 삭제할 대상 유저 ID
    String targetUserId = request.getParameter("userId");
    if (targetUserId == null || targetUserId.trim().isEmpty()) {
        response.sendRedirect("user_list.jsp");
        return;
    }

    // DAO를 통해 관련 데이터 삭제
    UserDAO dao = new UserDAO();
    dao.deleteAllUserData(targetUserId); 
    dao.deleteUser(targetUserId);       

    response.sendRedirect("user_list.jsp?message=deleted");
%>
