<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
	<title>그룹 목록</title>
	<style>
		table {
			width: 100%;
			border-collapse: collapse;
		}
		th, td {
			border: 1px solid #ccc;
			padding: 8px;
			text-align: left;
		}
		th {
			background-color: #f2f2f2;
		}
	</style>
</head>
<body>
<h1>그룹 목록</h1>
<table>
	<thead>
	<tr>
		<th>ID</th>
		<th>제목</th>
		<th>카테고리</th>
		<th>설명</th>
		<th>이미지</th>
		<th>최대 인원</th>
		<th>현재 인원</th>
	</tr>
	</thead>
	<tbody>
	<%
		List<Group> groups = (List<Group>) request.getAttribute("groups");
		if (groups != null) {
			for (Group group : groups) {
	%>
	<tr>
		<td><%= group.getId() %></td>
		<td><a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>"><%= group.getTitle() %></a></td>
		<td><%= group.getCategory() %></td>
		<td><%= group.getDescription() %></td>
		<td><img src="<%= group.getImageUrl() %>" alt="그룹 이미지" style="width:100px;"></td>
		<td><%= group.getMaxMembers() %></td>
		<td><%= group.getCurrentMembers() %></td>
	</tr>
	<%
		}
	} else {
	%>
	<tr>
		<td colspan="7">등록된 그룹이 없습니다.</td>
	</tr>
	<%
		}
	%>
	</tbody>
</table>
</body>
</html>
