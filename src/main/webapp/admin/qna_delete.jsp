<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.BoardReplyDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 관리자 권한 확인
    String userId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (userId == null || isAdmin == null || !isAdmin) {
%>
    <script>
        alert("접근 권한이 없습니다.");
        history.back();
    </script>
<%
        return;
    }

    //댓글 삭제
    int postId = Integer.parseInt(request.getParameter("id"));
    BoardReplyDAO dao = new BoardReplyDAO();
    boolean success = dao.deleteRepliesByPostId(postId);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 댓글 삭제 결과</title>
    <script>
        <% if (success) { %>
        alert("댓글이 정상적으로 삭제되었습니다.");
        location.href = "<%= request.getContextPath() %>/admin/qna_answer_list.jsp";
        <% } else { %>
        alert("삭제할 답변이 없습니다");
        history.back();
        <% } %>
    </script>
</head>
<body></body>
</html>
