package controller;

import dao.GroupDAO;
import model.Category;
import model.Group;
import model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/groupDetail")
public class GroupDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int groupId = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();

        Long sessionUserId = (Long) session.getAttribute("userId");
        GroupDAO groupDAO = new GroupDAO();

        // 그룹 정보 가져오기
        Group group = groupDAO.findGroupById(groupId);
        if (group == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "그룹을 찾을 수 없습니다.");
            return;
        }
        request.setAttribute("group", group);

        // 그룹에 속한 사용자 목록 가져오기
        List<User> users = groupDAO.getUsersByGroupId(groupId);
        request.setAttribute("users", users);

        // 그룹의 카테고리 목록 가져오기
        List<Category> categories = groupDAO.getCategoriesByGroupId(groupId);
        group.setCategories(categories); // 그룹 객체에 카테고리 추가
        request.setAttribute("categories", categories);

        // 현재 사용자의 statement 가져오기
        String statement = null;
        if (sessionUserId != null) {
            statement = groupDAO.getUserStatement(groupId, sessionUserId);
        }
        request.setAttribute("statement", statement);

        // JSP로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/groupDetail.jsp");
        dispatcher.forward(request, response);
    }
}
