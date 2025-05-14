<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <title>랜던 스터디 모달</title>
</head>
<body>
<div class="my-3 p-3 bg-body rounded shadow-sm">
  <h6 class="border-bottom pb-2 mb-3">랜덤 스터디 그룹 생성</h6>
  <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#randomStudyModal">랜덤 생성</button>
</div>

<div class="modal fade" id="randomStudyModal" tabindex="-1" aria-labelledby="randomStudyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="randomStudyModalLabel">랜덤 스터디 그룹 옵션 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="randomStudyForm">
          <div class="mb-3">
            <label for="modalSubject" class="form-label">과목 선택</label>
            <select class="form-select" id="modalSubject">
              <option selected>과목 선택</option>
              <option value="linux">리눅스 시스템 프로그래밍</option>
              <option value="java">자바</option>
              <option value="network">네트워크</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="groupSize" class="form-label">인원 수</label>
            <input type="number" class="form-control" id="groupSize" min="2" max="10" value="2">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="createRandomStudy">랜덤 생성</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>