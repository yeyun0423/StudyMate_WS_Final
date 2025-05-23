package dao;

import dto.UserDTO;
import util.DBUtil;
import util.SHA256Util;

import java.sql.*;

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
    
    

}
