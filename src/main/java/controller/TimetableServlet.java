package controller;

import dao.TimetableDAO;
import dto.TimetableDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// 사용자의 시간표 등록 요청을 처리하는 서블릿
public class TimetableServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 폼에서 전달된 데이터 추출
        String day = request.getParameter("day");
        int period = Integer.parseInt(request.getParameter("period"));
        String subject = request.getParameter("subject");

        // 세션에서 사용자 ID 가져오기
        String userId = (String) request.getSession().getAttribute("userId");

        // DTO에 시간표 정보 담기
        TimetableDTO timetable = new TimetableDTO();
        timetable.setUserId(userId);
        timetable.setDayOfWeek(day);
        timetable.setPeriod(period);
        timetable.setSubject(subject);

        // DB에 저장
        new TimetableDAO().insertTimetable(timetable);

        // 시간표 페이지로 이동
        response.sendRedirect("timetable.jsp");
    }
}
