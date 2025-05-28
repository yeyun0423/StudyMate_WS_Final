package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.DBUtil;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/RandomStudyServlet")
public class RandomStudyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String subject = request.getParameter("subject");
        int memberCount = Integer.parseInt(request.getParameter("memberCount"));
        String userId = (String) request.getSession().getAttribute("userId");

        response.setContentType("text/plain; charset=UTF-8");

        try (Connection conn = DBUtil.getConnection()) {

            // 1. 추천 가능한 친구 중 참여하지 않은 사람만
            String sql = """
                SELECT DISTINCT u.user_id FROM user u
                JOIN timetable t ON u.user_id = t.user_id
                WHERE t.subject = ? AND u.user_id != ?
                AND NOT EXISTS (
                    SELECT 1 FROM study_member sm
                    JOIN study_group sg ON sm.group_id = sg.group_id
                    WHERE sm.user_id = u.user_id AND sg.subject = ?
                )
            """;

            List<String> candidates = new ArrayList<>();
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, subject);
                pstmt.setString(2, userId);
                pstmt.setString(3, subject);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        candidates.add(rs.getString("user_id"));
                    }
                }
            }

            // 2. 랜덤 셔플 후 memberCount-1명 선택
            Collections.shuffle(candidates);
            List<String> selected = candidates.stream().limit(memberCount - 1).toList();

            // 3. 그룹 생성
            int groupId = -1;
            String insertGroup = "INSERT INTO study_group(subject, max_members, created_by) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(insertGroup, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, subject);
                pstmt.setInt(2, memberCount);
                pstmt.setString(3, userId);
                pstmt.executeUpdate();

                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) groupId = rs.getInt(1);
                }
            }

            // 4. 본인 + 친구들 멤버 추가
            String insertMember = "INSERT INTO study_member(group_id, user_id, role) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(insertMember)) {
                pstmt.setInt(1, groupId);
                pstmt.setString(2, userId);
                pstmt.setString(3, "LEADER");
                pstmt.executeUpdate();

                for (String friend : selected) {
                    pstmt.setInt(1, groupId);
                    pstmt.setString(2, friend);
                    pstmt.setString(3, "MEMBER");
                    pstmt.executeUpdate();
                }
            }

            // 5. 매칭 로그 추가
            String insertLog = "INSERT INTO match_log(group_id, matched_users) VALUES (?, ?)";
            String matched = String.join(",", selected);
            try (PreparedStatement pstmt = conn.prepareStatement(insertLog)) {
                pstmt.setInt(1, groupId);
                pstmt.setString(2, matched);
                pstmt.executeUpdate();
            }

            response.getWriter().print("랜덤 스터디 그룹이 성공적으로 생성되었습니다!");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("오류 발생: " + e.getMessage());
        }
    }
}
