package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteAccount")  // ✅ 어노테이션 등록만 사용
public class DeleteAccountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");

        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect("profile.jsp");
            return;
        }

        boolean success = new UserDAO().deleteUserAndRelatedData(userId);

        if (success) {
            HttpSession session = request.getSession();
            session.invalidate(); // 세션 초기화
            response.sendRedirect("login.jsp"); // 로그인 페이지로 이동
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
        }
    }
}
