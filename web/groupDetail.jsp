<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Day" %>
<!DOCTYPE html>
<html>
<head>
    <title>그룹 상세</title>
</head>
<body>
<h1>그룹 상세2</h1>
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
<h2>운영 요일</h2>
<table>
    <thead>
    <tr>
        <th>요일</th>
        <th>시작 시간</th>
        <th>종료 시간</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Day> days = group.getDays();
        if (days != null && !days.isEmpty()) {
            for (Day day : days) {
    %>
    <tr>
        <td><%= day.getDay() %></td>
        <td><%= day.getStartTime() %></td>
        <td><%= day.getEndTime() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="3">운영 요일 정보가 없습니다.</td>
    </tr>
    <%
        }
    %>
    </tbody>
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
<a href="<%= request.getContextPath() %>/groupEdit?id=<%= group.getId() %>">수정</a> |
<a href="<%= request.getContextPath() %>/groupDelete?id=<%= group.getId() %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
<%
} else {
%>
<p>그룹 정보를 찾을 수 없습니다.</p>
<%
    }
%>
</body>
</html>
