package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RandomStudyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 파라미터 추출
        String subject = request.getParameter("subject");
        int memberCount = Integer.parseInt(request.getParameter("memberCount"));
        String userId = (String) request.getSession().getAttribute("userId");

        // 응답 타입 설정
        response.setContentType("text/plain; charset=UTF-8");

        try {
            // DAO 객체 생성 후 메서드 호출
            StudyGroupDAO dao = new StudyGroupDAO();
            String message = dao.createRandomStudyGroup(subject, memberCount, userId);
            response.getWriter().print(message);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("오류 발생: " + e.getMessage());
        }
    }
}
