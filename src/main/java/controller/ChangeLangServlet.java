package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

// 사용자의 언어 설정을 변경하고 쿠키에 저장하는 서블릿
public class ChangeLangServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("user_id");
        String langCode = request.getParameter("lang_code");

        // 유효하지 않은 값이면 기본값은 한국어
        if (langCode == null || (!langCode.equals("ko") && !langCode.equals("en"))) {
            langCode = "ko";
        }

        // 언어 설정을 쿠키에 저장 (30일 유지)
        Cookie langCookie = new Cookie("lang", langCode);
        langCookie.setMaxAge(60 * 60 * 24 * 30);  // 30일짜리 쿠키
        langCookie.setPath("/");  // 모든 경로에서 적용
        response.addCookie(langCookie);

        // 사용자가 머물던 페이지로 다시 이동
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "home.jsp");
    }
}
