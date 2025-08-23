# 📚 StudyMate_WS_Final

> JSP & MySQL 기반 스터디 매칭 플랫폼 · Tomcat 10+

## 🎥 시연영상
👉 [시연 영상 보러가기](https://drive.google.com/file/d/1ImAXeBCcJOMwhJyBh471KpPjKdo5kg3J/view?usp=sharing)

## 📊 ERD
👉 [ERD](doc/erd.png)

## ✨ 프로젝트 소개
**StudyMate_WS_Final**은 대학생들의 과목별 스터디 그룹 생성/참여를 돕는 웹 애플리케이션입니다.  
시간표 기반 친구 추천, 랜덤 스터디 생성, 게시판(Q&A/자유/자료실)과 프로필 관리 등을 제공합니다.  

아키텍처는 **MVC (Controller – DAO – DTO – JSP)** 로 구성되어 있습니다.

## 🛠 기술 스택
- **Frontend:** JSP, JSTL, Bootstrap, JavaScript  
- **Backend:** Java Servlet, Filter, Apache FileUpload  
- **DB:** MySQL (`FinalDB`), JDBC  
- **Server:** Apache Tomcat 10+  
- **IDE:** Eclipse  

## ✨ 주요 기능
- 회원가입, 로그인, 프로필 이미지 업로드  
- 스터디 그룹 생성/참여, 랜덤 매칭, 친구 추천  
- 자유/자료/QnA 게시판 + 댓글/답변  
- 시간표 관리 기반 추천  
- 관리자 페이지(회원/매칭/QnA 관리)

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

## 📑 주요 기능 요약

* **회원 관리**

  * 회원가입/로그인/로그아웃, 아이디 중복체크(`/check-id`)
  * 프로필 수정, **프로필 이미지 업로드/삭제** (`/profileUpload`, `/deleteImage`)
  * 계정 삭제(`/deleteAccount`)
    
> 🔎 참고: `LoginServlet`은 세션(`userId`, `isAdmin`, `user_name`)과 `lang` 쿠키를 설정하고 `home.jsp`로 리다이렉트합니다.
> `RegisterServlet`은 `adminCode` 입력이 **`1234`** 인 경우 관리자 가입 처리.
> 비밀번호는 SHA‑256(무솔트)로 해시되어 저장됩니다(`util/PasswordHasher`)

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


## ⚙️ 로컬 실행 가이드

### 1) 환경 준비

* JDK 17+ 권장
* **Tomcat 10+** (Jakarta 네임스페이스)
* MySQL 8.x (`FinalDB`)

### 2) DB 준비

### 3) DB 접속 설정

`util/DBUtil.java` 에서 접속 정보 변경(권장: 환경변수 사용).

## 📦 의존 라이브러리

* **Jakarta Servlet API** (Tomcat 10+)
* **Apache Commons FileUpload** (프로필/첨부 업로드)

