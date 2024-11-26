package org.example;

import jakarta.servlet.ServletException;


import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/api/user/login")
public class UserLoginServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        response.setContentType("text/html; charset=UTF-8");

        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT id, email, name, univ, major, introduction FROM User WHERE email = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // 로그인 성공
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getLong("id")); // 사용자 ID 저장
                session.setAttribute("email", rs.getString("email"));

                response.sendRedirect("mainpage.jsp");
            } else {
                // 로그인 실패
                response.getWriter().println("<script>alert('이메일 또는 비밀번호가 잘못되었습니다.'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('서버 오류 발생. 다시 시도해주세요.'); history.back();</script>");
        }

    }

}
