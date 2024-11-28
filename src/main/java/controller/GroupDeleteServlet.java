package controller;

import dao.GroupDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/groupDelete")
public class GroupDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int groupId = Integer.parseInt(request.getParameter("id"));
        GroupDAO groupDAO = new GroupDAO();
        groupDAO.deleteGroup(groupId);
        response.sendRedirect(request.getContextPath() + "/groupList");
    }
}
