package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

// 사용자가 프로필 이미지를 업로드하면 DB와 세션에 반영하는 서블릿
public class ProfileImageUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // 실제 파일이 저장될 서버 경로
        String uploadPath = request.getServletContext().getRealPath("/resources/images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String userId = null;
        String savedFileName = null;

        try {
            // 파일 업로드 설정
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("UTF-8");

            // 요청에서 form 데이터와 파일 데이터를 분리해서 처리
            List<FileItem> formItems = upload.parseRequest(request);
            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    // 일반 데이터 처리: userId 추출
                    if ("userId".equals(item.getFieldName())) {
                        userId = item.getString("UTF-8");
                    }
                } else {
                    // 파일 업로드 처리
                    String fileName = new File(item.getName()).getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        savedFileName = fileName;
                        String fullPath = uploadPath + File.separator + savedFileName;
                        item.write(new File(fullPath));
                    }
                }
            }

            // DB에 프로필 이미지 파일명 저장 + 세션 갱신
            if (userId != null && savedFileName != null) {
                UserDAO dao = new UserDAO();
                dao.updateUserProfileImage(userId, savedFileName);
                session.setAttribute("profileImage", savedFileName);
            }

        } catch (Exception ex) {
            ex.printStackTrace(); // 에러 로그
        }

        // 업로드 완료 후 프로필 페이지로 이동
        response.sendRedirect("profile.jsp");
    }
}
