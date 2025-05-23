package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AdminAccessFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean isAdmin = session != null && Boolean.TRUE.equals(session.getAttribute("isAdmin"));

        if (!isAdmin) {
            res.sendRedirect("home.jsp?error=adminonly");
            return;
        }

        chain.doFilter(request, response);
    }
}