package controller;

import java.io.IOException;

import dao.BoardCommentDAO;
import dto.BoardCommentDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 자유게시판 게시글에 댓글을 작성하는 서블릿
public class FreeboardCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String content = request.getParameter("content");
        String postIdStr = request.getParameter("postId");
        String writerId = (String) request.getSession().getAttribute("userId");

        // 비로그인 또는 필수값 누락 시 로그인 페이지로 이동
        if (writerId == null || postIdStr == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        // DTO에 댓글 정보 담기
        int postId = Integer.parseInt(postIdStr);
        BoardCommentDTO comment = new BoardCommentDTO();
        comment.setPostId(postId);
        comment.setWriterId(writerId);
        comment.setContent(content);

        // DB에 댓글 저장
        new BoardCommentDAO().insertComment(comment);

        // 댓글 작성 후 게시글 상세 페이지로 이동
        response.sendRedirect("freeboard_view.jsp?id=" + postId);
    }
}
