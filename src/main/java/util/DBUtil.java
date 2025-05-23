package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

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

    // Statement, Connection 닫기 (ResultSet 없는 경우)
    public static void close(Statement stmt, Connection conn) {
        close(null, stmt, conn);
    }
}
