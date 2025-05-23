package controller;

import dao.UserDAO;
import dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import util.SHA256Util;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        String name = request.getParameter("name");
        String birthStr = request.getParameter("birthDate");
        String currentPw = request.getParameter("currentPassword");
        String newPw = request.getParameter("newPassword");
        String confirmPw = request.getParameter("confirmPassword");
        String profileImage = null;

        boolean deleteImage = "true".equals(request.getParameter("deleteImage"));

        // 이미지 업로드 처리
        Part filePart = request.getPart("profileImage");
        if (!deleteImage && filePart != null && filePart.getSize() > 0) {
            String fileName = new File(filePart.getSubmittedFileName()).getName();
            String uploadPath = getServletContext().getRealPath("/resources/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
            profileImage = fileName;
        }

        try {
            UserDAO dao = new UserDAO();
            UserDTO user = dao.getUserById(userId);

            if (user == null) {
                response.sendRedirect("profile.jsp?error=nouser");
                return;
            }

            // 비밀번호 변경 요청이 있는 경우에만 검증
            if (newPw != null && !newPw.isEmpty()) {
                if (!SHA256Util.encrypt(currentPw).equals(user.getPassword())) {
                    response.sendRedirect("profile.jsp?error=wrongpassword");
                    return;
                }

                if (newPw.equals(confirmPw)) {
                    user.setPassword(SHA256Util.encrypt(newPw));
                } else {
                    response.sendRedirect("profile.jsp?error=nomatch");
                    return;
                }
            }

            user.setName(name);

            if (birthStr != null && !birthStr.trim().isEmpty()) {
                user.setBirthDate(new SimpleDateFormat("yyyy-MM-dd").parse(birthStr));
            }

            if (deleteImage) {
                user.setProfileImage("default.png");
            } else if (profileImage != null) {
                user.setProfileImage(profileImage);
            }

            boolean updated = dao.updateUser(user);

            if (updated) {
                session.setAttribute("userName", user.getName());
                session.setAttribute("profileImage", user.getProfileImage());

                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("if (confirm('회원 정보 수정이 완료되었습니다!')) {");
                out.println("  window.location.href = 'profile.jsp';");
                out.println("} else {");
                out.println("  window.location.href = 'profile.jsp';");
                out.println("}");
                out.println("</script>");
            } else {
                response.sendRedirect("profile.jsp?error=updatefail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
