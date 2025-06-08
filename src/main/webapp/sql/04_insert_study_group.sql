-- study_group 테이블 insert
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (1, '데이터베이스', 6, 'yoonji', '2025-06-08 13:58:28');
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (2, '네트워크프로그래밍', 4, 'dahyun', '2025-06-08 13:58:28');
INSERT INTO study_group (group_id, subject, max_members, created_by, created_at) VALUES (3, '시스템프로그래밍', 4, 'yeyun', '2025-06-03 13:08:28');

-- match_log 테이블 insert
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (1, 'yoonji, dahyun, yeyun, honggildong, chulsu, parkgildong', 'RECRUITING', '2025-06-08 13:58:28');
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (2, 'dahyun, leegildong, minji, yoonji', 'RECRUITING', '2025-06-08 13:58:28');
INSERT INTO match_log (group_id, matched_users, status, created_at) VALUES (3, 'yeyun, honggildong, leegildong', 'RECRUITING', '2025-06-03 13:08:28');

-- study_member 테이블 insert
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'yoonji', 'LEADER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'dahyun', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'yeyun', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'honggildong', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'chulsu', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (1, 'parkgildong', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'dahyun', 'LEADER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'leegildong', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'minji', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (2, 'yoonji', 'MEMBER', '2025-06-08 13:58:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (3, 'yeyun', 'LEADER', '2025-06-03 13:08:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (3, 'honggildong', 'MEMBER', '2025-06-03 13:08:28');
INSERT INTO study_member (group_id, user_id, role, joined_at) VALUES (3, 'leegildong', 'MEMBER', '2025-06-03 13:08:28');