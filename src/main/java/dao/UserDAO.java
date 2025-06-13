package dao;

import dto.UserDTO;
import util.DBUtil;
import util.PasswordHasher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	// 회원가입 - 새 사용자 등록
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

	// 아이디 중복 확인
	public boolean checkIdExists(String userId) {
	    String sql = "SELECT user_id FROM user WHERE user_id = ?";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, userId);
	        ResultSet rs = pstmt.executeQuery();

	        return rs.next(); // 있으면 true
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	// 로그인 처리 (비밀번호 암호화 비교)
	public boolean login(String userId, String password) {
	    String sql = "SELECT password FROM user WHERE user_id = ?";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, userId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String storedHash = rs.getString("password");
	            String inputHash = PasswordHasher.encrypt(password);
	            return storedHash.equals(inputHash);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	// 아이디로 사용자 정보 조회
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
	            user.setPassword(rs.getString("password"));
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

	// 사용자 정보 수정
	public boolean updateUser(UserDTO user) {
	    String sql = "UPDATE user SET name = ?, password = ?, birth_date = ?, profile_image = ? WHERE user_id = ?";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, user.getName());
	        pstmt.setString(2, user.getPassword());
	        pstmt.setDate(3, new java.sql.Date(user.getBirthDate().getTime()));
	        pstmt.setString(4, user.getProfileImage());
	        pstmt.setString(5, user.getUserId());

	        return pstmt.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	// 회원 탈퇴 (삭제)
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

	// 이름만 가져오기
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


    
	// 프로필 이미지 파일명 저장
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

	// 프로필 이미지 경로 가져오기
	public String getProfileImageById(String userId) {
	    String sql = "SELECT profile_image FROM user WHERE user_id = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, userId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getString("profile_image");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	// 관리자 계정인지 확인
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

	// 전체 회원 수 가져오기
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

	// 특정 페이지의 회원 목록 조회 (가입일 기준 최신순)
	public List<UserDTO> getUsersByPage(int page, int limit) {
	    List<UserDTO> list = new ArrayList<>();
	    String sql = "SELECT * FROM user ORDER BY join_date DESC LIMIT ? OFFSET ?";
	    int offset = (page - 1) * limit;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, limit);
	        pstmt.setInt(2, offset);

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

	// 검색어로 회원 목록 조회 (페이징 포함)
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

	// 검색 결과 총 개수 반환
	public int getSearchUserCount(String keyword) {
	    String sql = "SELECT COUNT(*) FROM user WHERE user_id LIKE ? OR name LIKE ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, "%" + keyword + "%");
	        pstmt.setString(2, "%" + keyword + "%");

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) return rs.getInt(1);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}


	// 사용자와 관련된 모든 데이터 삭제 (관리자용)
	public void deleteAllUserData(String userId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = DBUtil.getConnection();
	        conn.setAutoCommit(false); // 트랜잭션 시작

	        // 게시글에 달린 Q&A 답변 삭제
	        String deleteReplies = "DELETE FROM board_reply WHERE post_id IN (SELECT post_id FROM board_post WHERE writer_id = ?)";
	        pstmt = conn.prepareStatement(deleteReplies);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 게시글 삭제
	        String deletePosts = "DELETE FROM board_post WHERE writer_id = ?";
	        pstmt = conn.prepareStatement(deletePosts);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 시간표 삭제
	        String deleteTimetable = "DELETE FROM timetable WHERE user_id = ?";
	        pstmt = conn.prepareStatement(deleteTimetable);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 댓글 삭제
	        String deleteComments = "DELETE FROM board_comment WHERE writer_id = ?";
	        pstmt = conn.prepareStatement(deleteComments);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 가입했던 스터디 멤버 삭제
	        String deleteOwnStudyMember = "DELETE FROM study_member WHERE user_id = ?";
	        pstmt = conn.prepareStatement(deleteOwnStudyMember);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 본인이 만든 그룹에 있던 멤버들 삭제
	        String deleteMembersInOwnedGroups = """
	            DELETE FROM study_member 
	            WHERE group_id IN (
	                SELECT group_id FROM study_group WHERE created_by = ?
	            )
	        """;
	        pstmt = conn.prepareStatement(deleteMembersInOwnedGroups);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 본인이 만든 그룹 관련 매칭 기록 삭제
	        String deleteMatchLog = """
	            DELETE FROM match_log 
	            WHERE group_id IN (
	                SELECT group_id FROM study_group WHERE created_by = ?
	            )
	        """;
	        pstmt = conn.prepareStatement(deleteMatchLog);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 본인이 만든 스터디 그룹 삭제
	        String deleteStudyGroup = "DELETE FROM study_group WHERE created_by = ?";
	        pstmt = conn.prepareStatement(deleteStudyGroup);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 마지막으로 사용자 계정 삭제
	        String deleteUser = "DELETE FROM user WHERE user_id = ?";
	        pstmt = conn.prepareStatement(deleteUser);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        conn.commit(); // 완료되면 커밋

	    } catch (Exception e) {
	        e.printStackTrace();
	        try {
	            if (conn != null) conn.rollback(); // 실패 시 롤백
	        } catch (Exception rollbackEx) {
	            rollbackEx.printStackTrace();
	        }
	    } finally {
	        DBUtil.close(pstmt, conn); // 마무리 정리
	    }
	}

	// 위 함수랑 거의 같지만, 성공 여부를 boolean으로 반환하는 버전
	public boolean deleteUserAndRelatedData(String userId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = DBUtil.getConnection();
	        conn.setAutoCommit(false);

	        String deleteReplies = "DELETE FROM board_reply WHERE post_id IN (SELECT post_id FROM board_post WHERE writer_id = ?)";
	        pstmt = conn.prepareStatement(deleteReplies);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deletePosts = "DELETE FROM board_post WHERE writer_id = ?";
	        pstmt = conn.prepareStatement(deletePosts);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteTimetable = "DELETE FROM timetable WHERE user_id = ?";
	        pstmt = conn.prepareStatement(deleteTimetable);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteComments = "DELETE FROM board_comment WHERE writer_id = ?";
	        pstmt = conn.prepareStatement(deleteComments);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteOwnStudyMember = "DELETE FROM study_member WHERE user_id = ?";
	        pstmt = conn.prepareStatement(deleteOwnStudyMember);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteMembersInOwnedGroups = """
	            DELETE FROM study_member 
	            WHERE group_id IN (
	                SELECT group_id FROM study_group WHERE created_by = ?
	            )
	        """;
	        pstmt = conn.prepareStatement(deleteMembersInOwnedGroups);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteMatchLog = """
	            DELETE FROM match_log 
	            WHERE group_id IN (
	                SELECT group_id FROM study_group WHERE created_by = ?
	            )
	        """;
	        pstmt = conn.prepareStatement(deleteMatchLog);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteStudyGroup = "DELETE FROM study_group WHERE created_by = ?";
	        pstmt = conn.prepareStatement(deleteStudyGroup);
	        pstmt.setString(1, userId);
	        pstmt.executeUpdate();
	        pstmt.close();

	        String deleteUser = "DELETE FROM user WHERE user_id = ?";
	        pstmt = conn.prepareStatement(deleteUser);
	        pstmt.setString(1, userId);
	        int rows = pstmt.executeUpdate();
	        pstmt.close();

	        conn.commit(); // 커밋까지 완료되면 성공
	        return rows > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        try {
	            if (conn != null) conn.rollback();
	        } catch (Exception rollbackEx) {
	            rollbackEx.printStackTrace();
	        }
	        return false;
	    } finally {
	        DBUtil.close(pstmt, conn);
	    }
	}
}