package org.example;



import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/api/user/signup")
public class UserSignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String email = request.getParameter("email");
        String emailDomain = request.getParameter("emailDomain");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String name = request.getParameter("name");
        String univ = request.getParameter("univ");
        String major = request.getParameter("major");
        String hobby = request.getParameter("hobby");
        String introduction = request.getParameter("introduction");

        String fullEmail = email + "@" + emailDomain;

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 비밀번호 확인
        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            // 아이디 중복 체크
            String checkSql = "SELECT COUNT(*) FROM User WHERE email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, fullEmail);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                    out.println("<script>alert('이미 사용 중인 이메일입니다. 다른 이메일을 사용해주세요.'); history.back();</script>");
                    return;
                }
            }

            // 회원가입 처리
            String sql = "INSERT INTO User (email, password, name, univ, major, hobby, introduction) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, fullEmail);
                pstmt.setString(2, password);
                pstmt.setString(3, name);
                pstmt.setString(4, univ);
                pstmt.setString(5, major);
                pstmt.setString(6, hobby);
                pstmt.setString(7, introduction);

                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='signup.jsp';</script>");
                } else {
                    out.println("<script>alert('회원가입에 실패하였습니다. 다시 시도해주세요.'); history.back();</script>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('서버 오류 발생. 다시 시도해주세요.'); history.back();</script>");
        }
    }

}
