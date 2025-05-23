package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();


        boolean valid = dao.login(userId, password);

        if (valid) {
            String name = dao.getNameById(userId);
            boolean isAdmin = dao.isAdmin(userId);

            // 세션 저장 (보안 정보)
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("isAdmin", isAdmin);

            // 쿠키 저장 (null 검사 추가)
            if (name != null) {
                Cookie nameCookie = new Cookie("user_name", name);
                nameCookie.setMaxAge(60 * 60 * 24 * 7);
                nameCookie.setPath("/");
                response.addCookie(nameCookie);
            }

            Cookie langCookie = new Cookie("lang", "ko");
            langCookie.setMaxAge(60 * 60 * 24 * 30);
            langCookie.setPath("/");
            response.addCookie(langCookie);
            
            // redirect는 반드시 출력 전에!
            response.sendRedirect("home.jsp");
            
            System.out.println("로그인 성공 - home.jsp로 리다이렉트 예정");

         
        }

    }
}
