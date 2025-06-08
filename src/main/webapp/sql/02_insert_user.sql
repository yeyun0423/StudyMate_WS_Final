--"웹에서 회원가입 시 관리자 코드(1234)를 입력하면 관리자 계정으로 가입할 수 있습니다."
--"웹에서 회원가입 시 관리자 코드를 입력하지 않으면 일반 회원 계정으로 가입할 수 있습니다."

--관리자인 yoonji 와 일반 회원인 yeyun으로 기능을 확인하시는 걸 추천합니다!!

-- user 테이블 insert
-- 모든 유저의 비밀번호는 1234
INSERT INTO user (user_id, name, password, birth_date, is_admin, profile_image)
VALUES 
('yeyun',       '최예윤',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2003-04-23', FALSE, 'Bokshil.jpg'),
('kimgildong',  '김길동',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2002-03-12', FALSE, 'MyMelody.jpg'),
('leegildong',  '이길동',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2005-08-14', FALSE, 'default.png'),
('parkgildong', '박길동',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2000-06-02', FALSE, 'default.png'),
('honggildong', '홍길동',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '1999-10-03', FALSE, 'default.png'),
('chulsu',      '김철수',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2004-12-08', FALSE, 'chulsu.jpg'),
('younghee',    '박영희',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2003-04-21', FALSE, 'Maong.jpg'),
('dahyun',      '임다현',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2004-04-23', FALSE, 'Bui.jpg'),
('minji',       '김민지',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2006-09-10', FALSE, 'minji.jpg'),
('choigildong', '최길동',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2003-05-05', FALSE, 'Naong.jpg'),
-- 관리자
('yoonji',      '홍윤지',    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2004-08-11', TRUE,  'ChalkakKitty.jpg');
