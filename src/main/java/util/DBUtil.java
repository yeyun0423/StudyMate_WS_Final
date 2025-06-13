package util;

import java.sql.*;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/FinalDB?serverTimezone=Asia/Seoul";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";

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

    public static void close(ResultSet rs, Statement stmt, Connection conn) {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }

    public static void close(Statement stmt, Connection conn) {
        close(null, stmt, conn);
    }
}
