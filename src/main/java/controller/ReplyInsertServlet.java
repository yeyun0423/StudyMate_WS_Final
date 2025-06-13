package controller;

import dao.BoardReplyDAO;
import dto.BoardReplyDTO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// QnA 글에 달린 답변을 등록하는 서블릿
public class ReplyInsertServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

      
        request.setCharacterEncoding("UTF-8");

        // 답변 작성에 필요한 데이터 받아오기
        int postId = Integer.parseInt(request.getParameter("postId"));
        String writerId = request.getParameter("writerId");
        String content = request.getParameter("content");

        // 답변 내용을 DTO에 담기
        BoardReplyDTO reply = new BoardReplyDTO();
        reply.setPostId(postId);
        reply.setWriterId(writerId);
        reply.setContent(content);

        // DB에 저장
        new BoardReplyDAO().insertReply(reply);

        // 답변 작성 후, 다시 해당 질문 상세 페이지로 이동
        response.sendRedirect("qnaview.jsp?id=" + postId);
    }
}
