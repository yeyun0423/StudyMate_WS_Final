package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

import dao.BoardPostDAO;
import dto.BoardPostDTO;

// QnA 게시판 글 작성 처리
public class QnABoardWriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        boolean isPrivate = request.getParameter("isPrivate") != null;

        HttpSession session = request.getSession();
        String writerId = (String) session.getAttribute("userId");

        // 로그인 여부 확인
        if (writerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 게시글 데이터 구성
        BoardPostDTO post = new BoardPostDTO();
        post.setTitle(title);
        post.setContent(content);
        post.setPrivate(isPrivate);
        post.setWriterId(writerId);
        post.setBoardType("QNA");

        // DB 저장
        boolean success = new BoardPostDAO().insertQnAPost(post);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (success) {
            out.println("<script>");
            out.println("if (confirm('질문이 등록되었습니다.')) {");
            out.println("    window.location.href = 'qnaboard.jsp';");
            out.println("} else {");
            out.println("    window.location.href = 'qnawrite.jsp';");
            out.println("}");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('등록에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    }
}
