package controller;

import java.io.IOException;

import dao.BoardReplyDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ReplyDeleteServlet")
public class ReplyDeleteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int replyId = Integer.parseInt(request.getParameter("replyId"));
        new BoardReplyDAO().deleteReplyById(replyId);
        response.sendRedirect("admin/qna_answer_list.jsp");
    }
}
