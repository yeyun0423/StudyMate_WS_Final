package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 세션 무효화
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate();
        }

        // 쿠키 삭제
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_name".equals(cookie.getName()) || "lang".equals(cookie.getName())) {
                    cookie.setMaxAge(0);         
                    cookie.setPath("/");        
                    response.addCookie(cookie);
                }
            }
        }

        // 로그아웃 후 로그인 페이지로 이동
        response.sendRedirect(request.getContextPath() +"/login.jsp");
    }
}
