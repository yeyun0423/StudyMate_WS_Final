<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>DB 연결 테스트</title></head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/StudyMate_WS_final?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = "Yeyun0423";  

    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        out.println("<h3>✅ MySQL 연결 성공!</h3>");
    } catch (Exception e) {
        out.println("<h3>❌ 연결 실패:</h3>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    } finally {
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
