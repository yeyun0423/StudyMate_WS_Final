package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginCheckFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        System.out.println("[LoginCheckFilter] uri = " + uri);

        //  1. 정적 자원은 무조건 통과 
        if (uri.matches(".*\\.(css|js|png|jpg|jpeg|gif|woff|woff2|ttf|svg|eot)$")
                || uri.contains("/resources/")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. 로그인/회원가입 페이지는 통과
        if (uri.endsWith("login.jsp") || uri.endsWith("register.jsp")
                || uri.contains("/login") || uri.contains("/register")) {
            chain.doFilter(request, response);
            return;
        }

        // 3. 로그인 체크
        boolean isLoggedIn = session != null && session.getAttribute("userId") != null;
        if (!isLoggedIn) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=notloggedin");
            return;
        }

        // 4. 나머지는 통과
        chain.doFilter(request, response);
    }
}
