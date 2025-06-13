package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.http.*;
import java.io.IOException;

// 랜덤 스터디 생성 요청 처리
public class RandomStudyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 요청값: 과목, 인원 수, 로그인 사용자 ID
        String subject = request.getParameter("subject");
        int memberCount = Integer.parseInt(request.getParameter("memberCount"));
        String userId = (String) request.getSession().getAttribute("userId");

        response.setContentType("text/plain; charset=UTF-8");

        try {
            // DAO를 통해 랜덤 스터디 생성 시도
            StudyGroupDAO dao = new StudyGroupDAO();
            String message = dao.createRandomStudyGroup(subject, memberCount, userId);

            // 결과 메시지 반환 
            response.getWriter().print(message);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("오류 발생: " + e.getMessage());
        }
    }
}
