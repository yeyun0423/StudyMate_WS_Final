package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import util.PasswordHasher;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

// 회원 정보 수정 및 비밀번호 변경을 처리하는 서블릿
public class ProfileUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        // 폼에서 전달된 데이터 꺼내기
        String name = request.getParameter("name");
        String birthStr = request.getParameter("birthDate");
        String currentPw = request.getParameter("currentPassword");
        String newPw = request.getParameter("newPassword");
        String confirmPw = request.getParameter("confirmPassword");

        try {
            UserDAO dao = new UserDAO();
            UserDTO user = dao.getUserById(userId);

            if (user == null) {
                response.sendRedirect("profile.jsp?error=nouser");
                return;
            }

            // 비밀번호 변경 요청이 있는 경우 처리
            if (newPw != null && !newPw.isEmpty()) {
                // 현재 비밀번호 확인
                if (!PasswordHasher.encrypt(currentPw).equals(user.getPassword())) {
                    response.sendRedirect("profile.jsp?error=wrongpassword");
                    return;
                }

                // 새 비밀번호와 확인 비밀번호 일치 여부 확인
                if (newPw.equals(confirmPw)) {
                    user.setPassword(PasswordHasher.encrypt(newPw));
                } else {
                    response.sendRedirect("profile.jsp?error=nomatch");
                    return;
                }
            }

            // 이름 수정
            user.setName(name);

            // 생년월일 수정 (값이 있으면만 반영)
            if (birthStr != null && !birthStr.trim().isEmpty()) {
                user.setBirthDate(new SimpleDateFormat("yyyy-MM-dd").parse(birthStr));
            }

            // DB 반영
            boolean updated = dao.updateUser(user);

            if (updated) {
                // 세션 이름 갱신
                session.setAttribute("userName", user.getName());

                // 완료 알림
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("if (confirm('회원 정보 수정이 완료되었습니다!')) {");
                out.println("  window.location.href = 'profile.jsp';");
                out.println("} else {");
                out.println("  window.location.href = 'profile.jsp';");
                out.println("}");
                out.println("</script>");
            } else {
                response.sendRedirect("profile.jsp?error=updatefail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
