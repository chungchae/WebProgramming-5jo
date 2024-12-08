package controller;

import dao.GroupDAO;
import model.Category;
import model.Day;
import model.Group;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/groupEdit")
public class GroupEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int groupId = Integer.parseInt(request.getParameter("id"));
        GroupDAO groupDAO = new GroupDAO();

        // 그룹 정보 조회
        Group group = groupDAO.findGroupById(groupId);
        request.setAttribute("group", group);

        // 카테고리 정보 조회
        List<Category> categories = groupDAO.getCategoriesByGroupId(groupId);
        request.setAttribute("categories", categories);

        // 운영 시간 정보 조회
        List<Day> days = groupDAO.getDaysByGroupId(groupId);
        request.setAttribute("days", days);

        // JSP로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/groupEdit.jsp");
        dispatcher.forward(request, response);
    }
}

