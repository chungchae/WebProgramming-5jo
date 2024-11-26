<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>모임 생성</title>
</head>
<body>
<h1>모임 생성</h1>
<form method="POST" action="<%= request.getContextPath() %>/groupCreate">
  <label>모임 이름:</label>
  <input type="text" name="title" required><br>

  <label>카테고리:</label>
  <input type="text" name="category" required><br>

  <label>모임 설명:</label>
  <textarea name="description" required></textarea><br>

  <label>이미지 URL:</label>
  <input type="text" name="imageUrl"><br>

  <label>최대 인원:</label>
  <input type="number" name="maxMembers" required><br>

  <button type="submit">생성</button>
</form>

<%
  String error = (String) request.getAttribute("error");
  if (error != null) {
%>
<p style="color: red;"><%= error %></p>
<%
  }
%>
</body>
</html>
