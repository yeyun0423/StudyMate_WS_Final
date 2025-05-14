<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>스터디 매칭 목록</title>
</head>
<body>
  <%@ include file="navbar.jsp"%>
  
  <main class="container my-5">

    <!-- 스터디 매칭 목록 테이블 -->
    <div class="my-3 p-3 bg-body rounded shadow-sm">
      <h6 class="border-bottom pb-2 mb-0">전체 스터디 매칭 목록</h6>

      <!-- 스터디 매칭 목록 테이블 -->
      <table class="table table-striped">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">스터디 이름</th>
            <th scope="col">참여자 수</th>
            <th scope="col">주제</th>
            <th scope="col">매칭 상태</th>
            <th scope="col">관리</th>
          </tr>
        </thead>
        <tbody>
          <!-- 스터디 정보 반복 출력 -->
          <tr>
            <th scope="row">1</th>
            <td>Java Spring 스터디</td>
            <td>5명</td>
            <td>백엔드 개발</td>
            <td>진행 중</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>React.js 스터디</td>
            <td>3명</td>
            <td>프론트엔드 개발</td>
            <td>모집 중</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>Python 데이터 분석 스터디</td>
            <td>7명</td>
            <td>데이터 분석</td>
            <td>완료</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <!-- 추가적인 스터디 항목들이 여기 반복되도록 구현할 수 있어요. -->
        </tbody>
      </table>

      <!-- 스터디가 많을 경우 페이지네이션 추가 -->
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
