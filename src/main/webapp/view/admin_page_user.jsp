<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <title>전체 유저 관리자 페이지</title>
</head>
<body>
  <%@ include file="navbar.jsp"%>
  
  <main class="container my-5">

    <!-- 유저 목록 테이블 -->
    <div class="my-3 p-3 bg-body rounded shadow-sm">
      <h6 class="border-bottom pb-2 mb-0">전체 유저 목록</h6>

      <!-- 유저 목록 테이블 -->
      <table class="table table-striped">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">아이디</th>
            <th scope="col">이름</th>
            <th scope="col">이메일</th>
            <th scope="col">가입일</th>
            <th scope="col">관리</th>
          </tr>
        </thead>
        <tbody>
          <!-- 유저 정보 반복 출력 -->
          <tr>
            <th scope="row">1</th>
            <td>user01</td>
            <td>홍길동</td>
            <td>user01@example.com</td>
            <td>2023-05-01</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>user02</td>
            <td>김철수</td>
            <td>user02@example.com</td>
            <td>2023-06-15</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>user03</td>
            <td>박영희</td>
            <td>user03@example.com</td>
            <td>2023-07-10</td>
            <td>
              <a href="#" class="btn btn-primary btn-sm">수정</a>
              <a href="#" class="btn btn-danger btn-sm">삭제</a>
            </td>
          </tr>
          <!-- 추가적인 유저 항목들이 여기 반복되도록 구현할 수 있어요. -->
        </tbody>
      </table>

      <!-- 유저가 많을 경우 페이지네이션 추가 -->
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
