package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import util.SHA256Util;

import java.io.IOException;


public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userId = request.getParameter("userId");
        String rawPassword = request.getParameter("password");

   
        // → UserDAO.login() 내부에서 SHA256 암호화하여 비교
        UserDAO dao = new UserDAO();
        boolean valid = dao.login(userId, rawPassword);

        if (valid) {
            String name = dao.getNameById(userId);
            boolean isAdmin = dao.isAdmin(userId);

            // 세션 저장
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("isAdmin", isAdmin);

            // 쿠키 저장
            if (name != null) {
                Cookie nameCookie = new Cookie("user_name", name);
                nameCookie.setMaxAge(60 * 60 * 24 * 7); // 7일
                nameCookie.setPath("/");
                response.addCookie(nameCookie);
            }

            Cookie langCookie = new Cookie("lang", "ko");
            langCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
            langCookie.setPath("/");
            response.addCookie(langCookie);

            response.sendRedirect("home.jsp");
            System.out.println("로그인 성공 - " + userId);
        } else {
            System.out.println("로그인 실패 - " + userId);
            response.sendRedirect("login.jsp?message=invalid");
        }
    }
}
