package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import util.PasswordHasher;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

public class ProfileUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

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

            // 비밀번호 변경 요청이 있을 경우 검증
            if (newPw != null && !newPw.isEmpty()) {
                if (!PasswordHasher.encrypt(currentPw).equals(user.getPassword())) {
                    response.sendRedirect("profile.jsp?error=wrongpassword");
                    return;
                }

                if (newPw.equals(confirmPw)) {
                    user.setPassword(PasswordHasher.encrypt(newPw));
                } else {
                    response.sendRedirect("profile.jsp?error=nomatch");
                    return;
                }
            }

            user.setName(name);

            if (birthStr != null && !birthStr.trim().isEmpty()) {
                user.setBirthDate(new SimpleDateFormat("yyyy-MM-dd").parse(birthStr));
            }

            boolean updated = dao.updateUser(user);

            if (updated) {
                session.setAttribute("userName", user.getName());

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