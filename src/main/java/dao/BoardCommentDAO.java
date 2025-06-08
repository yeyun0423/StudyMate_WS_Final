package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.BoardCommentDTO;
import util.DBUtil;

public class BoardCommentDAO {

    // 게시글 하나에 달린 모든 댓글 가져오는 메서드
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
                dto.setCommentId(rs.getInt("comment_id"));  // 댓글 번호
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

    // 댓글 새로 등록할 때 사용하는 메서드
    public boolean insertComment(BoardCommentDTO dto) {
        String sql = "INSERT INTO board_comment (post_id, writer_id, content) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getPostId());      // 어떤 게시글에
            pstmt.setString(2, dto.getWriterId()); // 누가 썼는지
            pstmt.setString(3, dto.getContent());  // 어떤 내용인지
            return pstmt.executeUpdate() > 0;      // 1개 이상 insert 되면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
