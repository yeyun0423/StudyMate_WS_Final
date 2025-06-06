package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FriendRecommendationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("FriendRecommendationServlet 진입");
        String subject = request.getParameter("subject");
        String currentUserId = (String) request.getSession().getAttribute("userId");

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        StudyGroupDAO dao = new StudyGroupDAO();
        boolean selfJoined = dao.isUserJoined(currentUserId, subject);
        List<Map<String, Object>> friends = dao.getRecommendedFriends(currentUserId, subject);

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

        String resultJson = String.format(
            "{\"selfJoined\": %s, \"friends\": [%s]}",
            selfJoined,
            String.join(",", friendsJsonList)
        );

        out.print(resultJson);
    }
}
