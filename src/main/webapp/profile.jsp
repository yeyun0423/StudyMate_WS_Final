<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.UserDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String profileImage = (String) session.getAttribute("profileImage");

    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
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

    <!-- 프로필 수정 폼 -->
    <form action="updateProfile" method="post" enctype="multipart/form-data">
        <div class="row mt-5">
            <!-- 이미지 영역 -->
            <div class="col-md-4 text-center">
                <div class="mb-4" style="margin-top: 60px;">
                    <img src="<%= request.getContextPath() %>/resources/images/<%= (profileImage != null && !profileImage.equals("")) ? profileImage : "default.png" %>"
                         alt="프로필 이미지"
                         class="img-thumbnail mb-3 rounded-circle"
                         style="width: 200px; height: 200px; object-fit: cover;">
                </div>

                <!-- 이미지 업로드 -->
<form action="profileUpload" method="post" enctype="multipart/form-data" id="uploadForm">
    <div class="input-group">
        <!-- 파일 선택 -->
        <input type="file" class="form-control" id="profileImageInput" name="profileImage" required>
        
        <!-- 업로드 버튼 -->
        <button type="submit" class="btn btn-outline-primary">
            <i class="bi bi-upload"></i> 업로드
        </button>
    </div>

    <!-- 유저 ID 전송용 -->
    <input type="hidden" name="userId" value="<%= userId %>">
</form>


    <input type="hidden" name="userId" value="<%= userId %>">
</form>

                <input type="hidden" id="deleteImage" name="deleteImage" value="false">
                <button type="button" class="btn btn-outline-danger btn-sm mt-2" onclick="markDeleteImage()" id="btnDeleteImage">
                    현재 프로필 사진 삭제하기
                </button>

                <input type="hidden" name="userId" value="<%= userId %>">
            </div>

            <!-- 입력 필드 영역 -->
            <div class="col-md-8">
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

       
                <div class="d-flex gap-2 mt-4 justify-content-end align-items-center">
                    <!-- 저장 버튼 -->
                    <button type="submit" class="btn btn-primary btn-sm px-4">저장</button>
                </form> 

                    <!-- 회원 탈퇴 버튼 -->
                    <form action="deleteAccount" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?');" class="m-0">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button type="submit" class="btn btn-outline-danger btn-sm px-3">회원 탈퇴</button>
                    </form>
                </div>
            </div>
        </div>
</div>

<script src="<%= request.getContextPath() %>/resources/js/bootstrap.bundle.min.js"></script>
<script>
    function markDeleteImage() {
        document.getElementById("deleteImage").value = "true";
        alert("프로필 이미지 삭제가 설정되었습니다. '저장하기'를 눌러주세요.");
    }
</script>
</body>
</html> 