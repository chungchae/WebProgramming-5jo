package controller;

import db.DBConnection;
import model.Alert;
import model.Group;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/user/mypage")
public class UserMyPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");
        String email = (String) session.getAttribute("email");

        System.out.println("userId: " + userId + ", email: " + email);

        if (userId == null || email == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리디렉션
            response.sendRedirect("/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // 사용자 정보 조회
            String userQuery = "SELECT * FROM User WHERE email = ?";
            User user = null;
            try (PreparedStatement userStmt = conn.prepareStatement(userQuery)) {
                userStmt.setString(1, email);
                try (ResultSet rs = userStmt.executeQuery()) {
                    if (rs.next()) {
                        user = new User(
                                rs.getLong("id"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getString("password"),
                                rs.getString("univ"),
                                rs.getString("major"),
                                rs.getInt("grade"),
                                rs.getString("introduction"),
                                rs.getString("hobby")
                        );
                    }
                }
            }

            // user가 null일 경우, 오류 페이지로 리디렉션하거나 알림 처리
            if (user == null) {
                request.setAttribute("errorMessage", "User not found.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }
            request.setAttribute("user", user);

            // 가입된 모임 정보 조회
            String groupQuery = "SELECT g.id, g.title, g.image_url, g.current_members, g.max_members " +
                    "FROM GroupUser gu " +
                    "JOIN group_table g ON gu.group_table_id = g.id " +
                    "WHERE gu.user_id = ? AND gu.statement != '가입대기'";
            List<Group> groups = new ArrayList<>();
            try (PreparedStatement groupStmt = conn.prepareStatement(groupQuery)) {
                groupStmt.setLong(1, userId);
                try (ResultSet rs = groupStmt.executeQuery()) {
                    while (rs.next()) {
                        groups.add(new Group(
                                rs.getInt("id"),
                                rs.getString("title"),
                                rs.getString("image_url"),
                                rs.getInt("current_members"),
                                rs.getInt("max_members")
                        ));
                    }
                }
            }
            request.setAttribute("groups", groups);

            // 알림 조회
            String alertQuery = "SELECT gu.user_id, u.name, g.title, g.id " +
                    "FROM GroupUser gu " +
                    "JOIN group_table g ON gu.group_table_id = g.id " +  // group_id -> group_table_id
                    "JOIN User u ON gu.user_id = u.id " +
                    "WHERE g.id IN ( " +
                    "    SELECT gu_inner.group_table_id " +  // group_id -> group_table_id
                    "    FROM GroupUser gu_inner" +
                    "    WHERE gu_inner.user_id = ? AND gu_inner.statement = '방장' " +
                    ") " +
                    "AND gu.statement = '가입대기'";
            List<Alert> alerts = new ArrayList<>();
            try (PreparedStatement alertStmt = conn.prepareStatement(alertQuery)) {
                alertStmt.setLong(1, userId);
                try (ResultSet rs = alertStmt.executeQuery()) {
                    while (rs.next()) {
                        alerts.add(new Alert(
                                rs.getLong("user_id"),
                                rs.getString("name"),
                                rs.getString("title"),
                                rs.getLong("id")
                        ));
                    }
                }
            }
            request.setAttribute("alerts", alerts);

            // JSP로 포워드
            request.getRequestDispatcher("/mypage.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
