package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import util.DBUtil;

@WebServlet("/getRecommendedFriends")
public class FriendRecommendationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String subject = request.getParameter("subject");
        String currentUserId = (String) request.getSession().getAttribute("userId");

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        StringBuilder json = new StringBuilder();
        json.append("[");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT DISTINCT u.user_id, u.name FROM user u JOIN timetable t ON u.user_id = t.user_id WHERE t.subject = ? AND u.user_id != ?";

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, subject);
                pstmt.setString(2, currentUserId);

                try (ResultSet rs = pstmt.executeQuery()) {
                    boolean first = true;
                    while (rs.next()) {
                        if (!first) json.append(",");
                        json.append("{\"userId\":\"")
                            .append(rs.getString("user_id"))
                            .append("\",\"name\":\"")
                            .append(rs.getString("name"))
                            .append("\"}");
                        first = false;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        json.append("]");
        out.print(json.toString());
    }
}