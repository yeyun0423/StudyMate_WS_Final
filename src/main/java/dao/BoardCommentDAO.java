package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.BoardCommentDTO;
import util.DBUtil;

public class BoardCommentDAO {

    public List<BoardCommentDTO> getCommentsByPostId(int postId) {
        List<BoardCommentDTO> list = new ArrayList<>();
        String sql = """
            SELECT c.*, u.name AS writer_name
            FROM board_comment c
            JOIN user u ON c.writer_id = u.user_id
            WHERE c.post_id = ?
            ORDER BY c.created_at ASC
        """;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardCommentDTO dto = new BoardCommentDTO();
                dto.setCommentId(rs.getInt("comment_id"));
                dto.setPostId(postId);
                dto.setWriterId(rs.getString("writer_id"));
                dto.setWriterName(rs.getString("writer_name"));
                dto.setContent(rs.getString("content"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertComment(BoardCommentDTO dto) {
        String sql = "INSERT INTO board_comment (post_id, writer_id, content) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, dto.getPostId());
            pstmt.setString(2, dto.getWriterId());
            pstmt.setString(3, dto.getContent());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
} 