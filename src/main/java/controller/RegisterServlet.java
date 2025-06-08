package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import util.PasswordHasher;

import java.io.IOException;
import java.text.SimpleDateFormat;

// 회원가입 요청을 처리하는 서블릿
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 사용자 입력값 가져오기
        String name = request.getParameter("name");
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String birth = request.getParameter("birthDate");
        String inputAdminCode = request.getParameter("adminCode");

        // 관리자 여부 확인 (web.xml 설정값과 비교)
        String configAdminCode = getServletContext().getInitParameter("adminCode");
        boolean isAdmin = configAdminCode != null && configAdminCode.equals(inputAdminCode);

        try {
            // 사용자 정보를 DTO에 담기
            UserDTO user = new UserDTO();
            user.setName(name);
            user.setUserId(userId);
            user.setPassword(PasswordHasher.encrypt(password)); // 비밀번호 암호화
            user.setBirthDate(new SimpleDateFormat("yyyy-MM-dd").parse(birth));
            user.setIsAdmin(isAdmin);

            // 회원가입 처리
            boolean registered = new UserDAO().register(user);

            if (registered) {
                // 성공 시 로그인 페이지로 이동
                response.getWriter().println("<script>");
                response.getWriter().println("if (confirm('성공적으로 회원가입 되었습니다!')) {");
                response.getWriter().println("  window.location.href = 'login.jsp';");
                response.getWriter().println("} else {");
                response.getWriter().println("  window.location.href = 'register.jsp';");
                response.getWriter().println("}");
                response.getWriter().println("</script>");
            } else {
                // 실패 시 회원가입 페이지로 다시 이동
                request.setAttribute("error", "회원가입 실패!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // 예외 발생 시 서버 에러로 처리
            throw new ServletException(e);
        }
    }
}
