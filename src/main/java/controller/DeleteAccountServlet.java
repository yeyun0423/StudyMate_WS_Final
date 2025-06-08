package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

// 사용자의 회원 탈퇴를 처리하는 서블릿
public class DeleteAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");

        // 유효하지 않은 요청이면 프로필 페이지로 이동
        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect("profile.jsp");
            return;
        }

        // 사용자 정보 삭제
        boolean success = new UserDAO().deleteUserAndRelatedData(userId);

        if (success) {
            // 세션 종료 후 로그인 페이지로 이동
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("login.jsp");
        } else {
            // 실패 시 알림창 띄우고 이전 페이지로
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
        }
    }
}
