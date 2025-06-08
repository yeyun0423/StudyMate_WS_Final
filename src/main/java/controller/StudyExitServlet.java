package controller;

import dao.StudyGroupDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

// 사용자가 스터디 그룹에서 나갈 때 호출되는 서블릿
public class StudyExitServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 그룹 ID와 사용자 ID 가져오기
        String groupIdStr = request.getParameter("groupId");
        String userId = request.getParameter("userId");

        // 값이 없으면 목록 페이지로 이동
        if (groupIdStr == null || userId == null) {
            response.sendRedirect("mystudygroup.jsp");
            return;
        }

        // 문자열을 정수로 변환
        int groupId = Integer.parseInt(groupIdStr);

        // 그룹 탈퇴 시도
        boolean success = StudyGroupDAO.leaveStudyGroup(groupId, userId);

        // 성공 여부에 따라 메시지 포함해서 이동
        response.sendRedirect("mystudygroup.jsp?message=" + (success ? "exit_success" : "exit_fail"));
    }
}
