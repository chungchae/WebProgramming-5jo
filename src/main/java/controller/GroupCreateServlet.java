package controller;

import dao.GroupDAO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/groupCreate")
public class GroupCreateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        int maxMembers = Integer.parseInt(request.getParameter("maxMembers"));

        // 카테고리 데이터 가져오기
        String[] categories = request.getParameterValues("categories[]");

        // 운영 시간 데이터 가져오기
        String[] days = request.getParameterValues("days[]");
        String[] startTimes = request.getParameterValues("startTimes[]");
        String[] endTimes = request.getParameterValues("endTimes[]");

        GroupDAO groupDAO = new GroupDAO();
        boolean isCreated = groupDAO.createGroup(title, description, imageUrl, maxMembers, categories, days, startTimes, endTimes);

        if (isCreated) {
            // 성공 시 알림창 띄우고 메인으로 리다이렉트
            response.getWriter().write("<script>alert('성공적으로 생성되었습니다!'); location.href='/main';</script>");
        } else {
            // 실패 시 알림창 띄우고 다시 생성 페이지로 리다이렉트
            response.getWriter().write("<script>alert('생성 중 오류가 발생했습니다. 다시 시도해주세요.'); location.href='/groupCreate';</script>");
        }
    }
}

