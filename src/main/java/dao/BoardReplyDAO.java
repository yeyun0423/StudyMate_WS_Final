package dao;

import dto.BoardPostDTO;
import dto.BoardReplyDTO;
import util.DBUtil;
import java.sql.*;
import java.util.*;

public class BoardReplyDAO {

    // 댓글 등록
    public void insertReply(BoardReplyDTO reply) {
        String sql = "INSERT INTO board_reply(post_id, writer_id, content, created_at) VALUES (?, ?, ?, NOW())";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reply.getPostId());
            pstmt.setString(2, reply.getWriterId());
            pstmt.setString(3, reply.getContent());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 게시글 번호로 해당 글의 모든 댓글 불러오기 (작성 순서대로)
    public List<BoardReplyDTO> getRepliesByPostId(int postId) {
        List<BoardReplyDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM board_reply WHERE post_id = ? ORDER BY created_at ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    BoardReplyDTO reply = new BoardReplyDTO();
                    reply.setReplyId(rs.getInt("reply_id"));
                    reply.setPostId(rs.getInt("post_id"));
                    reply.setWriterId(rs.getString("writer_id"));
                    reply.setContent(rs.getString("content"));
                    reply.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(reply);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Q&A 게시글 목록 가져오면서 답변 여부 상태도 같이 조회
    public List<BoardPostDTO> getQnaPostsWithStatus() {
        List<BoardPostDTO> list = new ArrayList<>();
        String sql = """
            SELECT 
                p.post_id,
                p.writer_id,
                p.title,
                p.created_at,
                CASE 
                    WHEN COUNT(r.reply_id) > 0 THEN '답변 완료'
                    ELSE '대기중'
                END AS status
            FROM board_post p
            LEFT JOIN board_reply r ON p.post_id = r.post_id
            WHERE p.board_type = 'Q&A'
            GROUP BY p.post_id
            ORDER BY p.created_at DESC
        """;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                BoardPostDTO post = new BoardPostDTO();
                post.setPostId(rs.getInt("post_id"));
                post.setWriterId(rs.getString("writer_id"));
                post.setTitle(rs.getString("title"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setStatus(rs.getString("status"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 댓글 하나만 삭제
    public void deleteReplyById(int replyId) {
        String sql = "DELETE FROM board_reply WHERE reply_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, replyId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 게시글 하나에 달린 모든 댓글 삭제
    public boolean deleteRepliesByPostId(int postId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM board_reply WHERE post_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(pstmt, conn);
        }
        return false;
    }

    // 댓글 내용 수정
    public boolean updateReply(BoardReplyDTO reply) {
        String sql = "UPDATE board_reply SET content = ? WHERE reply_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, reply.getContent());
            pstmt.setInt(2, reply.getReplyId());
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
