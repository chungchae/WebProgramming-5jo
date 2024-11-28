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

@WebServlet("/groupDetail")
public class GroupDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int groupId = Integer.parseInt(request.getParameter("id"));
        GroupDAO groupDAO = new GroupDAO();
        Group group = groupDAO.findGroupById(groupId);
        request.setAttribute("group", group);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/groupDetail.jsp");
        dispatcher.forward(request, response);
    }
}
