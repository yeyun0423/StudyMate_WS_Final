package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// 회원가입 시 아이디 중복을 확인하는 서블릿
public class CheckIdServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String userId = request.getParameter("userId");

        // DB에서 중복 여부 확인
        UserDAO dao = new UserDAO();
        boolean exists = dao.checkIdExists(userId);

        // 결과 출력 
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(exists ? "exists" : "available");
    }
}
