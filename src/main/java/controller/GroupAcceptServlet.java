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

@WebServlet("/group/accept")
public class GroupAcceptServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 파라미터에서 groupId와 userId 가져오기
        String groupIdParam = request.getParameter("groupId");
        String userIdParam = request.getParameter("userId");

        // groupId와 userId가 제공되지 않은 경우 처리
        if (groupIdParam == null || userIdParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid request parameters.");
            return;
        }

        Long groupId = Long.parseLong(groupIdParam);
        Long userId = Long.parseLong(userIdParam);

        // 현재 로그인한 사용자의 ID 가져오기
        HttpSession session = request.getSession();
        Long currentUserId = (Long) session.getAttribute("userId");

        if (currentUserId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in.");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // 1. 현재 로그인한 사용자가 방장인지 확인
            String checkAdminQuery = "SELECT 1 FROM GroupUser " +
                    "WHERE user_id = ? AND group_table_id = ? AND statement = '방장'";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkAdminQuery)) {
                checkStmt.setLong(1, currentUserId);
                checkStmt.setLong(2, groupId);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (!rs.next()) {
                        // 방장이 아니라면 처리 중단
                        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        response.getWriter().write("You are not the admin of this group.");
                        return;
                    }
                }
            }

            // 2. GroupUser 테이블에서 신청자의 상태를 "회원"으로 업데이트
            String updateQuery = "UPDATE GroupUser SET statement = '회원' " +
                    "WHERE group_table_id = ? AND user_id = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                updateStmt.setLong(1, groupId);
                updateStmt.setLong(2, userId);

                int rowsUpdated = updateStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().println("<script> location.href='/user/mypage';</script>");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().println("<script> location.href='/user/mypage';</script>");
                }
            }

            String updateGroupQuery = "UPDATE group_table SET current_members = current_members + 1 " +
                    "WHERE id = ?";
            try (PreparedStatement updateGroupStmt = conn.prepareStatement(updateGroupQuery)) {
                updateGroupStmt.setLong(1, groupId);

                int rowsUpdated = updateGroupStmt.executeUpdate();
                if (rowsUpdated == 0) {
                    // 업데이트 실패 시 롤백
                    conn.rollback();
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Failed to update group current_members.");
                    return;
                }
            }

            conn.commit();
            response.getWriter().write("User successfully added to the group, and current_members updated.");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred while processing the request.");
        }
    }
}
