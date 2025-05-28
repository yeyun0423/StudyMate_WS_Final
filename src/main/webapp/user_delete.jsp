<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.UserDTO, dao.UserDAO" %>
<%
    // 1. 로그인 상태 확인 및 관리자 확인
    String loginUserId = (String) session.getAttribute("userId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (loginUserId == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. 수정할 대상 유저 ID
    String targetUserId = request.getParameter("userId");
    if (targetUserId == null) {
        response.sendRedirect("user_list.jsp");
        return;
    }

    UserDTO user = new UserDAO().getUserById(targetUserId);
    String birthDateStr = "";
    if (user.getBirthDate() != null) {
        birthDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(user.getBirthDate());
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유저 정보 수정</title>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/home.css?v=3">
</head>
<body class="bg-light">
<script>
    const USER_ID = "<%= user.getUserId() %>";
    const USER_NAME = "<%= user.getName() %>";
</script>

<div class="container py-4">
    <jsp:include page="navbar.jsp" />
	<div class="d-flex justify-content-between align-items-center my-4">
    <h3 class="fw-bold my-4">👤 유저 정보 수정</h3>
    <a href="user_list.jsp" class="btn btn-secondary btn-sm">목록으로</a>
    </div>
  

    <form action="updateUserByAdmin" method="post" enctype="multipart/form-data">
        <div class="row">
            <!-- 왼쪽: 이미지 -->
            <div class="col-md-4 text-center">
                <div class="mb-4" style="margin-top: 60px;">
                    <img src="resources/images/<%= user.getProfileImage() != null ? user.getProfileImage() : "default.png" %>"
                         alt="프로필 이미지"
                         class="img-thumbnail mb-3"
                         style="width: 100%; height: 300px; object-fit: cover;">
                </div>
                <div class="mb-3 d-flex justify-content-center gap-2">
                    <label class="btn btn-secondary btn-sm">
                        <span>파일 선택</span>
                        <input type="file" name="profileImage" class="form-control-sm d-none" onchange="updateFileLabel(this)">
                    </label>
                    <span id="fileChosenText" class="ms-2">선택된 파일 없음</span>
                    <input type="hidden" id="deleteImage" name="deleteImage" value="false">
                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="markDeleteImage()">현재 프로필 사진 삭제</button>
                </div>
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            </div>

            <!-- 오른쪽: 폼 입력 -->
            <div class="col-md-8">
                <div class="mb-3">
                    <label>아이디</label>
                    <input type="text" class="form-control" value="<%= user.getUserId() %>" readonly>
                </div>
                <div class="mb-3">
                    <label>이름</label>
                    <input type="text" name="name" class="form-control" value="<%= user.getName() %>">
                </div>
                <div class="mb-3">
                    <label>생년월일</label>
                    <input type="date" name="birthDate" class="form-control" value="<%= birthDateStr %>">
                </div>
                <div class="mb-3">
                    <label>비밀번호</label>
                    <input type="password" name="newPassword" class="form-control" placeholder="비밀번호를 수정하려면 입력하세요">
                </div>
                <button type="submit" class="btn btn-primary w-100">저장하기</button>
            </div>
        </div>
    </form>
</div>

<script>
    function markDeleteImage() {
        document.getElementById("deleteImage").value = "true";
        alert("프로필 이미지 삭제가 설정되었습니다.");
    }

    function updateFileLabel(input) {
        const fileName = input.files.length > 0 ? input.files[0].name : "";
        document.getElementById("fileChosenText").innerText = fileName || "선택된 파일 없음";
    }
</script>

<script src="resources/js/lang.js"></script>
<script src="resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
