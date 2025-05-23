package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

import dao.BoardPostDAO;
import dto.BoardPostDTO;

@WebServlet("/QnABoardWriteServlet")
public class QnABoardWriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 폼 데이터 가져오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        boolean isPrivate = request.getParameter("isPrivate") != null;

        // 세션에서 작성자 정보 가져오기 (예: userName)
        HttpSession session = request.getSession();
        String writerId = (String) session.getAttribute("userId");

        if (writerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // DTO 생성
        BoardPostDTO post = new BoardPostDTO();
        post.setTitle(title);
        post.setContent(content);
        post.setPrivate(isPrivate);
        post.setWriterId(writerId);
        post.setBoardType("QNA"); // Q&A 글로 지정

        // DB에 저장
        BoardPostDAO dao = new BoardPostDAO();
        boolean success = dao.insertQnAPost(post);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (success) {
            out.println("<script>");
            out.println("if (confirm('질문이 정상적으로 등록되었습니다!')) {");
            out.println("    window.location.href = 'qnaboard.jsp';");
            out.println("} else {");
            out.println("    window.location.href = 'qnawrite.jsp';");
            out.println("}");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('질문 등록에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    }
}
