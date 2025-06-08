package controller;

import java.io.IOException;
import dao.BoardReplyDAO;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// QnA 게시판에서 답변을 삭제하는 서블릿
public class ReplyDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 삭제할 답변 번호 받아오기
        int replyId = Integer.parseInt(request.getParameter("replyId"));

        // DB에서 해당 답변 삭제
        new BoardReplyDAO().deleteReplyById(replyId);

        // 삭제 후 답변 목록 페이지로 이동
        response.sendRedirect("admin/qna_answer_list.jsp");
    }
}
