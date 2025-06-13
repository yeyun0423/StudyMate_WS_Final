package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.*;

// 사용자가 요청한 파일을 다운로드할 수 있도록 처리하는 서블릿
public class DownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String filename = request.getParameter("file");

        // 파일명이 없으면 잘못된 요청 처리
        if (filename == null || filename.trim().equals("")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "파일명이 지정되지 않았습니다.");
            return;
        }

        // 실제 파일 경로 (upload 폴더)
        String uploadPath = getServletContext().getRealPath("/resources/upload");

        // 폴더 없으면 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File file = new File(uploadPath, filename);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일이 존재하지 않습니다.");
            return;
        }

        // 응답 헤더 설정 (다운로드용)
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" +
                java.net.URLEncoder.encode(filename.substring(filename.indexOf("_") + 1), "UTF-8")
                        .replaceAll("\\+", "%20") + "\"");
        response.setContentLengthLong(file.length());

        // 파일 내용 전송
        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {

            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }
}
