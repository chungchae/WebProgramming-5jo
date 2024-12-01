package controller;

import dao.GroupDAO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/groupCreate")
public class GroupCreateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        int maxMembers = Integer.parseInt(request.getParameter("maxMembers"));

        // 카테고리 데이터 가져오기
        String[] categories = request.getParameterValues("categories[]");

        // 운영 시간 데이터 가져오기
        String[] days = request.getParameterValues("days[]");
        String[] startTimes = request.getParameterValues("startTimes[]");
        String[] endTimes = request.getParameterValues("endTimes[]");

        GroupDAO groupDAO = new GroupDAO();
        boolean isCreated = groupDAO.createGroup(title, description, imageUrl, maxMembers, categories, days, startTimes, endTimes);

        if (isCreated) {
            response.sendRedirect("groupCreateSuccess.jsp");
        } else {
            request.setAttribute("error", "그룹 생성에 실패했습니다.");
            request.getRequestDispatcher("groupCreate.jsp").forward(request, response);
        }
    }
}

