<%@ page contentType="text/html; charset=utf-8" %>

<!-- 시간표 추가 모달 -->
<div class="modal fade" id="addTimetableModal" tabindex="-1" aria-labelledby="addTimetableModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content rounded-4">
      <form action="addTimetable.jsp" method="post">
        <div class="modal-header border-bottom-0">
          <h5 class="modal-title fw-bold" id="addTimetableModalLabel">시간표 추가</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>
        <div class="modal-body pt-0">
          <div class="mb-3">
            <label class="form-label fw-semibold">요일</label>
            <select name="day" class="form-select" required>
              <option value="">선택하세요</option>
              <option value="월요일">월요일</option>
              <option value="화요일">화요일</option>
              <option value="수요일">수요일</option>
              <option value="목요일">목요일</option>
              <option value="금요일">금요일</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label fw-semibold">교시</label>
            <select name="period" class="form-select" required>
              <option value="">선택하세요</option>
              <option value="1교시">1교시</option>
              <option value="2교시">2교시</option>
              <option value="3교시">3교시</option>
              <option value="4교시">4교시</option>
            </select>
      
	       <div class="mb-3">
  <label class="form-label fw-semibold">과목명</label>
  <select name="subject" class="form-select" required>
    <option value="">선택하세요</option>
    <option value="자료구조">자료구조</option>
    <option value="운영체제">운영체제</option>
    <option value="컴퓨터네트워크">컴퓨터네트워크</option>
    <option value="데이터베이스">데이터베이스</option>
    <option value="웹프로그래밍">웹프로그래밍</option>
    <option value="소프트웨어공학">소프트웨어공학</option>
  </select>
</div>
	       
      
        <div class="modal-footer border-top-0">
          <button type="submit" class="btn btn-primary w-100">등록</button>
        </div>
      </form>
    </div>
  </div>
</div>
