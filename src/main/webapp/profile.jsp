<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.UserDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    String userName = null;
    String profileImage = (String) session.getAttribute("profileImage");

    // 쿠키에서 user_name 가져오기
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) {
                userName = c.getValue();
                break;
            }
        }
    }

    // 로그인 안 된 경우 리다이렉트
    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // fallback: 세션에 profileImage가 없으면 DB에서 다시 가져오기
    if (profileImage == null || profileImage.isEmpty()) {
        profileImage = new UserDAO().getProfileImageById(userId);
        session.setAttribute("profileImage", profileImage); // 세션에 다시 저장
    }

    UserDTO user = new UserDAO().getUserById(userId);
    String birthDateStr = "";
    if (user.getBirthDate() != null) {
        birthDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(user.getBirthDate());
    }
%>


<html>
<head>
    <title>프로필 수정</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/home.css?v=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container py-4">
    <jsp:include page="navbar.jsp" />

    <div class="row mt-5">
        <!-- 이미지 영역 -->
        <div class="col-md-4 text-center">
            <div class="mb-4" style="margin-top: 60px;">
               <img src="<%= request.getContextPath() %>/resources/images/<%= profileImage %>" 
     alt="프로필 이미지" class="img-thumbnail rounded-circle"
     style="width: 200px; height: 200px; object-fit: cover;">
               
            </div>

            <!-- 이미지 업로드 전용 폼 -->
            <form action="<%= request.getContextPath() %>/profileUpload" method="post" enctype="multipart/form-data" class="mb-3">
                <div class="input-group">
                    <input type="file" class="form-control" id="profileImageInput" name="profileImage" required>
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <button type="submit" class="btn btn-outline-primary">
                        <i class="bi bi-upload"></i> 업로드
                    </button>
                </div>
            </form>

            <!-- 이미지 삭제 전용 폼 -->
           <form action="<%= request.getContextPath() %>/deleteImage" method="post" onsubmit="return confirm('정말 프로필 이미지를 삭제하시겠습니까?');" class="mt-2">
    <input type="hidden" name="userId" value="<%= userId %>">
    <button type="submit" class="btn btn-outline-danger btn-sm mt-2">
        현재 프로필 사진 삭제하기
    </button>
</form>
           
        </div>

        <!-- 프로필 수정 영역 -->
        <div class="col-md-8">
            <form action="<%= request.getContextPath() %>/updateProfile" method="post">
                <div class="mb-3">
                    <label>이름</label>
                    <input type="text" name="name" class="form-control" value="<%= user.getName() %>" placeholder="이름을 입력하세요.">
                </div>
                <div class="mb-3">
                    <label>생년월일</label>
                    <input type="date" name="birthDate" class="form-control" value="<%= birthDateStr %>">
                </div>
                <div class="mb-3">
                    <label>현재 비밀번호</label>
                    <input type="password" name="currentPassword" class="form-control" placeholder="현재 비밀번호를 입력하세요">
                </div>
                <div class="mb-3">
                    <label>새 비밀번호</label>
                    <input type="password" name="newPassword" class="form-control" placeholder="새 비밀번호를 입력하세요">
                </div>
                <div class="mb-3">
                    <label>새 비밀번호 확인</label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="새 비밀번호를 다시 입력하세요">
                </div>

                <input type="hidden" name="userId" value="<%= userId %>">

                <!-- 저장 + 탈퇴 버튼을 나란히 배치 -->
                <div class="d-flex gap-2 mt-4 justify-content-end align-items-center">
                    <button type="submit" class="btn btn-primary btn-sm px-4">저장</button>

                    <form action="<%= request.getContextPath() %>/deleteAccount" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?');" class="m-0">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button type="submit" class="btn btn-outline-danger btn-sm px-3">회원 탈퇴</button>
                    </form>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
