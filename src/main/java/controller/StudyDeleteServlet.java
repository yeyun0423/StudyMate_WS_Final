package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


public class StudyDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String groupIdStr = request.getParameter("groupId");

        if (groupIdStr == null) {
            response.sendRedirect("mystudygroup.jsp");
            return;
        }

        int groupId = Integer.parseInt(groupIdStr);
        boolean success = StudyGroupDAO.deleteStudyGroup(groupId);

        response.sendRedirect("mystudygroup.jsp?message=" + (success ? "delete_success" : "delete_fail"));
    }
}
