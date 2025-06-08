package dao;

import dto.BoardPostDTO;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardPostDAO {
	// 자유게시판 전체 글 개수 구하기
	public int getFreePostCount() {
	    String sql = "SELECT COUNT(*) FROM board_post WHERE board_type = 'FREE'";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {
	        if (rs.next()) return rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	// 자료실 전체 글 개수 구하기
	public int getResourcePostCount() {
	    String sql = "SELECT COUNT(*) FROM board_post WHERE board_type = 'RESOURCE'";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {
	        if (rs.next()) return rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	// 자유게시판 글 목록 (페이지 단위로 가져오기)
	public List<BoardPostDTO> getFreePostsByPage(int page, int postsPerPage) {
	    return getPostsByPageAndType("FREE", page, postsPerPage);
	}

	// 자료실 글 목록 (페이지 단위로 가져오기)
	public List<BoardPostDTO> getResourcePostsByPage(int page, int postsPerPage) {
	    return getPostsByPageAndType("RESOURCE", page, postsPerPage);
	}

	// 게시판 타입별로 글 목록 조회하는 공통 메서드
	private List<BoardPostDTO> getPostsByPageAndType(String boardType, int page, int postsPerPage) {
	    List<BoardPostDTO> posts = new ArrayList<>();
	    String sql = """
	        SELECT b.post_id, b.board_type, b.writer_id, b.title, b.content,
	               b.created_at, b.filename, b.views,
	               u.name AS writer_name,
	               (SELECT COUNT(*) FROM board_comment c WHERE c.post_id = b.post_id) AS comment_count
	        FROM board_post b
	        JOIN user u ON b.writer_id = u.user_id
	        WHERE b.board_type = ?
	        ORDER BY b.created_at DESC
	        LIMIT ?, ?
	    """;

	    int offset = (page - 1) * postsPerPage;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, boardType);
	        pstmt.setInt(2, offset);
	        pstmt.setInt(3, postsPerPage);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                BoardPostDTO post = new BoardPostDTO();
	                post.setPostId(rs.getInt("post_id"));
	                post.setBoardType(rs.getString("board_type"));
	                post.setWriterId(rs.getString("writer_id"));
	                post.setWriterName(rs.getString("writer_name"));
	                post.setTitle(rs.getString("title"));
	                post.setContent(rs.getString("content"));
	                post.setCreatedAt(rs.getTimestamp("created_at"));
	                post.setFilename(rs.getString("filename"));
	                post.setViews(rs.getInt("views"));
	                post.setCommentCount(rs.getInt("comment_count"));
	                posts.add(post);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return posts;
	}

	// 글 하나 상세보기 (ID 기준)
	public BoardPostDTO getPostById(int postId) {
	    String sql = """
	        SELECT b.*, u.name AS writer_name
	        FROM board_post b
	        JOIN user u ON b.writer_id = u.user_id
	        WHERE b.post_id = ?
	    """;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, postId);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                BoardPostDTO post = new BoardPostDTO();
	                post.setPostId(rs.getInt("post_id"));
	                post.setBoardType(rs.getString("board_type"));
	                post.setWriterId(rs.getString("writer_id"));
	                post.setWriterName(rs.getString("writer_name"));
	                post.setTitle(rs.getString("title"));
	                post.setContent(rs.getString("content"));
	                post.setCreatedAt(rs.getTimestamp("created_at"));
	                post.setFilename(rs.getString("filename"));
	                post.setViews(rs.getInt("views"));
	                return post;
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	// 글 수정 (파일까지 수정할 때)
	public void updatePost(int id, String title, String content, String filename) {
	    String sql = "UPDATE board_post SET title = ?, content = ?, filename = ? WHERE post_id = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, title);
	        pstmt.setString(2, content);
	        pstmt.setString(3, filename);
	        pstmt.setInt(4, id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// 글 수정 (파일 수정 없이 제목/내용만)
	public void updatePost(int id, String title, String content) {
	    String sql = "UPDATE board_post SET title = ?, content = ? WHERE post_id = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, title);
	        pstmt.setString(2, content);
	        pstmt.setInt(3, id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// 글 삭제하기
	public void deletePost(int id) {
	    String sql = "DELETE FROM board_post WHERE post_id = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// 특정 글이 로그인한 사용자가 쓴 글인지 확인
	public boolean isWriter(int id, String userId) {
	    String sql = "SELECT writer_id FROM board_post WHERE post_id = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, id);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return userId.equals(rs.getString("writer_id"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	// 새 글 등록
	public void insertPost(BoardPostDTO post) {
	    String sql = "INSERT INTO board_post (board_type, writer_id, title, content, filename) VALUES (?, ?, ?, ?, ?)";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        System.out.println("▶ insertPost 실행됨");
	        pstmt.setString(1, post.getBoardType());
	        pstmt.setString(2, post.getWriterId());
	        pstmt.setString(3, post.getTitle());
	        pstmt.setString(4, post.getContent());
	        pstmt.setString(5, post.getFilename());
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// 게시판 타입(FREE, RESOURCE 등)에 따라 전체 글 목록 가져오기
	public List<BoardPostDTO> getPostsByType(String boardType) {
	    List<BoardPostDTO> list = new ArrayList<>();
	    String sql = """
	        SELECT b.*, u.name AS writer_name
	        FROM board_post b
	        JOIN user u ON b.writer_id = u.user_id
	        WHERE b.board_type = ?
	        ORDER BY b.created_at DESC
	    """;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, boardType);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                BoardPostDTO post = new BoardPostDTO();
	                post.setPostId(rs.getInt("post_id"));
	                post.setTitle(rs.getString("title"));
	                post.setWriterId(rs.getString("writer_id"));
	                post.setWriterName(rs.getString("writer_name"));
	                post.setCreatedAt(rs.getTimestamp("created_at"));
	                post.setFilename(rs.getString("filename"));
	                list.add(post);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	// QnA 게시판 글 개수 구하기
	public int getQnACount() {
	    String sql = "SELECT COUNT(*) FROM board_post WHERE board_type = 'QNA'";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {
	        if (rs.next()) return rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	// QnA 게시판 글 목록 (페이징 처리)
	public List<BoardPostDTO> getQnAByPage(int page, int limit) {
	    List<BoardPostDTO> list = new ArrayList<>();
	    int offset = (page - 1) * limit;

	    String sql = """
	        SELECT b.*, u.name AS writer_name
	        FROM board_post b
	        JOIN user u ON b.writer_id = u.user_id
	        WHERE b.board_type = 'QNA'
	        ORDER BY b.created_at DESC
	        LIMIT ? OFFSET ?
	    """;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, limit);
	        pstmt.setInt(2, offset);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                BoardPostDTO dto = new BoardPostDTO();
	                dto.setPostId(rs.getInt("post_id"));
	                dto.setTitle(rs.getString("title"));
	                dto.setContent(rs.getString("content"));
	                dto.setWriterId(rs.getString("writer_id"));
	                dto.setWriterName(rs.getString("writer_name"));
	                dto.setCreatedAt(rs.getTimestamp("created_at"));
	                dto.setPrivate(rs.getBoolean("is_private"));
	                list.add(dto);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	// QnA 새 글 작성 (is_private까지 포함됨)
	public boolean insertQnAPost(BoardPostDTO post) {
	    String sql = """
	        INSERT INTO board_post (title, content, writer_id, board_type, is_private, created_at)
	        VALUES (?, ?, ?, ?, ?, NOW())
	    """;
	    int result = 0;
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, post.getTitle());
	        pstmt.setString(2, post.getContent());
	        pstmt.setString(3, post.getWriterId());
	        pstmt.setString(4, "QNA"); // QnA 글로 고정
	        pstmt.setBoolean(5, post.isPrivate());

	        result = pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result > 0;
	}

	// QnA 글 리스트 + 답변 상태 표시 (답변 완료/대기중)
	public List<BoardPostDTO> getQnaPostsWithStatus(int page, int limit) {
	    List<BoardPostDTO> list = new ArrayList<>();
	    String sql = "SELECT DISTINCT bp.post_id, bp.title, bp.writer_id, u.name AS writer_name, " +
	                 "bp.created_at, " +
	                 "CASE WHEN br.reply_id IS NOT NULL THEN '답변 완료' ELSE '대기중' END AS status " +
	                 "FROM board_post bp " +
	                 "JOIN user u ON bp.writer_id = u.user_id " +
	                 "LEFT JOIN board_reply br ON bp.post_id = br.post_id " +
	                 "WHERE bp.board_type = 'QNA' " +
	                 "ORDER BY bp.created_at DESC LIMIT ? OFFSET ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, limit);
	        pstmt.setInt(2, (page - 1) * limit);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardPostDTO dto = new BoardPostDTO();
	            dto.setPostId(rs.getInt("post_id"));
	            dto.setTitle(rs.getString("title"));
	            dto.setWriterName(rs.getString("writer_name"));
	            dto.setStatus(rs.getString("status"));
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	// QnA 글 개수 다시 한 번 가져오기 (상태랑 관계없이)
	public int getQnaPostCount() {
	    String sql = "SELECT COUNT(*) FROM board_post WHERE board_type = 'QNA'";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {
	        if (rs.next()) return rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	// QnA 글 검색 (제목 or 작성자 이름) + 답변 상태 포함해서 보여주기
	public List<BoardPostDTO> searchQnaPostsWithStatus(String search, int page, int limit) {
	    List<BoardPostDTO> list = new ArrayList<>();
	    String sql = """
	        SELECT DISTINCT p.post_id, p.title, p.writer_id, u.name AS writer_name,
	               p.created_at, p.is_private, p.board_type,
	               CASE WHEN r.reply_id IS NOT NULL THEN '답변 완료' ELSE '대기중' END AS status
	        FROM board_post p
	        JOIN user u ON p.writer_id = u.user_id
	        LEFT JOIN board_reply r ON p.post_id = r.post_id
	        WHERE p.board_type = 'QNA' AND (p.title LIKE ? OR u.name LIKE ?)
	        ORDER BY p.created_at DESC LIMIT ?, ?
	    """;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        String like = "%" + search + "%";
	        pstmt.setString(1, like);
	        pstmt.setString(2, like);
	        pstmt.setInt(3, (page - 1) * limit);
	        pstmt.setInt(4, limit);

	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardPostDTO post = new BoardPostDTO();
	            post.setPostId(rs.getInt("post_id"));
	            post.setWriterId(rs.getString("writer_id"));
	            post.setWriterName(rs.getString("writer_name"));
	            post.setTitle(rs.getString("title"));
	            post.setCreatedAt(rs.getTimestamp("created_at"));
	            post.setPrivate(rs.getBoolean("is_private"));
	            post.setBoardType(rs.getString("board_type"));
	            post.setStatus(rs.getString("status"));
	            list.add(post);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}



    
	// QnA 게시판에서 검색된 글 개수 구하기
	public int getSearchQnaPostCount(String search) {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM board_post p " +
	                 "JOIN user u ON p.writer_id = u.user_id " +
	                 "WHERE p.board_type = 'QNA' AND (p.title LIKE ? OR u.name LIKE ?)";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        String like = "%" + search + "%";
	        pstmt.setString(1, like);
	        pstmt.setString(2, like);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}

	// ResultSet → DTO로 바꿔주는 메서드 (중복 제거용)
	private BoardPostDTO mapResultSetToPost(ResultSet rs) throws SQLException {
	    BoardPostDTO post = new BoardPostDTO();
	    post.setPostId(rs.getInt("post_id"));
	    post.setWriterId(rs.getString("writer_id"));
	    post.setWriterName(rs.getString("writer_name"));
	    post.setTitle(rs.getString("title"));
	    post.setContent(rs.getString("content"));
	    post.setCreatedAt(rs.getTimestamp("created_at"));
	    post.setPrivate(rs.getBoolean("is_private"));
	    post.setBoardType(rs.getString("board_type"));
	    post.setStatus(rs.getString("status")); // status 컬럼 있을 때만
	    return post;
	}

	// 자유게시판에서 검색한 결과들 중 페이징해서 글 가져오기
	public List<BoardPostDTO> searchFreePostsByPage(String search, int page, int postsPerPage) {
	    List<BoardPostDTO> posts = new ArrayList<>();
	    String sql = """
	        SELECT b.*, u.name AS writer_name,
	               (SELECT COUNT(*) FROM board_comment c WHERE c.post_id = b.post_id) AS comment_count
	        FROM board_post b
	        JOIN user u ON b.writer_id = u.user_id
	        WHERE b.board_type = 'FREE' AND (b.title LIKE ? OR u.name LIKE ?)
	        ORDER BY b.created_at DESC
	        LIMIT ? OFFSET ?
	    """;

	    int offset = (page - 1) * postsPerPage;

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        String like = "%" + search + "%";
	        pstmt.setString(1, like);
	        pstmt.setString(2, like);
	        pstmt.setInt(3, postsPerPage);
	        pstmt.setInt(4, offset);

	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            BoardPostDTO post = new BoardPostDTO();
	            post.setPostId(rs.getInt("post_id"));
	            post.setBoardType(rs.getString("board_type"));
	            post.setWriterId(rs.getString("writer_id"));
	            post.setWriterName(rs.getString("writer_name"));
	            post.setTitle(rs.getString("title"));
	            post.setContent(rs.getString("content"));
	            post.setCreatedAt(rs.getTimestamp("created_at"));
	            post.setFilename(rs.getString("filename"));
	            post.setViews(rs.getInt("views"));
	            post.setCommentCount(rs.getInt("comment_count"));
	            posts.add(post);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return posts;
	}

	// 자유게시판에서 검색된 게시글 개수 구하기
	public int getSearchFreePostCount(String search) {
	    String sql = """
	        SELECT COUNT(*)
	        FROM board_post b
	        JOIN user u ON b.writer_id = u.user_id
	        WHERE b.board_type = 'FREE' AND (b.title LIKE ? OR u.name LIKE ?)
	    """;
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        String like = "%" + search + "%";
	        pstmt.setString(1, like);
	        pstmt.setString(2, like);

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	// 조회수 1 올려주는 메서드 (글 클릭하면 실행됨)
	public void increaseViews(int postId) {
	    String sql = "UPDATE board_post SET views = views + 1 WHERE post_id = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, postId);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}