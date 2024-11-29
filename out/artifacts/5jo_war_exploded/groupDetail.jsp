<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>그룹 상세</title>
</head>
<body>
<h1>그룹 상세</h1>
<%
    Group group = (Group) request.getAttribute("group");
    List<User> users = (List<User>) request.getAttribute("users");

    if (group != null) {
%>
<table>
    <tr><td>ID:</td><td><%= group.getId() %></td></tr>
    <tr><td>제목:</td><td><%= group.getTitle() %></td></tr>
    <tr><td>카테고리:</td><td><%= group.getCategory() %></td></tr>
    <tr><td>설명:</td><td><%= group.getDescription() %></td></tr>
    <tr><td>최대 인원:</td><td><%= group.getMaxMembers() %></td></tr>
    <tr><td>현재 인원:</td><td><%= group.getCurrentMembers() %></td></tr>
</table>

<h2>소속된 사용자</h2>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>이름</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (users != null && !users.isEmpty()) {
            for (User user : users) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getName() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="2">소속된 사용자가 없습니다.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
} else {
%>
<p>그룹 정보를 찾을 수 없습니다.</p>
<%
    }
%>
</body>
</html>
