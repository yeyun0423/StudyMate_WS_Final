package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ProfileImageDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String userId = request.getParameter("userId");

        UserDAO dao = new UserDAO();
        UserDTO user = dao.getUserById(userId);

        if (user != null) {
            user.setProfileImage("default.png");
            boolean updated = dao.updateUser(user);

            if (updated) {
                session.setAttribute("profileImage", "default.png");
            }
        }

        response.sendRedirect("profile.jsp");
    }
}
