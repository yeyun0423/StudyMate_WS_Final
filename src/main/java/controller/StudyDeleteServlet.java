package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

// 사용자가 스터디 그룹을 삭제할 때 호출되는 서블릿
public class StudyDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 삭제할 스터디 그룹 ID 가져오기
        String groupIdStr = request.getParameter("groupId");

        // 값이 없으면 마이스터디 페이지로
        if (groupIdStr == null) {
            response.sendRedirect("mystudygroup.jsp");
            return;
        }

        // 문자열을 정수로 변환
        int groupId = Integer.parseInt(groupIdStr);

        // 그룹 삭제 시도
        boolean success = StudyGroupDAO.deleteStudyGroup(groupId);

        // 결과에 따라 메시지와 함께 페이지 이동
        response.sendRedirect("mystudygroup.jsp?message=" + (success ? "delete_success" : "delete_fail"));
    }
}
