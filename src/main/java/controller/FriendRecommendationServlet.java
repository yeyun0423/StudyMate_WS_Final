package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;

@WebServlet("/getRecommendedFriends")
public class FriendRecommendationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String subject = request.getParameter("subject");
        String currentUserId = (String) request.getSession().getAttribute("userId");

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        boolean selfJoined = false;
        List<String> friendsJsonList = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {

            // ✅ 1. 본인이 해당 과목 스터디에 참여 중인지 확인
            String checkSql = """
                SELECT 1 FROM study_member sm
                JOIN study_group sg ON sm.group_id = sg.group_id
                WHERE sm.user_id = ? AND sg.subject = ?
                LIMIT 1
            """;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, currentUserId);
                checkStmt.setString(2, subject);
                try (ResultSet checkRs = checkStmt.executeQuery()) {
                    if (checkRs.next()) {
                        selfJoined = true;
                    }
                }
            }

            // ✅ 2. 추천 친구 조회 (같은 과목 timetable 등록자 중, 자신 제외)
            String sql = """
                SELECT DISTINCT u.user_id, u.name,
                       EXISTS (
                         SELECT 1 FROM study_member sm
                         JOIN study_group sg ON sm.group_id = sg.group_id
                         WHERE sm.user_id = u.user_id AND sg.subject = ?
                       ) AS is_joined
                FROM user u
                JOIN timetable t ON u.user_id = t.user_id
                WHERE t.subject = ? AND u.user_id != ?
            """;

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, subject);
                pstmt.setString(2, subject);
                pstmt.setString(3, currentUserId);

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        String friendJson = String.format(
                                "{\"userId\":\"%s\",\"name\":\"%s\",\"joined\":%s}",
                                rs.getString("user_id"),
                                rs.getString("name"),
                                rs.getBoolean("is_joined")
                        );
                        friendsJsonList.add(friendJson);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ 최종 JSON 응답: { "selfJoined": true/false, "friends": [ ... ] }
        String resultJson = String.format(
                "{\"selfJoined\": %s, \"friends\": [%s]}",
                selfJoined,
                String.join(",", friendsJsonList)
        );
        out.print(resultJson);
    }
}
