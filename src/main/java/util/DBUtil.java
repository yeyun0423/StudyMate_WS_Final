package util;

import java.sql.*;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/StudyMate_WS_final?serverTimezone=Asia/Seoul";
    private static final String USER = "root";
    private static final String PASSWORD = "Yeyun0423";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // DB 연결 반환
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.err.println("DB 연결 실패: " + e.getMessage());
            return null;
        }
    }

    // 1. 모든 리소스 닫는 메서드 - ResultSet, Statement, Connection 모두
    public static void close(ResultSet rs, Statement stmt, Connection conn) {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }

    // 2. ResultSet 뺴고 리소스 닫는 메서드 - Statement, Connection만
    public static void close(Statement stmt, Connection conn) {
        close(null, stmt, conn);
    }
}
