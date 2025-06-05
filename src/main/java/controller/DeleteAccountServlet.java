package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
public class DeleteAccountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if (userId == null) {
            userId = request.getParameter("userId"); // fallback 처리
        }
        

        if (userId != null) {
            UserDAO dao = new UserDAO();
            boolean deleted = dao.deleteUser(userId);

            if (deleted) {
                session.invalidate();
                response.sendRedirect("login.jsp?message=deleted");
            } else {
                response.sendRedirect("profile.jsp?error=deletefail");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
