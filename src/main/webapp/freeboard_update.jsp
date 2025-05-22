<%@ page import="dao.BoardPostDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    new BoardPostDAO().updatePost(id, title, content);
    response.sendRedirect("freeboard_view.jsp?id=" + id);
%>
