package controller;

import dao.GroupDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/groupUpdate")
public class GroupUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String imageUrl = "";
        int maxMembers = Integer.parseInt(request.getParameter("maxMembers"));

        // 카테고리와 운영 시간 정보 가져오기
        String[] categories = request.getParameterValues("categories[]"); // 선택된 카테고리
        String[] days = request.getParameterValues("days[]"); // 요일
        String[] startTimes = request.getParameterValues("startTimes[]"); // 시작 시간
        String[] endTimes = request.getParameterValues("endTimes[]"); // 종료 시간

        GroupDAO groupDAO = new GroupDAO();

        // 그룹 업데이트 처리
        boolean isSuccess = groupDAO.updateGroup(id, title, description, imageUrl, maxMembers, categories, days, startTimes, endTimes);

        // 결과에 따라 리다이렉트
        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/groupDetail?id=" + id);
        } else {
            response.sendRedirect(request.getContextPath() + "/groupEdit?id=" + id + "&error=true");
        }
    }
}
