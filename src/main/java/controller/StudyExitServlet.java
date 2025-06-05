package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


public class StudyExitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String groupIdStr = request.getParameter("groupId");
        String userId = request.getParameter("userId");

        if (groupIdStr == null || userId == null) {
            response.sendRedirect("mystudygroup.jsp");
            return;
        }

        int groupId = Integer.parseInt(groupIdStr);
        boolean success = StudyGroupDAO.leaveStudyGroup(groupId, userId);

        response.sendRedirect("mystudygroup.jsp?message=" + (success ? "exit_success" : "exit_fail"));
    }
}
