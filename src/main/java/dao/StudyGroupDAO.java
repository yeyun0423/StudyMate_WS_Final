package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.StudyGroupDTO;
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

    public List<StudyGroupDTO> getAllStudyGroupsWithMembers() {
        List<StudyGroupDTO> list = new ArrayList<>();

        String groupQuery = "SELECT sg.group_id, sg.subject, sg.created_at, u1.name AS leader_name " +
                            "FROM study_group sg " +
                            "JOIN user u1 ON sg.created_by = u1.user_id " +
                            "ORDER BY sg.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(groupQuery);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                StudyGroupDTO dto = new StudyGroupDTO();
                int groupId = rs.getInt("group_id");

                dto.setGroupId(groupId);
                dto.setSubject(rs.getString("subject"));
                dto.setLeaderName(rs.getString("leader_name"));
                dto.setCreatedAt(rs.getString("created_at"));

                // 멤버 이름들 조회
                String memberQuery = "SELECT u.name FROM study_member sm " +
                                     "JOIN user u ON sm.user_id = u.user_id " +
                                     "WHERE sm.group_id = ? AND sm.role = 'MEMBER'";

                try (PreparedStatement memberStmt = conn.prepareStatement(memberQuery)) {
                    memberStmt.setInt(1, groupId);
                    try (ResultSet mrs = memberStmt.executeQuery()) {
                        List<String> memberNames = new ArrayList<>();
                        while (mrs.next()) {
                            memberNames.add(mrs.getString("name"));
                        }
                        dto.setMemberNames(memberNames);
                    }
                }

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<StudyGroupDTO> getStudyGroupsByUser(String userId) {
        List<StudyGroupDTO> list = new ArrayList<>();

        String sql = "SELECT sg.group_id, sg.subject, sg.created_at, sg.created_by, u_leader.name AS leader_name " +
                     "FROM study_member sm " +
                     "JOIN study_group sg ON sm.group_id = sg.group_id " +
                     "JOIN user u_leader ON sg.created_by = u_leader.user_id " +
                     "WHERE sm.user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    StudyGroupDTO dto = new StudyGroupDTO();
                    int groupId = rs.getInt("group_id");

                    dto.setGroupId(groupId); // ✅ 반드시 필요
                    dto.setLeaderId(rs.getString("created_by")); // ✅ 리더 아이디 추가
                    dto.setSubject(rs.getString("subject"));
                    dto.setCreatedAt(rs.getString("created_at"));
                    dto.setLeaderName(rs.getString("leader_name"));

                    // 멤버 이름 조회 (리더 제외)
                    List<String> memberNames = new ArrayList<>();
                    String memberSql = "SELECT u.name FROM study_member sm " +
                                       "JOIN user u ON sm.user_id = u.user_id " +
                                       "WHERE sm.group_id = ? AND sm.role = 'MEMBER'";
                    try (PreparedStatement memberStmt = conn.prepareStatement(memberSql)) {
                        memberStmt.setInt(1, groupId);
                        try (ResultSet mrs = memberStmt.executeQuery()) {
                            while (mrs.next()) {
                                memberNames.add(mrs.getString("name"));
                            }
                        }
                    }

                    dto.setMemberNames(memberNames);
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // 스터디 그룹 탈퇴
    public static boolean leaveStudyGroup(int groupId, String userId) {
        String sql = "DELETE FROM study_member WHERE group_id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, groupId);
            pstmt.setString(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 리더가 스터디 그룹 삭제
    public static boolean deleteStudyGroup(int groupId) {
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            // 1. study_member 삭제
            try (PreparedStatement pstmt1 = conn.prepareStatement("DELETE FROM study_member WHERE group_id = ?")) {
                pstmt1.setInt(1, groupId);
                pstmt1.executeUpdate();
            }

            // 2. match_log 삭제
            try (PreparedStatement pstmt2 = conn.prepareStatement("DELETE FROM match_log WHERE group_id = ?")) {
                pstmt2.setInt(1, groupId);
                pstmt2.executeUpdate();
            }

            // 3. study_group 삭제
            try (PreparedStatement pstmt3 = conn.prepareStatement("DELETE FROM study_group WHERE group_id = ?")) {
                pstmt3.setInt(1, groupId);
                pstmt3.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}  