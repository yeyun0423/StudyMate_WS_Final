package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;
import util.DBUtil;

public class StudyGroupDAO {
    public static List<String> getAvailableUsersBySubject(String subject) {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT user_id FROM timetable
            WHERE subject = ? AND user_id NOT IN (
                SELECT user_id FROM study_member
            )
        """;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, subject);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("user_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean createStudyGroup(String leaderId, String subject, int max, List<String> friends) {
        Connection conn = null;
        PreparedStatement pstmt1 = null, pstmt2 = null, pstmt3 = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // 1. 스터디 그룹 생성
            String insertGroup = "INSERT INTO study_group(subject, max_members, created_by, created_at) VALUES (?, ?, ?, NOW())";
            pstmt1 = conn.prepareStatement(insertGroup, Statement.RETURN_GENERATED_KEYS);
            pstmt1.setString(1, subject);
            pstmt1.setInt(2, max);
            pstmt1.setString(3, leaderId);
            pstmt1.executeUpdate();

            rs = pstmt1.getGeneratedKeys();
            rs.next();
            int groupId = rs.getInt(1);

            // 2. 리더 등록
            pstmt2 = conn.prepareStatement("INSERT INTO study_member(group_id, user_id, role, joined_at) VALUES (?, ?, ?, NOW())");
            pstmt2.setInt(1, groupId);
            pstmt2.setString(2, leaderId);
            pstmt2.setString(3, "LEADER");
            pstmt2.executeUpdate();

            // 3. 친구들 등록 
            pstmt2 = conn.prepareStatement("INSERT INTO study_member(group_id, user_id, role, joined_at) VALUES (?, ?, 'MEMBER', NOW())");
            for (String friendId : friends) {
                pstmt2.setInt(1, groupId);
                pstmt2.setString(2, friendId);
                pstmt2.addBatch();
            }
            pstmt2.executeBatch();

            // 4. 매치 로그
            pstmt3 = conn.prepareStatement("INSERT INTO match_log(group_id, matched_users, status, created_at) VALUES (?, ?, 'RECRUITING', NOW())");
            pstmt3.setInt(1, groupId);
            pstmt3.setString(2, String.join(",", friends));
            pstmt3.executeUpdate();

            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (SQLException ignored) {}
            return false;
        } finally {
            DBUtil.close(rs, pstmt1, conn);
            try { if (pstmt2 != null) pstmt2.close(); } catch (Exception ignored) {}
            try { if (pstmt3 != null) pstmt3.close(); } catch (Exception ignored) {}
        }
    }
    
    public static boolean isUserAlreadyInSubject(String userId, String subject) {
        String sql = """
            SELECT COUNT(*) 
            FROM study_member sm
            JOIN study_group sg ON sm.group_id = sg.group_id
            WHERE sm.user_id = ? AND sg.subject = ?
        """;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, subject);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



}
