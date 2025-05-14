<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <title>랜덤 스터디 모달</title>
</head>
<body>
<div class="my-3 p-3 bg-body rounded shadow-sm">
  <h6 class="border-bottom pb-2 mb-3">스터디 그룹 만들기</h6>
  <form id="customStudyForm">
    <div class="mb-3">
      <label for="subjectSelect" class="form-label">과목 선택</label>
      <select class="form-select" id="subjectSelect">
        <option selected disabled>과목 선택</option>
        <option value="linux">리눅스 시스템 프로그래밍</option>
        <option value="java">자바</option>
        <option value="network">네트워크</option>
      </select>
    </div>
    <div class="mb-3">
      <label for="studyMembers" class="form-label">스터디 인원 수</label>
      <input type="number" class="form-control" id="studyMembers" min="2" max="10" value="2">
    </div>
    <div class="mb-3">
      <label class="form-label">추천 친구</label>
      <div class="recommended-users-container">
        <div id="recommendedUsers" class="form-check d-flex flex-column gap-1">
          <!-- 동적으로 체크박스 생성 -->
        </div>
      </div>
    </div>
    <button type="submit" class="btn btn-primary">스터디 만들기</button>
  </form>
</div>
</body>
</html>