package controller;

import dao.GroupDAO;
import model.Group;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/main")
public class MainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GroupDAO groupDAO = new GroupDAO();

        List<Group> latestGroups = groupDAO.findLatestGroups();
        List<Group> exerciseGroups = groupDAO.findGroupsByCategory("운동");
        List<Group> studyGroups = groupDAO.findGroupsByCategory("공부");

        request.setAttribute("latestGroups", latestGroups);
        request.setAttribute("exerciseGroups", exerciseGroups);
        request.setAttribute("studyGroups", studyGroups);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.forward(request, response);
    }
}