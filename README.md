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
- **Backend:** Java Servlet, Filter  
- **DB:** MySQL (`FinalDB`), JDBC  
- **Server:** Apache Tomcat 10+  
- **IDE:** Eclipse  

## ✨ 주요 기능
- 회원가입, 로그인, 프로필 관리  
- 스터디 그룹 생성/참여, 랜덤 매칭, 친구 추천  
- 자유/자료/QnA 게시판 + 댓글/답변  
- 시간표 관리 기반 추천  
- 관리자 페이지(회원/매칭/QnA 관리)  
- 다국어(i18n) 지원 (한/영 언어 토글)  

## 🔐 필터 (Filters)
- UTF-8 인코딩 필터  
- 로그인 검증 필터 (세션 기반)  
- 관리자 접근 필터  

## ⚙️ 로컬 실행 가이드

### 1) 환경 준비
- JDK 17+ 권장  
- **Tomcat 10+** (Jakarta 네임스페이스)  
- MySQL 8.x (`FinalDB`)  

### 2) DB 접속 설정
- `util/DBUtil.java` 에서 접속 정보 변경 (권장: 환경변수 사용)

## 📦 의존 라이브러리
- **Jakarta Servlet API** (Tomcat 10+)  
- **Apache Commons FileUpload** (파일 업로드)
- 
