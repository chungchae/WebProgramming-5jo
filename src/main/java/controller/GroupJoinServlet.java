package controller;


import db.DBConnection;

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

@WebServlet("/groupJoin")
public class GroupJoinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int groupId = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");
        String email = (String) session.getAttribute("email");

        try (Connection conn = DBConnection.getConnection()) {
            // Step 1: 이미 그룹에 가입되었는지 확인
            String checkQuery = "SELECT COUNT(*) FROM GroupUser WHERE user_id = ? AND group_table_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setLong(1, userId);
                checkStmt.setLong(2, groupId);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // 이미 그룹에 가입된 경우
                        response.setStatus(HttpServletResponse.SC_CONFLICT);
                        response.getWriter().write("이미 가입된 그룹입니다.");
                        return;
                    }
                }
            }

            // Step 2: 가입 신청 처리 (대기중으로 추가)
            String insertQuery = "INSERT INTO GroupUser (user_id, group_table_id, statement) VALUES (?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setLong(1, userId);
                insertStmt.setLong(2, groupId);
                insertStmt.setString(3, "가입대기");

                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("가입 신청이 완료되었습니다.");
                    request.getRequestDispatcher("/group.jsp").forward(request,response);
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("가입 신청 처리에 실패했습니다.");
                }
            }

        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("서버 오류: " + e.getMessage());
            e.printStackTrace();
        }



    }


}
