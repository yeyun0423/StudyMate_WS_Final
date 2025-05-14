<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>문의 답변 목록</title>
</head>
<body>
  <%@ include file="navbar.jsp"%>
  
  <main class="container my-5">
    <!-- 문의 답변 목록 테이블 -->
    <div class="my-3 p-3 bg-body rounded shadow-sm">
      <h6 class="border-bottom pb-2 mb-0">전체 문의 답변 목록</h6>

      <!-- 문의 답변 목록 테이블 -->
      <table class="table table-striped">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">문의 제목</th>
            <th scope="col">작성자</th>
            <th scope="col">답변 상태</th>
            <th scope="col">답변 작성일</th>
            <th scope="col">관리</th>
          </tr>
        </thead>
        <tbody>
          <!-- 문의 답변 정보 반복 출력 -->
          <tr>
            <th scope="row">1</th>
            <td>스터디 그룹 가입 방법</td>
            <td>홍길동</td>
            <td>답변 완료</td>
            <td>2025-05-01</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>스터디 주제 변경 요청</td>
            <td>김철수</td>
            <td>답변 대기</td>
            <td>2025-05-02</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>스터디 관련 자료 요청</td>
            <td>이영희</td>
            <td>답변 완료</td>
            <td>2025-05-03</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <!-- 추가적인 문의 답변 항목들이 여기 반복되도록 구현할 수 있어요. -->
        </tbody>
      </table>

      <!-- 문의 답변이 많을 경우 페이지네이션 추가 -->
      <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
          <li class="page-item disabled">
            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a>
          </li>
          <li class="page-item active">
            <a class="page-link" href="#">1</a>
          </li>
          <li class="page-item">
            <a class="page-link" href="#">2</a>
          </li>
          <li class="page-item">
            <a class="page-link" href="#">3</a>
          </li>
          <li class="page-item">
            <a class="page-link" href="#">다음</a>
          </li>
        </ul>
      </nav>
    </div>

  </main>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
