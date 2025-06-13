<%@ page import="dao.BoardPostDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String userId = (String) session.getAttribute("userId");

    BoardPostDAO dao = new BoardPostDAO();
    if (dao.isWriter(id, userId)) {
        dao.deletePost(id);
    }
    response.sendRedirect("freeboard.jsp");
%>
