-- study_group 테이블 insert
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (1, '데이터베이스', 3, 'yoonji', '2025-05-31 17:05:51');
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (2, '네트워크프로그래밍', 4, 'dahyun', '2025-05-31 17:02:37');
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (3, '시스템프로그래밍', 3, 'yeyun', '2025-05-31 16:57:27');
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (4, '자바프로그래밍', 4, 'minji', '2025-05-31 17:04:58');
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (5, '자료구조및실습', 4, 'kimgildong', '2025-05-31 17:00:54');

-- match_log 테이블 insert
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (1, 'yoonji, dahyun, yeyun', 'RECRUITING', '2025-05-31 17:05:51');
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (2, 'dahyun, leegildong, minji, yoonji', 'RECRUITING', '2025-05-31 17:02:37');
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (3, 'yeyun, honggildong, leegildong', 'RECRUITING', '2025-05-31 16:57:27');
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (4, 'chulsu, parkgildong, yeyun', 'RECRUITING', '2025-05-31 17:04:58');
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (5, 'chulsu, minji, parkgildong', 'RECRUITING', '2025-05-31 17:00:54');

-- study_member 테이블 insert
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'yoonji', 'LEADER', '2025-05-31 17:05:51');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'dahyun', 'MEMBER', '2025-05-31 17:05:51');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'yeyun', 'MEMBER', '2025-05-31 17:05:51');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'dahyun', 'LEADER', '2025-05-31 17:02:37');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'leegildong', 'MEMBER', '2025-05-31 17:02:37');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'minji', 'MEMBER', '2025-05-31 17:02:37');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'yoonji', 'MEMBER', '2025-05-31 17:02:37');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (3, 'yeyun', 'LEADER', '2025-05-31 16:57:27');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (3, 'honggildong', 'MEMBER', '2025-05-31 16:57:27');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (3, 'leegildong', 'MEMBER', '2025-05-31 16:57:27');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (4, 'minji', 'LEADER', '2025-05-31 17:04:58');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (4, 'chulsu', 'MEMBER', '2025-05-31 17:04:58');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (4, 'parkgildong', 'MEMBER', '2025-05-31 17:04:58');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (4, 'yeyun', 'MEMBER', '2025-05-31 17:04:58');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (5, 'kimgildong', 'LEADER', '2025-05-31 17:00:54');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (5, 'chulsu', 'MEMBER', '2025-05-31 17:00:54');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (5, 'minji', 'MEMBER', '2025-05-31 17:00:54');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (5, 'parkgildong', 'MEMBER', '2025-05-31 17:00:54');