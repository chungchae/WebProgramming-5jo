package controller;

import db.DBConnection;

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

@WebServlet("/groupJoin")
public class GroupJoinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        // URL 파라미터에서 groupId를 가져오기
        String groupIdParam = request.getParameter("groupId");
        if (groupIdParam == null || groupIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("그룹 ID가 전달되지 않았습니다.");
            return;
        }

        int groupId;
        try {
            groupId = Integer.parseInt(groupIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("유효하지 않은 그룹 ID입니다.");
            return;
        }

        // 세션에서 사용자 ID 가져오기
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("로그인이 필요합니다.");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Step 1: 이미 그룹에 가입되었는지 확인
            String checkQuery = "SELECT COUNT(*) FROM GroupUser WHERE user_id = ? AND group_table_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setLong(1, userId);
                checkStmt.setInt(2, groupId);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // 이미 그룹에 가입된 경우
                        response.setStatus(HttpServletResponse.SC_CONFLICT);
                        request.setAttribute("message", "이미 가입된 그룹입니다.");
                        request.getRequestDispatcher("/groupDetail?id=" + groupId).forward(request, response);
                        return;
                    }
                }
            }

            // Step 2: 가입 신청 처리 (대기중으로 추가)
            String insertQuery = "INSERT INTO GroupUser (user_id, group_table_id, statement) VALUES (?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setLong(1, userId);
                insertStmt.setInt(2, groupId);
                insertStmt.setString(3, "가입대기");

                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    // 가입 신청 성공 시 리디렉션
                    out.println("<script>location.href='/user/mypage';</script>");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    request.setAttribute("message", "가입 신청 처리에 실패했습니다.");
                    request.getRequestDispatcher("/groupDetail?id=" + groupId).forward(request, response);
                }
            }

        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.setAttribute("message", "서버 오류: " + e.getMessage());
            request.getRequestDispatcher("/groupDetail?id=" + groupId).forward(request, response);
            e.printStackTrace();
        }
    }
}
