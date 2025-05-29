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
        PrintWriter out = response.getWriter();

        // 1. 아이디 존재 여부 확인
        boolean idExists = dao.checkIdExists(userId);

        if (!idExists) {
            out.println("<script>");
            out.println("if (confirm('존재하지 않는 회원입니다. 회원가입 하시겠습니까?')) {");
            out.println("  window.location.href = 'register.jsp';");
            out.println("} else {");
            out.println("  window.location.href = 'login.jsp';");
            out.println("}");
            out.println("</script>");
            return;
        }

        // 2. 로그인 시도
        boolean valid = dao.login(userId, password);

        if (valid) {
            String name = dao.getNameById(userId);
            boolean isAdmin = dao.isAdmin(userId);
            String profileImage = dao.getProfileImageById(userId); // ✅ 프로필 이미지 가져오기

            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("userName", name);
            session.setAttribute("isAdmin", isAdmin);
            session.setAttribute("profileImage", profileImage); // ✅ 세션에 이미지 저장

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

            response.sendRedirect("home.jsp");
            System.out.println("로그인 성공 - home.jsp로 리다이렉트");
        } else {
            out.println("<script>");
            out.println("alert('아이디나 비밀번호가 틀렸습니다.');");
            out.println("window.location.href = 'login.jsp';");
            out.println("</script>");
        }
    }
}
