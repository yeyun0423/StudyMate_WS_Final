package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;


public class ChangeLangServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("user_id");
        String langCode = request.getParameter("lang_code");

        if (langCode == null || (!langCode.equals("ko") && !langCode.equals("en"))) {
            langCode = "ko";
        }

        // lang_code 쿠키 저장 (30일)
        Cookie langCookie = new Cookie("lang", langCode);
        langCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
        langCookie.setPath("/"); // 전체 경로에 적용
        response.addCookie(langCookie);

        // 이전 페이지로 리다이렉트
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "home.jsp");
    }
}
