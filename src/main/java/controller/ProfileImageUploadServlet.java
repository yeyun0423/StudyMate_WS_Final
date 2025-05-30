package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProfileImageUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("✅✅ ProfileImageUploadServlet 진입됨 ✅✅");

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String userId = request.getParameter("userId");

        // 실제 저장 경로
        String uploadPath = request.getServletContext().getRealPath("/resources/images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // 파일 받기
        Part filePart = request.getPart("profileImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String savedFileName = null;
        if (fileName != null && !fileName.isEmpty()) {
            // 파일명 중복 방지를 위한 유니크 이름 생성
            savedFileName = System.currentTimeMillis() + "_" + userId + "_" + fileName;
            String fullPath = uploadPath + File.separator + savedFileName;

            // 저장
            filePart.write(fullPath);

            System.out.println("[UPLOAD] 저장 경로: " + fullPath);
            System.out.println("[UPLOAD] 저장 성공 여부: " + new File(fullPath).exists());

            // ✅ DB에는 파일명만 저장
            UserDAO dao = new UserDAO();
            dao.updateUserProfileImage(userId, savedFileName);

            // ✅ 세션에도 파일명만 저장 (JSP에서 경로 포함시켜 출력)
            session.setAttribute("profileImage", savedFileName);
        }

        // 리다이렉트
        response.sendRedirect("profile.jsp");
    }
}