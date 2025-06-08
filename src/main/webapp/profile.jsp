<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.UserDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    String userName = null;
    String profileImage = (String) session.getAttribute("profileImage");

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("user_name".equals(c.getName())) {
                userName = c.getValue();
                break;
            }
        }
    }

    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (profileImage == null || profileImage.trim().isEmpty()) {
        profileImage = new UserDAO().getProfileImageById(userId);
        if (profileImage == null || profileImage.trim().isEmpty()) {
            profileImage = "default.png";
        }
        session.setAttribute("profileImage", profileImage);
    }

    UserDTO user = new UserDAO().getUserById(userId);
    String birthDateStr = "";
    if (user.getBirthDate() != null) {
        birthDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(user.getBirthDate());
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>StudyMate - 프로필 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=SUIT:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'SUIT', sans-serif; }
        body { background: linear-gradient(to bottom right, #f0f4ff, #e0e7ff); }
        .section-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            width: 100%;
        }
        .btn-primary {
            background-color: #4f46e5;
            border: none;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #4338ca;
        }
        .btn-outline-danger, .btn-outline-primary {
            border-radius: 12px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <jsp:include page="navbar.jsp" />

    <div class="section-card">
        <div class="row">
            <!-- 프로필 이미지 영역 -->
            <div class="col-md-4 text-center" style="margin-top: 40px;">
                <div class="mb-4">
                    <img src="<%= request.getContextPath() %>/resources/images/<%= profileImage %>"
                         alt="프로필 이미지" class="img-thumbnail rounded-circle"
                         style="width: 200px; height: 200px; object-fit: cover;">
                </div>

               
                <form action="<%= request.getContextPath() %>/profileUpload" method="post" enctype="multipart/form-data" class="mb-3">
                    <div class="input-group">
                        <input type="file" class="form-control" name="profileImage" required>
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button type="submit" class="btn btn-outline-primary">업로드</button>
                    </div>
                </form>

                <form action="<%= request.getContextPath() %>/deleteImage" method="post"
                      onsubmit="return confirm('정말 프로필 이미지를 삭제하시겠습니까?');">
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <button type="submit" class="btn btn-outline-danger btn-sm mt-2">현재 프로필 사진 삭제하기</button>
                </form>
            </div>

            <!-- 사용자 정보 수정 영역 -->
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

                    <div class="d-flex gap-2 mt-4 justify-content-end align-items-center">
                        <button type="submit" class="btn btn-primary btn-sm px-4">저장</button>
                    </div>
                </form>

                <!-- 회원 탈퇴는 form-->
                <form action="<%= request.getContextPath() %>/deleteAccount" method="post"
                      onsubmit="return confirm('정말 탈퇴하시겠습니까?');" class="text-end mt-2">
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <button type="submit" class="btn btn-outline-danger btn-sm px-3">회원 탈퇴</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
