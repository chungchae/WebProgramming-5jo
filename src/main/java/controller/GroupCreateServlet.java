package controller;

import dao.GroupDAO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/groupCreate")
public class GroupCreateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 사용자 입력 데이터 가져오기
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        int maxMembers;

        try {
            maxMembers = Integer.parseInt(request.getParameter("maxMembers"));
        } catch (NumberFormatException e) {
            // 숫자 변환 실패 시 기본값 설정
            maxMembers = 0;
            request.setAttribute("error", "최대 인원 입력이 잘못되었습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/groupCreate.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // DAO를 통해 데이터 삽입
        GroupDAO groupDAO = new GroupDAO();
        boolean isSuccess = groupDAO.createGroup(title, category, description, imageUrl, maxMembers);

        // 결과에 따라 다른 JSP로 포워딩
        if (isSuccess) {
            // 성공 시 success 페이지로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher("/groupCreateSuccess.jsp");
            dispatcher.forward(request, response);
        } else {
            // 실패 시 폼 페이지로 포워딩
            request.setAttribute("error", "모임 생성 중 오류가 발생했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/groupCreate.jsp");
            dispatcher.forward(request, response);
        }
    }
}