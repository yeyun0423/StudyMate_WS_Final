--관리자 yoonji 와 일반 회원 yeyun 계정에만 정보를 넣어두었습니다.

-- 게시글 등록  
-- 자료실 글은 웹에서 파일을 직접 업로드해야 하므로 제외하였습니다.

-- 자유게시판
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'yeyun', '종강 시켜주세요', '제발 종강 시켜주세요', '2025-05-31 13:58:28', FALSE, 5);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'kimgildong', '공부는 왜 해야 할까요', '공부하기 진짜 싫다 진짜 왜 해야 할까요..', '2025-05-31 17:23:31', FALSE, 4);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'honggildong', '스터디 같이 할 사람', '저랑 웹서버 스터디 같이 하실 분 댓글 달아주세용', '2025-06-02 16:30:10', FALSE, 6);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'chulsu', '스터디 탈퇴 하는 법 아는 사람', '스터디 탈퇴 하고 싶은데 아는 사람 있으면 알려주세요 ㅜㅜ', '2025-06-04 19:12:03', FALSE, 11);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'parkgildong', '다들 종강 언제', '다들 종강 언제 함?', '2025-05-27 08:02:01', FALSE, 5);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('FREE', 'younghee', '자료 공유', '웹서버 자료 공유 해주실 분 있나용 ㅜ', '2025-06-05 12:59:23', FALSE, 30);


-- QNA 게시판
-- is_private=TRUE로 비공개로 작성되어있으므로, 작성자와 관리자가 아니면 접근할 수 없습니다.
-- 일반 사용자는 접근이 제한됩니다.
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('QNA', 'parkgildong', '스터디 재가입', '탈퇴한 스터디에 다시 들어갈 순 없나요?', '2025-05-31 13:58:28', TRUE, 0);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('QNA', 'younghee', '스터디 생성 질문', '스터디를 추천 친구랑만 생성할 수 있는 건가요', '2025-05-31 15:03:12', TRUE, 0);
INSERT INTO board_post (board_type, writer_id, title, content, created_at, is_private, views) VALUES 
('QNA', 'choigildong', '회원 탈퇴', '탈퇴하고 싶은데 탈퇴 하는 방법 알려주세요.', '2025-06-04 09:08:11', FALSE, 0);


-- 자유게시판 댓글
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(2, 'minji', '그러게요...', '2025-05-31 17:40:56');
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(2, 'leegildong', '하기 싫다 진짜', '2025-05-31 17:44:31');
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(6, 'chulsu', '어떤 자료요?', '2025-05-31 17:46:28');
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(6, 'younghee', '2장이요 ㅜㅜ', '2025-05-31 17:47:01');
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(6, 'chulsu', '자료실에 올려뒀습니당', '2025-05-31 17:47:42');
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(4, 'leegildong', '나의 스터디 그룹 가면 탈퇴 버튼 있어용', '2025-05-31 17:44:20');
INSERT INTO board_comment (post_id, writer_id, content, created_at) VALUES 
(4, 'parkgildong', '나의 스터디 그룹에 있어요~', '2025-05-31 17:45:12');

-- QNA 답변 
-- 관리자만 작성할 수 있습니다.
INSERT INTO board_reply (post_id, writer_id, content, created_at) VALUES 
(8, 'yoonji', '랜덤 생성 버튼을 누르면 과목과 인원 수만 선택하면 랜덤으로 생성 가능합니다.', '2025-06-01 11:04:01');
INSERT INTO board_reply (post_id, writer_id, content, created_at) VALUES 
(9, 'yoonji', '프로필 수정 페이지에서 회원 탈퇴 버튼을 누르면 탈퇴할 수 있습니다!', '2025-06-04 10:57:58');

