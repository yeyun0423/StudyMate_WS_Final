# 📚 StudyMate\_WS\_Final

> JSP & MySQL 기반 스터디 매칭 플랫폼 · Jakarta EE 10 (web.xml 5.0) · Tomcat 10+

## ✨ 프로젝트 소개

**StudyMate\_WS\_Final**은 대학생들의 과목별 스터디 그룹 생성/참여를 돕는 웹 애플리케이션입니다.
시간표 기반 친구 추천, 랜덤 스터디 생성, 게시판(Q\&A/자유/자료실)과 프로필 관리 등을 제공합니다.
아키텍처는 **Controller(Servlet) – DAO – DTO – JSP(JSTL)** 의 MVC 구조입니다.

## 🧱 기술 스택

* **Frontend:** JSP, JSTL, Bootstrap 5, JavaScript
* **Backend:** Java Servlet (Jakarta), Filters (인증/인가/인코딩), FileUpload (Apache Commons FileUpload)
* **DB:** MySQL (`FinalDB`), JDBC
* **Server:** Apache Tomcat 10+ (Jakarta 네임스페이스)
* **IDE:** Eclipse (Dynamic Web Project)

## 📂 디렉터리 구조

```
src/main/java
├─ controller/              # 서블릿 컨트롤러 (총 21개)
├─ dao/                     # DAO (6개)
├─ dto/                     # DTO (6개)
├─ filter/                  # 필터 (3개)
└─ util/                    # DBUtil, PasswordHasher

src/main/webapp
├─ resources/
│  ├─ css/ (Bootstrap)      # bootstrap.min.css
│  ├─ js/                   # home.js, lang-toggle.js, register.js ...
│  └─ images/               # 프로필/샘플 이미지들(Bokshil.jpg 등)
├─ sql/                     # 초기화 스크립트 (01~05)
├─ WEB-INF/
│  ├─ web.xml               # 서블릿·필터 매핑, 에러 페이지
│  ├─ upload/               # 업로드 저장 경로
│  └─ classes/bundle        # i18n 메시지(messages_ko/en.properties)
└─ *.jsp                    # 로그인, 홈, 게시판, 프로필, 시간표 등 (총 34개)
```

## 🔐 필터 (Filters)

* `EncodingFilter` → 모든 요청 UTF-8 적용 (`/*`)
* `LoginCheckFilter` → 로그인 필수 경로 보호 (`/*`)

  * 예외: 정적 리소스(`.css/.js/.png...`), `login.jsp`, `register.jsp`, `/login`, `/register`
  * 세션 키: `userId`
* `AdminAccessFilter` → `/admin/*` 접근 로깅 + 보호

## 🌍 다국어(i18n) & 언어 토글

* 번들: `WEB-INF/classes/bundle/messages_ko.properties`, `messages_en.properties`
* 토글: `resources/js/lang-toggle.js` → `ChangeLangServlet` 로 POST
* 쿠키: `lang=ko|en`(30일), 네비바에서 토글 (쿠키 기반 렌더)

```html
<!-- 예시: navbar.jsp 일부 -->
<form action="changeLang" method="post">
  <input type="hidden" id="lang_code" name="lang_code" value="ko" />
  <input type="checkbox" onchange="toggleLang(this)" />
</form>
<script src="resources/js/lang-toggle.js"></script>
```

## 🧭 서블릿 & URL 매핑 (요약)

| Servlet                       | Class                                    | URL Patterns               |
| ----------------------------- | ---------------------------------------- | -------------------------- |
| `ChangeLangServlet`           | `controller.ChangeLangServlet`           | `/changeLang`              |
| `CheckIdServlet`              | `controller.CheckIdServlet`              | `/check-id`                |
| `DeleteAccountServlet`        | `controller.DeleteAccountServlet`        | `/deleteAccount`           |
| `DownloadServlet`             | `controller.DownloadServlet`             | `/DownloadServlet`         |
| `FreeboardCommentServlet`     | `controller.FreeboardCommentServlet`     | `/FreeboardCommentServlet` |
| `FriendRecommendationServlet` | `controller.FriendRecommendationServlet` | `/getRecommendedFriends`   |
| `jsp`                         | `org.apache.jasper.servlet.JspServlet`   | `*.jsp`                    |
| `LoginServlet`                | `controller.LoginServlet`                | `/login`                   |
| `LogoutServlet`               | `controller.LogoutServlet`               | `/logout`                  |
| `ProfileImageDeleteServlet`   | `controller.ProfileImageDeleteServlet`   | `/deleteImage`             |
| `ProfileImageUploadServlet`   | `controller.ProfileImageUploadServlet`   | `/profileUpload`           |
| `ProfileUpdateServlet`        | `controller.ProfileUpdateServlet`        | `/updateProfile`           |
| `QnABoardWriteServlet`        | `controller.QnABoardWriteServlet`        | `/QnABoardWriteServlet`    |
| `RandomStudyServlet`          | `controller.RandomStudyServlet`          | `/RandomStudyServlet`      |
| `RegisterServlet`             | `controller.RegisterServlet`             | `/register`                |
| `ReplyDeleteServlet`          | `controller.ReplyDeleteServlet`          | `/ReplyDeleteServlet`      |
| `ReplyInsertServlet`          | `controller.ReplyInsertServlet`          | `/ReplyInsertServlet`      |
| `ReplyUpdateServlet`          | `controller.ReplyUpdateServlet`          | `/ReplyUpdateServlet`      |
| `StudyDeleteServlet`          | `controller.StudyDeleteServlet`          | `/StudyDeleteServlet`      |
| `StudyExitServlet`            | `controller.StudyExitServlet`            | `/StudyExitServlet`        |
| `StudyGroupServlet`           | `controller.StudyGroupServlet`           | `/StudyGroupServlet`       |
| `TimetableServlet`            | `controller.TimetableServlet`            | `/timetable`               |

> 🔎 참고: `LoginServlet`은 세션(`userId`, `isAdmin`, `user_name`)과 `lang` 쿠키를 설정하고 `home.jsp`로 리다이렉트합니다.
> `RegisterServlet`은 `adminCode` 입력이 **`1234`** 인 경우 관리자 가입 처리.

## 📑 주요 기능 요약

* **회원 관리**

  * 회원가입/로그인/로그아웃, 아이디 중복체크(`/check-id`)
  * 프로필 수정, **프로필 이미지 업로드/삭제** (`/profileUpload`, `/deleteImage`)
  * 계정 삭제(`/deleteAccount`)
* **스터디 그룹**

  * 스터디 목록/생성/탈퇴/삭제 (`StudyGroupServlet`, `StudyExitServlet`, `StudyDeleteServlet`)
  * **랜덤 스터디 생성**(`/RandomStudyServlet`) – 과목/인원/리더 기반 생성
  * **친구 추천**(`/getRecommendedFriends`) – 과목·참여여부 기반 JSON 응답
* **시간표**

  * 시간표 등록·조회(`/timetable`), 매칭 로직 참고
* **게시판**

  * 자유/자료/QnA 글 목록·상세·작성·수정·삭제 (`BoardPostDAO`)
  * **댓글**(`/FreeboardCommentServlet`) + **QnA 답변**(`/Reply*Servlet`)
  * 첨부파일 **다운로드**(`/DownloadServlet`)
* **예외 페이지**

  * `exceptionNoLogin.jsp`, `exceptionNoAdmin.jsp`, `exceptionNoPage.jsp`, `exceptionServerError.jsp`

## 🗄️ 데이터베이스

초기화 스크립트는 `src/main/webapp/sql` 에 있습니다.

* `01_create_tables.sql` – 테이블 생성
* `02_insert_user.sql` – 테스트 유저 (모든 비밀번호: `1234`)
* `03_insert_timetable.sql` – 시간표 더미
* `04_insert_study_group.sql` – 스터디/멤버/로그 더미
* `05_insert_board_data.sql` – 게시판/댓글/답변 더미

### 테스트 계정 (권장)

* **관리자**: `yoonji` / `1234`
* **일반회원**: `yeyun` / `1234`

> 비밀번호는 SHA‑256(무솔트)로 해시되어 저장됩니다(`util/PasswordHasher`). 운영 환경에서는 **BCrypt + Salt** 사용을 권장합니다.

## ⚙️ 로컬 실행 가이드

### 1) 환경 준비

* JDK 17+ 권장
* **Tomcat 10+** (Jakarta 네임스페이스)
* MySQL 8.x (`FinalDB`)

### 2) DB 준비

```sql
CREATE DATABASE FinalDB DEFAULT CHARACTER SET utf8mb4;
USE FinalDB;
-- 아래 스크립트를 순서대로 실행
SOURCE 01_create_tables.sql;
SOURCE 02_insert_user.sql;
SOURCE 03_insert_timetable.sql;
SOURCE 04_insert_study_group.sql;
SOURCE 05_insert_board_data.sql;
```

### 3) DB 접속 설정

`util/DBUtil.java` 에서 접속 정보 변경(권장: 환경변수 사용).

```java
// 예시 (camelCase 변수 사용)
String dbUrl = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/FinalDB?serverTimezone=Asia/Seoul");
String dbUser = System.getenv().getOrDefault("DB_USER", "root");
String dbPassword = System.getenv().getOrDefault("DB_PASSWORD", "");
Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
```

### 4) 업로드 경로 권한

* 프로필/첨부 저장 경로: `WEB-INF/upload/`
* 서버 실행 계정에 **쓰기 권한**이 필요합니다.

### 5) 실행

* Eclipse → Tomcat 설정 → `StudyMate_WS_Final` 배포
* 브라우저 → `http://localhost:8080/StudyMate_WS_Final/login.jsp`

## 🧪 스모크 테스트 절차

1. **회원가입** → `adminCode=1234` 입력 시 관리자 가입 확인
2. **로그인** → 세션(`userId`)과 쿠키(`lang`) 생성 확인
3. **홈(home.jsp)** → 과목 선택 → 친구 추천/인원 증가 버튼
4. **랜덤 스터디 생성** → 결과 메시지 토스트
5. **게시판** → 글 작성/수정/삭제, 댓글, Q\&A 답변
6. **프로필** → 이미지 업로드/삭제 → 변경 반영
7. **언어 토글** → `ko/en` 변경 및 페이지 갱신
8. **파일 다운로드** → 업로드 파일 다운로드 정상 동작
9. **권한** → `/admin/*` 접근 시 관리자 필터 동작 확인

## 🔒 보안/운영 권장 사항

* DB 비밀번호, 관리자 코드 등 **하드코딩 금지** → 환경변수/서버 비밀키 사용
* 비밀번호 해시: **BCrypt + Salt** 로 교체
* 파일 업로드: 확장자/용량 검증, 저장 파일명 난수화
* XSS/CSRF: 입력 값 이스케이프, CSRF 토큰 적용
* 로그: `AdminAccessFilter` 로그 파일 경로를 외부화하고 롤링 설정

## 📦 의존 라이브러리

* **Jakarta Servlet API** (Tomcat 10+)
* **Apache Commons FileUpload** (프로필/첨부 업로드)


## 🧭 네비게이션(주요 JSP)

* `login.jsp`, `register.jsp`, `home.jsp`, `mystudygroup.jsp`, `profile.jsp`
* 게시판: `freeboard*.jsp`, `qnaboard.jsp`, `qnaview.jsp`, `qnawrite.jsp`
* 예외: `exceptionNoLogin.jsp`, `exceptionNoAdmin.jsp`, `exceptionNoPage.jsp`, `exceptionServerError.jsp`
