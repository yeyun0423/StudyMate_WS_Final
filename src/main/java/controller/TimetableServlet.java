package controller;

import dao.TimetableDAO;
import dto.TimetableDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class TimetableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String day = request.getParameter("day");
        int period = Integer.parseInt(request.getParameter("period"));
        String subject = request.getParameter("subject");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        TimetableDTO t = new TimetableDTO();
        t.setUserId(userId);
        t.setDayOfWeek(day);
        t.setPeriod(period);
        t.setSubject(subject);

        boolean result = new TimetableDAO().insertTimetable(t);

        response.sendRedirect("timetable.jsp");
    }
}
