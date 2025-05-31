package util;

import java.sql.*;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/StudyMate_WS_final?serverTimezone=Asia/Seoul";
    private static final String USER = "root";     
    private static final String PASSWORD = "Hyj040811!";   

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 8.x 드라이버
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // 커넥션 생성
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ResultSet, Statement, Connection 닫기
    public static void close(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (stmt != null) stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Statement, Connection 닫기
    public static void close(Statement stmt, Connection conn) {
        close(null, stmt, conn);
    }

    // ResultSet, PreparedStatement, Connection 닫기
    public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (pstmt != null) pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // PreparedStatement, Connection 닫기
    public static void close(PreparedStatement pstmt, Connection conn) {
        close(null, pstmt, conn);
    }
}
