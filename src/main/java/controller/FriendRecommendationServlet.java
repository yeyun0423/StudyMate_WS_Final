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


public class FriendRecommendationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	 System.out.println("FriendRecommendationServlet 진입"); 
    	String subject = request.getParameter("subject");
        String currentUserId = (String) request.getSession().getAttribute("userId");

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        boolean selfJoined = false;
        List<String> friendsJsonList = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {

            // 1. 본인이 해당 과목 스터디에 참여 중인지 확인
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

            // 2. 추천 친구 목록 조회 (과목 수강 중이면서 자신 제외)
            String sql = """
                SELECT DISTINCT u.user_id, u.name, u.profile_image,
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
                        String userId = rs.getString("user_id");
                        String name = rs.getString("name");
                        String profileImage = rs.getString("profile_image");
                        boolean isJoined = rs.getBoolean("is_joined");

                        // 프로필 이미지가 없으면 기본 이미지 지정
                        if (profileImage == null || profileImage.trim().isEmpty()) {
                            profileImage = "default.png";
                        }

                        String friendJson = String.format(
                            "{\"userId\":\"%s\",\"name\":\"%s\",\"profileImage\":\"%s\",\"joined\":%s}",
                            userId,
                            name,
                            profileImage,
                            isJoined
                        );
                        friendsJsonList.add(friendJson);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 최종 JSON 응답
        String resultJson = String.format(
            "{\"selfJoined\": %s, \"friends\": [%s]}",
            selfJoined,
            String.join(",", friendsJsonList)
        );

        out.print(resultJson);
    }
}
