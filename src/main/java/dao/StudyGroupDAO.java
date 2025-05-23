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

            // 1. Insert into studygroup
            String insertGroup = "INSERT INTO studygroup(subject, max_members, created_by, created_at) VALUES (?, ?, ?, NOW())";
            pstmt1 = conn.prepareStatement(insertGroup, Statement.RETURN_GENERATED_KEYS);
            pstmt1.setString(1, subject);
            pstmt1.setInt(2, max);
            pstmt1.setString(3, leaderId);
            pstmt1.executeUpdate();
            rs = pstmt1.getGeneratedKeys();
            rs.next();
            int groupId = rs.getInt(1);

            // 2. Insert leader into study_member
            pstmt2 = conn.prepareStatement("INSERT INTO study_member(group_id, user_id, role, joined_at) VALUES (?, ?, 'LEADER', NOW())");
            pstmt2.setInt(1, groupId);
            pstmt2.setString(2, leaderId);
            pstmt2.executeUpdate();

            // 3. Insert match log
            pstmt3 = conn.prepareStatement("INSERT INTO match_log(group_id, matched_users, status, created_at) VALUES (?, ?, '모집중', NOW())");
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
        }
    }
}
