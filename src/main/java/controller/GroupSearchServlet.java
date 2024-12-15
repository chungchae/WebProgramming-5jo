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

@WebServlet("/groupSearch")
public class GroupSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 검색어 가져오기
        String searchQuery = request.getParameter("search");

        // DAO 호출
        GroupDAO groupDAO = new GroupDAO();
        List<Group> searchResults = groupDAO.searchGroupsByTitle(searchQuery);

        // 검색 결과와 검색어를 JSP로 전달
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("searchQuery", searchQuery);

        // JSP로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("groupSearch.jsp");
        dispatcher.forward(request, response);
    }
}
