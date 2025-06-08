package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AdminAccessFilter implements Filter {

    private static final String LOG_DIR = "C:/logs";
    private static final String LOG_FILE_NAME = "admin_access_log.txt";
    private String logFilePath;

    // 필터가 처음 시작될 때 로그 파일 경로를 지정하고 필요한 디렉토리나 파일이 없으면 생성
    @Override
    public void init(FilterConfig filterConfig) {
        File logDir = new File(LOG_DIR);
        if (!logDir.exists()) logDir.mkdirs();

        logFilePath = LOG_DIR + "/" + LOG_FILE_NAME;

        try {
            File logFile = new File(logFilePath);
            if (!logFile.exists()) logFile.createNewFile();
        } catch (IOException e) {
            System.err.println("로그파일 생성 실패: " + e.getMessage());
        }

        System.out.println("로그 파일 위치: " + logFilePath);
    }

    // 관리자만 접근 가능한 페이지 필터링
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        System.out.println("AdminAccessFilter: " + uri);

        // css, js 같은 정적 자원은 필터 제외
        if (uri.matches(".*(\\.css|\\.js|\\.png|\\.jpg|\\.jpeg|\\.gif|\\.svg|\\.ico)$") ||
            uri.contains("/resources/")) {
            chain.doFilter(request, response);
            return;
        }

        // 세션에서 isAdmin 속성이 true인지 확인
        boolean isAdmin = session != null && Boolean.TRUE.equals(session.getAttribute("isAdmin"));

        if (isAdmin) {
            // 관리자라면 로그 작성 후 요청 계속 진행
            String ip = req.getRemoteAddr();
            String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            String userId = (session != null && session.getAttribute("userId") != null)
                    ? (String) session.getAttribute("userId") : "알 수 없음";

            String log = "[" + timestamp + "] 관리자 접근 | ID: " + userId +
                         " | URI: " + uri + " | IP: " + ip + "\n";
            try (FileWriter fw = new FileWriter(logFilePath, true)) {
                fw.write(log);
            } catch (IOException e) {
                System.err.println("로그 작성 실패: " + e.getMessage());
            }

            chain.doFilter(request, response);
        } else {
            // 관리자가 아니면 home.jsp로 돌려보냄
            res.sendRedirect("home.jsp?error=adminonly");
        }
    }
}
