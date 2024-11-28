<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<!DOCTYPE html>
<html>
<head>
  <title>그룹 수정</title>
</head>
<body>
<h1>그룹 수정</h1>
<%
  Group group = (Group) request.getAttribute("group");
  if (group != null) {
%>
<form method="POST" action="<%= request.getContextPath() %>/groupUpdate">
  <input type="hidden" name="id" value="<%= group.getId() %>">
  <label>제목:</label>
  <input type="text" name="title" value="<%= group.getTitle() %>" required><br>

  <label>카테고리:</label>
  <input type="text" name="category" value="<%= group.getCategory() %>" required><br>

  <label>설명:</label>
  <textarea name="description" required><%= group.getDescription() %></textarea><br>

  <label>이미지 URL:</label>
  <input type="text" name="imageUrl" value="<%= group.getImageUrl() %>"><br>

  <label>최대 인원:</label>
  <input type="number" name="maxMembers" value="<%= group.getMaxMembers() %>" required><br>

  <button type="submit">저장</button>
</form>
<%
} else {
%>
<p>그룹 정보를 찾을 수 없습니다.</p>
<%
  }
%>
</body>
</html>
