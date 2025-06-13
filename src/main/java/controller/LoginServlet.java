package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

// 로그인 요청을 처리하고 세션과 쿠키를 설정하는 서블릿
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        PrintWriter out = response.getWriter();

        // 아이디가 존재하는지 먼저 확인
        boolean idExists = dao.checkIdExists(userId);

        if (!idExists) {
            // 존재하지 않으면 회원가입 유도
            out.println("<script>");
            out.println("if (confirm('존재하지 않는 회원입니다. 회원가입 하시겠습니까?')) {");
            out.println("  window.location.href = 'register.jsp';");
            out.println("} else {");
            out.println("  window.location.href = 'login.jsp';");
            out.println("}");
            out.println("</script>");
            return;
        }

        // 아이디는 존재하니까 비밀번호 확인
        boolean valid = dao.login(userId, password);

        if (valid) {
            // 로그인 성공 시 사용자 정보 불러오기
            UserDTO user = dao.getUserById(userId);
            boolean isAdmin = dao.isAdmin(userId);

            // 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("isAdmin", isAdmin);
            session.setAttribute("profileImage", user.getProfileImage());

            // 이름 쿠키 저장 
            if (user.getName() != null) {
                Cookie nameCookie = new Cookie("user_name", user.getName());
                nameCookie.setMaxAge(60 * 60 * 24 * 7); // 1주일
                nameCookie.setPath("/");
                response.addCookie(nameCookie);
            }

            // 기본 언어 쿠키 설정 (ko)
            Cookie langCookie = new Cookie("lang", "ko");
            langCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
            langCookie.setPath("/");
            response.addCookie(langCookie);

            // 홈으로 이동
            response.sendRedirect("home.jsp");

        } else {
            // 비밀번호가 틀린 경우
            out.println("<script>");
            out.println("alert('아이디나 비밀번호가 틀렸습니다.');");
            out.println("window.location.href = 'login.jsp';");
            out.println("</script>");
        }
    }
}
