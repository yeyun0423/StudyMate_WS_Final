--관리자 yoonji 와 일반 회원 yeyun 계정에만 정보를 넣어두었습니다.

-- 게시글 등록  
-- 자료실 글은 웹에서 파일을 직접 업로드해야 하므로 제외하였습니다.

-- 자유게시판
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'yoonji', '첫 번째 글입니다', '안녕하세요, 자유게시판 테스트 글입니다.', '2025-06-08 13:58:28', FALSE, 10);

-- QNA 게시판
-- is_private=TRUE로 비공개로 작성되어있으므로, 작성자(yeyun)와 관리자가 아니면 접근할 수 없습니다.
-- 일반 사용자(minji 등)는 접근이 제한됩니다.
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('QNA', 'yeyun', 'Q&A 질문 있습니다', '이 기능 구현 어떻게 하나요?', '2025-06-08 13:58:28', TRUE, 5);

-- 자유게시판 댓글
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(1, 'yeyun', '좋은 글 감사합니다!', '2025-06-08 13:58:28');

-- QNA 답변 
-- 관리자만 작성할 수 있습니다.
INSERT INTO board_reply (post_id, writer_id, content, created_at) VALUES 
(2, 'yoonji', '이렇게 구현해보세요!', '2025-06-08 13:58:28');
