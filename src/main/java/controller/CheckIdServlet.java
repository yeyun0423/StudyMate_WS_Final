package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CheckIdServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String userId = request.getParameter("userId");
        UserDAO dao = new UserDAO();
        boolean exists = dao.checkIdExists(userId);

        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(exists ? "exists" : "available");
    }
}
