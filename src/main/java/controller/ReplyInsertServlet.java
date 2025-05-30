package controller;

import dao.BoardReplyDAO;
import dto.BoardReplyDTO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ReplyInsertServlet")
public class ReplyInsertServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        int postId = Integer.parseInt(request.getParameter("postId"));
        String writerId = request.getParameter("writerId");
        String content = request.getParameter("content");

        BoardReplyDTO reply = new BoardReplyDTO();
        reply.setPostId(postId);
        reply.setWriterId(writerId);
        reply.setContent(content);

        new BoardReplyDAO().insertReply(reply);
        response.sendRedirect("qnaview.jsp?id=" + postId);
    }
}