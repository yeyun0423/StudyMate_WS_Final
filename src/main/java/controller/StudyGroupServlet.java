package controller; // 실제 패키지명으로 수정해줘

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import dao.StudyGroupDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/StudyGroupServlet")
public class StudyGroupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String command = request.getParameter("command");
        if ("fetchFriends".equals(command)) {
            String subject = request.getParameter("subject");
            List<String> friends = StudyGroupDAO.getAvailableUsersBySubject(subject);
            response.setContentType("text/plain; charset=UTF-8");

            StringBuilder sb = new StringBuilder("[");
            for (int i = 0; i < friends.size(); i++) {
                sb.append("\"").append(friends.get(i)).append("\"");
                if (i < friends.size() - 1) sb.append(",");
            }
            sb.append("]");
            response.getWriter().write(sb.toString()); // 간단한 JSON 배열 형태로 응답
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String command = request.getParameter("command");

        if ("createStudy".equals(command)) {
            String subject = request.getParameter("subject");
            int maxMembers = Integer.parseInt(request.getParameter("max_members"));
            String[] friendsArray = request.getParameterValues("friends[]");

            String userId = (String) request.getSession().getAttribute("userId");
            List<String> friends = Arrays.asList(friendsArray);

            boolean success = StudyGroupDAO.createStudyGroup(userId, subject, maxMembers, friends);
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write(success ? "스터디 생성 완료!" : "스터디 생성 실패...");
        }
    }
}
