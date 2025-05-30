package controller;

import java.io.IOException;

import dao.BoardCommentDAO;
import dto.BoardCommentDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FreeboardCommentServlet")
public class FreeboardCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String content = request.getParameter("content");
        String postIdStr = request.getParameter("postId");
        String writerId = (String) request.getSession().getAttribute("userId");

        if (writerId == null || postIdStr == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        int postId = Integer.parseInt(postIdStr);
        BoardCommentDTO comment = new BoardCommentDTO();
        comment.setPostId(postId);
        comment.setWriterId(writerId);
        comment.setContent(content);

        new BoardCommentDAO().insertComment(comment);
        response.sendRedirect("freeboard_view.jsp?id=" + postId);
    }
}
