package dto;

import java.sql.Timestamp;

public class BoardPostDTO {
    private int postId;            // 글 번호 (PK)
    private String boardType;      // 게시판 타입: FREE, RESOURCE 등
    private String writerId;       // 작성자 ID
    private String writerName;     // 작성자 이름 (join 결과)
    private String title;          // 글 제목
    private String content;        // 글 내용
    private String filename;       // 첨부파일 이름
    private Timestamp createdAt;   // 작성일시
    private boolean isPrivate;
    private String status; // Q&A 답변 상태 
    
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getBoardType() {
        return boardType;
    }

    public void setBoardType(String boardType) {
        this.boardType = boardType;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    public boolean isPrivate() {
    	return isPrivate;
    }
    public void setPrivate(boolean isPrivate) {
    	this.isPrivate = isPrivate;
    }
    public String getStatus() {
    	return status;
    }
	public void setStatus(String status) {
		this.status = status;
	}
}
