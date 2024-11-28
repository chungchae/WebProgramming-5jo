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

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        int maxMembers = Integer.parseInt(request.getParameter("maxMembers"));

        GroupDAO groupDAO = new GroupDAO();
        groupDAO.updateGroup(id, title, category, description, imageUrl, maxMembers);
        response.sendRedirect(request.getContextPath() + "/groupList");
    }
}
