package controller;

import dao.GroupDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Group;

import java.io.IOException;
import java.util.List;

@WebServlet("/groupSearch")
public class GroupSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String groupType = request.getParameter("groupType");
        String groupName = request.getParameter("groupName");

        GroupDAO groupDAO = new GroupDAO();
        List<Group> groups = groupDAO.findGroups(groupType, groupName);

        // 결과를 JSP로 전달
        request.setAttribute("groups", groups);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/groupResult.jsp");
        dispatcher.forward(request, response);
    }
}
