package dto;

import java.sql.Timestamp;

public class BoardCommentDTO {
    private int commentId;         // 댓글 ID
    private int postId;            // 연결된 게시글 ID
    private String writerId;       // 작성자 ID
    private String writerName;     // 작성자 이름 (JOIN으로 받아옴)
    private String content;        // 댓글 내용
    private Timestamp createdAt;   // 작성 시각

    // ▶ Getter & Setter

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getWriterId() {
        return writerId;
    }

    public void setWriterId(String writerId) {
        this.writerId = writerId;
    }

    public String getWriterName() {
        return writerName;
    }

    public void setWriterName(String writerName) {
        this.writerName = writerName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
