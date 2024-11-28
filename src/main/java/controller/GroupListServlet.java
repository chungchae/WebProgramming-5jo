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

@WebServlet("/groupList")
public class GroupListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // DAO 호출하여 그룹 데이터 가져오기
        GroupDAO groupDAO = new GroupDAO();
        List<Group> groups = groupDAO.findAllGroups();

        // JSP로 데이터 전달
        request.setAttribute("groups", groups);
        RequestDispatcher dispatcher = request.getRequestDispatcher("groupList.jsp");
        dispatcher.forward(request, response);
    }
}
