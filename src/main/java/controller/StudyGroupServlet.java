package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import dao.StudyGroupDAO;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 스터디 그룹 생성과 추천 친구 목록 요청을 처리하는 서블릿
public class StudyGroupServlet extends HttpServlet {

    // 친구 추천 목록 요청 처리
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String command = request.getParameter("command");

        if ("fetchFriends".equals(command)) {
            String subject = request.getParameter("subject");

            // 추천 가능한 친구 목록 조회
            List<String> friends = StudyGroupDAO.getAvailableUsersBySubject(subject);

            // JSON 형식으로 응답
            response.setContentType("application/json; charset=UTF-8");
            StringBuilder sb = new StringBuilder("[");
            for (int i = 0; i < friends.size(); i++) {
                sb.append("\"").append(friends.get(i)).append("\"");
                if (i < friends.size() - 1) sb.append(",");
            }
            sb.append("]");
            response.getWriter().write(sb.toString());
        }
    }

    // 스터디 그룹 생성 요청 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String command = request.getParameter("command");

        if ("createStudy".equals(command)) {
            String subject = request.getParameter("subject");                  // 과목명
            int maxMembers = Integer.parseInt(request.getParameter("max_members"));
            String[] friendsArray = request.getParameterValues("friends[]");  // 선택한 친구들
            String userId = (String) request.getSession().getAttribute("userId"); // 현재 사용자

            // 배열을 리스트로 변환
            List<String> friends = Arrays.asList(friendsArray);

            // 스터디 그룹 생성 시도
            boolean success = StudyGroupDAO.createStudyGroup(userId, subject, maxMembers, friends);

            // 결과 응답
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write(success ? "스터디 생성 완료!" : "스터디 생성 실패...");
        }
    }
}
