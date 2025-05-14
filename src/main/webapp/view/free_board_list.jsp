<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>

<%
    class Post {
        int id;
        String title;
        String writer;
        String date;
        Post(int id, String title, String writer, String date) {
            this.id = id;
            this.title = title;
            this.writer = writer;
            this.date = date;
        }
    }

    // 게시글 리스트
    List<Post> posts = new ArrayList<>();
    posts.add(new Post(1, "종강이 필요해요!!", "예윤", "2025-05-14"));
    posts.add(new Post(2, "집에 갈래요ㅠㅠ", "관리자", "2025-05-13"));
    posts.add(new Post(3, "스터디가 너무 어려워요", "홍길동", "2025-05-12"));
    posts.add(new Post(4, "시험기간이라 너무 힘들어요", "김철수", "2025-05-11"));
    posts.add(new Post(5, "일이 너무 많아요", "박지은", "2025-05-10"));
    posts.add(new Post(6, "오늘 날씨 너무 좋네요!", "최영희", "2025-05-09"));
    posts.add(new Post(7, "점심은 뭐 먹지?", "김미래", "2025-05-08"));
    posts.add(new Post(8, "주말에 뭐 할까요?", "홍기표", "2025-05-07"));
    posts.add(new Post(9, "오랜만에 운동해야겠다", "정수진", "2025-05-06"));
    posts.add(new Post(10, "새로운 프로젝트 시작합니다", "이동희", "2025-05-05"));

    // 페이지네이션을 위한 설정
    int currentPage = 1; // 현재 페이지
    int postsPerPage = 5; // 페이지당 게시글 수
    int totalPosts = posts.size(); // 전체 게시글 수
    int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage); // 전체 페이지 수

    if(request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    // 페이지네이션을 위한 리스트 조정
    int startIndex = (currentPage - 1) * postsPerPage;
    int endIndex = Math.min(startIndex + postsPerPage, totalPosts);

    List<Post> paginatedPosts = posts.subList(startIndex, endIndex);
%>

<html>
<head>
  <title>자유게시판 목록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>
  <main class="container my-4">
    <div class="p-3 bg-body rounded shadow-sm">
      <h6 class="border-bottom pb-2 mb-3 fw-bold">📋 자유게시판</h6>

      <% for(Post post : paginatedPosts) { %>
        <div class="d-flex text-body-secondary pt-3">
          <svg aria-label="Placeholder: 32x32"
               class="bd-placeholder-img flex-shrink-0 me-2 rounded"
               width="32" height="32" xmlns="http://www.w3.org/2000/svg"
               role="img" preserveAspectRatio="xMidYMid slice">
            <rect width="100%" height="100%" fill="#0d6efd"></rect>
          </svg>

          <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
            <div class="d-flex justify-content-between">
              <a href="#" class="fw-semibold text-dark text-decoration-none">
                <%= post.title %>
              </a>
              <small><%= post.date %></small>
            </div>
            <span class="d-block"><%= post.writer %></span>
          </div>
        </div>
      <% } %>

      <div class="d-flex justify-content-end mt-3">
        <a href="${pageContext.request.contextPath}/view/free_board_write.jsp" class="btn btn-primary">글쓰기</a>
      </div>

      <!-- 페이지네이션 추가 -->
      <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-4">
          <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
            <a class="page-link" href="?page=<%= currentPage - 1 %>">이전</a>
          </li>

          <% for(int i = 1; i <= totalPages; i++) { %>
            <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
              <a class="page-link" href="?page=<%= i %>"><%= i %></a>
            </li>
          <% } %>

          <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
            <a class="page-link" href="?page=<%= currentPage + 1 %>">다음</a>
          </li>
        </ul>
      </nav>

    </div>
  </main>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
