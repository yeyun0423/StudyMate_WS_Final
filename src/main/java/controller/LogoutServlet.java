package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

// 사용자가 로그아웃할 때 세션과 쿠키를 정리하는 서블릿
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 세션이 있으면 종료
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // user_name, lang 쿠키도 삭제
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_name".equals(cookie.getName()) || "lang".equals(cookie.getName())) {
                    cookie.setMaxAge(0); // 즉시 만료
                    cookie.setPath("/"); // 전체 경로에 적용되도록 설정
                    response.addCookie(cookie);
                }
            }
        }

        // 로그인 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
