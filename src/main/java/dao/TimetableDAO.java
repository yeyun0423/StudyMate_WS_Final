package dao;

import dto.TimetableDTO;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TimetableDAO {

    // 시간표 한 줄 등록
    public boolean insertTimetable(TimetableDTO t) {
        String sql = "INSERT INTO timetable (user_id, day_of_week, period, subject) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, t.getUserId());
            pstmt.setString(2, t.getDayOfWeek());
            pstmt.setInt(3, t.getPeriod());
            pstmt.setString(4, t.getSubject());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 해당 사용자의 시간표 전체 가져오기
    public List<TimetableDTO> getTimetableByUser(String userId) {
        List<TimetableDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM timetable WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                TimetableDTO t = new TimetableDTO();
                t.setTimetableId(rs.getInt("timetable_id"));
                t.setUserId(rs.getString("user_id"));
                t.setDayOfWeek(rs.getString("day_of_week"));
                t.setPeriod(rs.getInt("period"));
                t.setSubject(rs.getString("subject"));
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
