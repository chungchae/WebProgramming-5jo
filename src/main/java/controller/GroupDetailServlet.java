package controller;

import dao.GroupDAO;
import model.Group;
import model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/groupDetail")
public class GroupDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int groupId = Integer.parseInt(request.getParameter("id"));
        GroupDAO groupDAO = new GroupDAO();

        // 그룹 정보 가져오기
        Group group = groupDAO.findGroupById(groupId);
        request.setAttribute("group", group);

        // 그룹에 속한 사용자 목록 가져오기
        List<User> users = groupDAO.getUsersByGroupId(groupId);
        request.setAttribute("users", users);

        // 리더의 userId 가져오기
        Long leaderUserId = groupDAO.getGroupLeaderUserId(groupId);
        request.setAttribute("leaderUserId", leaderUserId);

        // JSP로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/groupDetail.jsp");
        dispatcher.forward(request, response);
    }
}
