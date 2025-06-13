package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// 프로필 이미지를 기본 이미지로 바꾸는 서블릿
public class ProfileImageDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String userId = request.getParameter("userId");

        UserDAO dao = new UserDAO();
        UserDTO user = dao.getUserById(userId);

        // 유저 정보가 있으면 이미지 경로를 기본 이미지로 바꿔줌
        if (user != null) {
            user.setProfileImage("default.png");
            boolean updated = dao.updateUser(user);

            // DB 업데이트 성공 시 세션 정보도 같이 수정
            if (updated) {
                session.setAttribute("profileImage", "default.png");
            }
        }

        // 다시 프로필 페이지로 이동
        response.sendRedirect("profile.jsp");
    }
}
