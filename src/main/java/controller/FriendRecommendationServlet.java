package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

// 과목 선택에 따라 추천 가능한 친구 목록을 JSON으로 반환하는 서블릿
public class FriendRecommendationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String subject = request.getParameter("subject");
        String currentUserId = (String) request.getSession().getAttribute("userId");

        // 응답 타입은 JSON 
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 사용자 참여 여부 + 추천 친구 목록 가져오기
        StudyGroupDAO dao = new StudyGroupDAO();
        boolean selfJoined = dao.isUserJoined(currentUserId, subject);
        List<Map<String, Object>> friends = dao.getRecommendedFriends(currentUserId, subject);

        // 친구 목록을 JSON 문자열로 구성
        List<String> friendsJsonList = new ArrayList<>();
        for (Map<String, Object> f : friends) {
            String friendJson = String.format(
                "{\"userId\":\"%s\",\"name\":\"%s\",\"profileImage\":\"%s\",\"joined\":%s}",
                f.get("userId"),
                f.get("name"),
                f.get("profileImage"),
                f.get("joined")
            );
            friendsJsonList.add(friendJson);
        }

        // 최종 응답 형식: 본인 참여 여부 + 친구 목록
        String resultJson = String.format(
            "{\"selfJoined\": %s, \"friends\": [%s]}",
            selfJoined,
            String.join(",", friendsJsonList)
        );

        out.print(resultJson);
    }
}
