package controller;


import db.DBConnection;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/user/mypage")
public class UserMyPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 세션에서 userId와 email 가져오기
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");
        String email = (String) session.getAttribute("email");

        if (userId == null) {
            // 세션에 userId가 없으면 로그인 페이지로 리다이렉트
            response.sendRedirect("/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            JSONObject responseData = new JSONObject();

            // 사용자 정보 조회
            String userQuery = "SELECT * FROM User WHERE email = ?";
            try (PreparedStatement userStmt = conn.prepareStatement(userQuery)) {
                userStmt.setString(1, email);
                try (ResultSet userRs = userStmt.executeQuery()) {
                    if (userRs.next()) {
                        responseData.put("id", userRs.getLong("id"));
                        responseData.put("name", userRs.getString("name"));
                        responseData.put("password", userRs.getString("password"));
                        responseData.put("univ", userRs.getString("univ"));
                        responseData.put("major", userRs.getString("major"));
                        responseData.put("introduction", userRs.getString("introduction"));
                        responseData.put("grade", userRs.getString("grade"));
                        responseData.put("email", userRs.getString("email"));
                        responseData.put("hobby", userRs.getString("hobby"));
                    }
                }
            }



            // 사용자가 가입한 모임 정보 조회
            String groupQuery = "SELECT g.id, g.title, g.image_url FROM GroupUser gu " +
                    "JOIN group_table g ON gu.group_table_id = g.id WHERE gu.user_id = ?";
            JSONArray groupsArray = new JSONArray();
            try (PreparedStatement groupStmt = conn.prepareStatement(groupQuery)) {
                groupStmt.setLong(1, userId);
                try (ResultSet groupRs = groupStmt.executeQuery()) {
                    while (groupRs.next()) {
                        JSONObject groupData = new JSONObject();
                        groupData.put("id", groupRs.getLong("id"));
                        groupData.put("title", groupRs.getString("title"));
                        groupData.put("image_url", groupRs.getString("image_url"));
                        groupsArray.add(groupData);
                    }
                }
            }
            responseData.put("groups", groupsArray);

            // 사용자가 방장인 그룹에 대한 가입 신청 알림 조회
            String alertQuery = "SELECT gu.user_id, u.name, g.title, g.id " +
                    "FROM GroupUser gu " +
                    "JOIN group_table g ON gu.group_id = g.id " +
                    "JOIN User u ON gu.user_id = u.id " +
                    "WHERE g.id IN ( " +
                    "    SELECT gu_inner.group_id " +
                    "    FROM GroupUser gu_inner " +
                    "    WHERE gu_inner.user_id = ? AND gu_inner.statement = '방장' " +
                    ") " +
                    "AND gu.statement = '가입대기'";
            JSONArray alertsArray = new JSONArray();
            try (PreparedStatement alertStmt = conn.prepareStatement(alertQuery)) {
                alertStmt.setLong(1, userId);
                try (ResultSet alertRs = alertStmt.executeQuery()) {
                    while (alertRs.next()) {
                        JSONObject alertData = new JSONObject();
                        alertData.put("user_id", alertRs.getLong("user_id"));
                        alertData.put("user_name", alertRs.getString("name"));
                        alertData.put("group_title", alertRs.getString("title"));
                        alertData.put("group_id", alertRs.getString("group_id"));
                        alertsArray.add(alertData);
                    }
                }
            }
            responseData.put("alerts", alertsArray);

            // JSON 응답 전송
            PrintWriter out = response.getWriter();
            out.print(responseData.toString());
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

}
