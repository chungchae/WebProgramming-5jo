<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
  <title>DB Connection Test</title>
</head>
<body>
<h1>DB 연결 테스트</h1>
<%
  Connection conn = null;
  try {
    // db.DBConnection 클래스의 getConnection 메서드 호출
    conn = DBConnection.getConnection();
    out.println("<p>DB 연결 성공!</p>");
  } catch (Exception e) {
    out.println("<p>DB 연결 실패: " + e.getMessage() + "</p>");
  } finally {
    if (conn != null) {
      try {
        conn.close(); // 연결 종료
      } catch (SQLException e) {
        out.println("<p>DB 연결 종료 실패: " + e.getMessage() + "</p>");
      }
    }
  }
%>
</body>
</html>
