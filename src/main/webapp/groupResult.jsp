<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>검색 결과</title>
</head>
<body>
<h1>검색 결과</h1>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Category</th>
        <th>Description</th>
        <th>Max Members</th>
        <th>Current Members</th>
    </tr>
    <%
        List<Group> groups = (List<Group>) request.getAttribute("groups");
        if (groups != null) {
            for (Group group : groups) {
    %>
    <tr>
        <td><%= group.getId() %></td>
        <td><%= group.getTitle() %></td>
        <td><%= group.getCategory() %></td>
        <td><%= group.getDescription() %></td>
        <td><%= group.getMaxMembers() %></td>
        <td><%= group.getCurrentMembers() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6">결과 없음</td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
