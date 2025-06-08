package dto;

import java.sql.Timestamp;

public class BoardPostDTO {
    private int postId;            
    private String boardType;    
    private String writerId;       
    private String writerName;   
    private String title;         
    private String content;      
    private String filename;      
    private Timestamp createdAt;   
    private boolean isPrivate;
    private String status; // Q&A 답변 상태 
    private int views;
    private int commentCount;
   
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
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

 }
