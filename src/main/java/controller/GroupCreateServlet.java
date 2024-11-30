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
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        int maxMembers = Integer.parseInt(request.getParameter("maxMembers"));

        // 요일 데이터 가져오기
        String[] days = request.getParameterValues("days[]");
        String[] startTimes = request.getParameterValues("startTimes[]");
        String[] endTimes = request.getParameterValues("endTimes[]");

        // DAO 호출
        GroupDAO groupDAO = new GroupDAO();
        boolean isSuccess = groupDAO.createGroup(title, category, description, imageUrl, maxMembers, days, startTimes, endTimes);

        // 결과에 따라 다른 JSP로 포워딩
        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/groupCreateSuccess.jsp");
        } else {
            request.setAttribute("error", "모임 생성 중 오류가 발생했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/groupCreate.jsp");
            dispatcher.forward(request, response);
        }
    }
}