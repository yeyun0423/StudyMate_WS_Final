package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

public class DownloadServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String filename = request.getParameter("file");
        if (filename == null || filename.trim().equals("")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "파일명이 지정되지 않았습니다.");
            return;
        }

        // 업로드 경로 설정
        String uploadPath = getServletContext().getRealPath("/upload");

        // 업로드 폴더가 존재하지 않으면 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); 
        }

        // 요청한 파일 객체 생성
        File file = new File(uploadPath, filename);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일이 존재하지 않습니다.");
            return;
        }

        // 응답 헤더 설정
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" +
                java.net.URLEncoder.encode(filename.substring(filename.indexOf("_") + 1), "UTF-8")
                        .replaceAll("\\+", "%20") + "\"");
        response.setContentLengthLong(file.length());

        // 파일 스트림 처리
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
