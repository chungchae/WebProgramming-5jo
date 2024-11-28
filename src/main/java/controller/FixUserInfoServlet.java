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

@WebServlet("/user")
public class FixUserInfoServlet extends HttpServlet {


        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");

            // Session에서 현재 로그인된 사용자 ID 가져오기
            HttpSession session = request.getSession();
            Long userId = (Long) session.getAttribute("userId");

            if (userId == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("<script>alert('로그인이 필요합니다.'); location.href='/login.jsp';</script>");
                return;
            }

            // 요청에서 파라미터 가져오기
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String univ = request.getParameter("univ");
            String major = request.getParameter("major");
            String grade = request.getParameter("grade");
            String hobby = request.getParameter("hobby");
            String introduction = request.getParameter("introduction");

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            

            try (Connection conn = DBConnection.getConnection()) {
                // 회원정보 업데이트 쿼리
                String updateSql = "UPDATE User SET email = ?, password = ?, univ = ?, major = ?, grade = ?, year = ?, hobby = ?, introduction = ? WHERE id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                    pstmt.setString(1, email);
                    pstmt.setString(2, password);
                    pstmt.setString(3, univ);
                    pstmt.setString(4, major);
                    pstmt.setString(5, grade);
                    pstmt.setString(7, hobby);
                    pstmt.setString(8, introduction);
                    pstmt.setLong(9, userId);

                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<script>alert('회원정보가 성공적으로 수정되었습니다.'); location.href='/mypage.jsp';</script>");
                    } else {
                        out.println("<script>alert('회원정보 수정에 실패하였습니다. 다시 시도해주세요.'); history.back();</script>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('서버 오류 발생. 다시 시도해주세요.'); history.back();</script>");
            }
        }


    }


