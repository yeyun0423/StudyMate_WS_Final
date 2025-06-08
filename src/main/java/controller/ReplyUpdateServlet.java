package controller;

import dao.BoardReplyDAO;
import dto.BoardReplyDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

// QnA 답변 수정 처리용 서블릿
public class ReplyUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        request.setCharacterEncoding("UTF-8");

        // 수정할 답변 정보 받아오기
        String replyIdParam = request.getParameter("replyId");
        String postIdParam = request.getParameter("postId");
        String content = request.getParameter("content");

        // 필수값 누락 시 목록으로 이동
        if (replyIdParam == null || postIdParam == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("qna_answer_list.jsp");
            return;
        }

        // 문자열을 숫자로 변환
        int replyId = Integer.parseInt(replyIdParam);

        // 수정할 내용 DTO에 담기
        BoardReplyDTO reply = new BoardReplyDTO();
        reply.setReplyId(replyId);
        reply.setContent(content);

        // DB에 반영
        boolean updated = new BoardReplyDAO().updateReply(reply);

        if (updated) {
            // 수정 성공 시 원래 글로 이동
            response.sendRedirect("qna_edit.jsp?id=" + postIdParam);
        } else {
            // 실패 시 경고창 띄우고 뒤로 가기
            response.getWriter().println("<script>alert('댓글 수정에 실패했습니다.'); history.back();</script>");
        }
    }
}
