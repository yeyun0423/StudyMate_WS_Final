package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginCheckFilter implements Filter {

    // 사용자가 로그인을 했는지 확인하고, 안 했으면 접근 못 하게 막는 필터
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        System.out.println("[LoginCheckFilter] uri = " + uri);

        // css, js, 이미지 같은 정적 파일들은 필터하지 않음
        if (uri.matches(".*\\.(css|js|png|jpg|jpeg|gif|woff|woff2|ttf|svg|eot)$")
                || uri.contains("/resources/")) {
            chain.doFilter(request, response);
            return;
        }

        // 로그인이나 회원가입 관련된 요청도 막으면 안 되니까 통과
        if (uri.endsWith("login.jsp") || uri.endsWith("register.jsp")
                || uri.contains("/login") || uri.contains("/register")) {
            chain.doFilter(request, response);
            return;
        }

        // 세션에 userId가 있으면 로그인 
        boolean isLoggedIn = session != null && session.getAttribute("userId") != null;

        // 로그인 안 한 사람은 로그인 페이지로 돌려보냄
        if (!isLoggedIn) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=notloggedin");
            return;
        }

        // 로그인 한 사람은 그냥 계속 진행
        chain.doFilter(request, response);
    }
}
