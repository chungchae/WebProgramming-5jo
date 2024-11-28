<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<!DOCTYPE html>
<html>
<head>
    <title>그룹 상세 정보</title>
</head>
<body>
<h1>그룹 상세 정보</h1>
<%
    Group group = (Group) request.getAttribute("group");
    if (group != null) {
%>
<p>ID: <%= group.getId() %></p>
<p>제목: <%= group.getTitle() %></p>
<p>카테고리: <%= group.getCategory() %></p>
<p>설명: <%= group.getDescription() %></p>
<p>이미지: <img src="<%= group.getImageUrl() %>" alt="그룹 이미지" style="width:200px;"></p>
<p>최대 인원: <%= group.getMaxMembers() %></p>
<p>현재 인원: <%= group.getCurrentMembers() %></p>

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
