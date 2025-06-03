package dao;

import dto.UserDTO;
import util.DBUtil;
import util.SHA256Util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean register(UserDTO user) {
        String sql = "INSERT INTO user (user_id, name, password, birth_date, is_admin) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getPassword());
            pstmt.setDate(4, new java.sql.Date(user.getBirthDate().getTime()));
            pstmt.setBoolean(5, user.isAdmin());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkIdExists(String userId) {
        String sql = "SELECT user_id FROM user WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean login(String userId, String password) {
        String sql = "SELECT password FROM user WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                String inputHash = SHA256Util.encrypt(password);
                return storedHash.equals(inputHash);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public UserDTO getUserById(String userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getString("user_id"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));  // 암호화된 값
                user.setBirthDate(rs.getDate("birth_date"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setIsAdmin(rs.getBoolean("is_admin"));
                user.setJoinDate(rs.getTimestamp("join_date"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean updateUser(UserDTO user) {
        String sql = "UPDATE user SET name = ?, password = ?, birth_date = ?, profile_image = ? WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPassword());  // 암호화된 값 또는 기존값
            pstmt.setDate(3, new java.sql.Date(user.getBirthDate().getTime()));
            pstmt.setString(4, user.getProfileImage());
            pstmt.setString(5, user.getUserId());

            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteUser(String userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public String getNameById(String userId) {
        String sql = "SELECT name FROM user WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) return rs.getString("name");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateUserProfileImage(String userId, String profileImage) {
        String sql = "UPDATE user SET profile_image = ? WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, profileImage);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public String getProfileImageById(String userId) {
        String profileImage = null;
        String sql = "SELECT profile_image FROM user WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                profileImage = rs.getString("profile_image");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return profileImage;
    }




    public boolean isAdmin(String userId) {
        String sql = "SELECT is_admin FROM user WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) return rs.getBoolean("is_admin");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 전체 유저 수 (페이징용)
    public int getUserCount() {
        String sql = "SELECT COUNT(*) FROM user";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 유저 목록 가져오기 (페이지당 5명)
    public List<UserDTO> getUsersByPage(int page, int limit) {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY join_date DESC LIMIT ? OFFSET ?";
        int offset = (page - 1) * limit;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    UserDTO u = new UserDTO();
                    u.setUserId(rs.getString("user_id"));
                    u.setName(rs.getString("name"));
                    u.setPassword(rs.getString("password"));
                    u.setJoinDate(rs.getTimestamp("join_date"));
                    u.setProfileImage(rs.getString("profile_image"));
                    list.add(u);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
 // 이름 또는 아이디에 검색어가 포함된 유저 리스트를 페이징으로 가져오기
    public List<UserDTO> searchUsersByPage(String keyword, int page, int limit) {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE user_id LIKE ? OR name LIKE ? ORDER BY join_date DESC LIMIT ?, ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setInt(3, (page - 1) * limit);
            pstmt.setInt(4, limit);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                UserDTO u = new UserDTO();
                u.setUserId(rs.getString("user_id"));
                u.setName(rs.getString("name"));
                u.setPassword(rs.getString("password"));
                u.setJoinDate(rs.getTimestamp("join_date"));
                u.setProfileImage(rs.getString("profile_image"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 검색 결과 총 유저 수 반환
    public int getSearchUserCount(String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM user WHERE user_id LIKE ? OR name LIKE ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

 // 관리자가 전체 유저 목록에서 삭제 버튼 누를 시
    public void deleteAllUserData(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // ✅ 트랜잭션 시작

            // 1. Q&A 답변 삭제 (사용자의 글에 달린 관리자 답변 포함)
            String deleteReplies = "DELETE FROM board_reply WHERE post_id IN (SELECT post_id FROM board_post WHERE writer_id = ?)";
            pstmt = conn.prepareStatement(deleteReplies);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 2. 사용자의 게시글 삭제
            String deletePosts = "DELETE FROM board_post WHERE writer_id = ?";
            pstmt = conn.prepareStatement(deletePosts);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 3. 시간표 삭제
            String deleteTimetable = "DELETE FROM timetable WHERE user_id = ?";
            pstmt = conn.prepareStatement(deleteTimetable);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 4. 스터디 멤버 삭제
            String deleteStudyMember = "DELETE FROM study_member WHERE user_id = ?";
            pstmt = conn.prepareStatement(deleteStudyMember);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 5. 사용자가 쓴 댓글 삭제
            String deleteComments = "DELETE FROM board_comment WHERE writer_id = ?";
            pstmt = conn.prepareStatement(deleteComments);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 6. 유저 자체 삭제
            String deleteUser = "DELETE FROM user WHERE user_id = ?";
            pstmt = conn.prepareStatement(deleteUser);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            conn.commit(); // ✅ 트랜잭션 커밋
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // ❌ 예외 발생 시 롤백
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            DBUtil.close(pstmt, conn);
        }
    }
    
    public boolean deleteUserAndRelatedData(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // ✅ 트랜잭션 시작

            // 1. Q&A 댓글 삭제 (자신이 쓴 게시글에 달린 관리자 답변)
            String deleteReplies = "DELETE FROM board_reply WHERE post_id IN (SELECT post_id FROM board_post WHERE writer_id = ?)";
            pstmt = conn.prepareStatement(deleteReplies);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 2. 자신이 쓴 게시글 삭제
            String deletePosts = "DELETE FROM board_post WHERE writer_id = ?";
            pstmt = conn.prepareStatement(deletePosts);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 3. 시간표 삭제
            String deleteTimetable = "DELETE FROM timetable WHERE user_id = ?";
            pstmt = conn.prepareStatement(deleteTimetable);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 4. 스터디 멤버 삭제
            String deleteStudyMember = "DELETE FROM study_member WHERE user_id = ?";
            pstmt = conn.prepareStatement(deleteStudyMember);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 5. 자신이 쓴 댓글 삭제
            String deleteComments = "DELETE FROM board_comment WHERE writer_id = ?";
            pstmt = conn.prepareStatement(deleteComments);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
            pstmt.close();

            // 6. 사용자 삭제
            String deleteUser = "DELETE FROM user WHERE user_id = ?";
            pstmt = conn.prepareStatement(deleteUser);
            pstmt.setString(1, userId);
            int rows = pstmt.executeUpdate();
            pstmt.close();

            conn.commit(); // ✅ 트랜잭션 커밋
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // ❌ 예외 시 롤백
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            DBUtil.close(pstmt, conn);
        }
    }

}