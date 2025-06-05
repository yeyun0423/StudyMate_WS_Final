package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import util.PasswordHasher;

import java.io.IOException;
import java.text.SimpleDateFormat;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String name = request.getParameter("name");
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String birth = request.getParameter("birthDate");
        String inputAdminCode = request.getParameter("adminCode");

        // web.xml에서 관리자 코드 가져오기
        String configAdminCode = getServletContext().getInitParameter("adminCode");
        boolean isAdmin = configAdminCode != null && configAdminCode.equals(inputAdminCode);

        try {
            UserDTO user = new UserDTO();
            user.setName(name);
            user.setUserId(userId);
            user.setPassword(PasswordHasher.encrypt(password));
            user.setBirthDate(new SimpleDateFormat("yyyy-MM-dd").parse(birth));
            user.setIsAdmin(isAdmin);

            boolean registered = new UserDAO().register(user);

            if (registered) {
                response.getWriter().println("<script>");
                response.getWriter().println("if (confirm('성공적으로 회원가입 되었습니다!')) {");
                response.getWriter().println("  window.location.href = 'login.jsp';");
                response.getWriter().println("} else {");
                response.getWriter().println("  window.location.href = 'register.jsp';");
                response.getWriter().println("}");
                response.getWriter().println("</script>");
            } else {
                request.setAttribute("error", "회원가입 실패!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
