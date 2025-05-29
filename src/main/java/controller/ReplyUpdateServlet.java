package controller;

import dao.BoardReplyDAO;
import dto.BoardReplyDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ReplyUpdateServlet")
public class ReplyUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String replyIdParam = request.getParameter("replyId");
        String postIdParam = request.getParameter("postId");
        String content = request.getParameter("content");

        if (replyIdParam == null || postIdParam == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("qna_answer_list.jsp");
            return;
        }

        int replyId = Integer.parseInt(replyIdParam);

        BoardReplyDTO reply = new BoardReplyDTO();
        reply.setReplyId(replyId);
        reply.setContent(content);

        boolean updated = new BoardReplyDAO().updateReply(reply);

        if (updated) {
            response.sendRedirect("qna_edit.jsp?id=" + postIdParam);
        } else {
            response.getWriter().println("<script>alert('댓글 수정에 실패했습니다.'); history.back();</script>");
        }
    }
}
