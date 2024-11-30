<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Group" %>
<!DOCTYPE html>
<html>
<head>
    <title>메인 페이지</title>
    <style>
        .group-container {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
        }
        .group-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px;
            width: 200px;
            text-align: center;
        }
        .group-card img {
            width: 100%;
            height: 100px;
            object-fit: cover;
        }
        .group-card a {
            text-decoration: none;
            color: inherit;
        }
        .no-groups {
            font-size: 18px;
            color: #888;
        }
    </style>
</head>
<body>
<h1>메인 페이지</h1>

<h2>최신 그룹</h2>
<div class="group-container">
    <%
        List<Group> latestGroups = (List<Group>) request.getAttribute("latestGroups");
        if (latestGroups != null) {
            for (Group group : latestGroups) {
    %>
    <a href="groupDetail?id=<%= group.getId() %>" class="group-card">
        <img src="<%= group.getImageUrl() != null && !group.getImageUrl().isEmpty() ? group.getImageUrl() : "placeholder.jpg" %>" alt="그룹 이미지">
        <h3><%= group.getTitle() %></h3>
        <p><%= group.getCategory() %></p>
    </a>
    <%
        }
    } else {
    %>
    <p class="no-groups">등록된 최신 그룹이 없습니다.</p>
    <%
        }
    %>
</div>

<h2>운동 그룹</h2>
<div class="group-container">
    <%
        List<Group> exerciseGroups = (List<Group>) request.getAttribute("exerciseGroups");
        if (exerciseGroups != null && !exerciseGroups.isEmpty()) {
            for (Group group : exerciseGroups) {
    %>
    <a href="groupDetail?id=<%= group.getId() %>" class="group-card">
        <img src="<%= group.getImageUrl() != null && !group.getImageUrl().isEmpty() ? group.getImageUrl() : "placeholder.jpg" %>" alt="그룹 이미지">
        <h3><%= group.getTitle() %></h3>
        <p><%= group.getCategory() %></p>
    </a>
    <%
        }
    } else {
    %>
    <p class="no-groups">등록된 운동 그룹이 없습니다.</p>
    <%
        }
    %>
</div>

<h2>공부 그룹</h2>
<div class="group-container">
    <%
        List<Group> studyGroups = (List<Group>) request.getAttribute("studyGroups");
        if (studyGroups != null && !studyGroups.isEmpty()) {
            for (Group group : studyGroups) {
    %>
    <a href="groupDetail?id=<%= group.getId() %>" class="group-card">
        <img src="<%= group.getImageUrl() != null && !group.getImageUrl().isEmpty() ? group.getImageUrl() : "placeholder.jpg" %>" alt="그룹 이미지">
        <h3><%= group.getTitle() %></h3>
        <p><%= group.getCategory() %></p>
    </a>
    <%
        }
    } else {
    %>
    <p class="no-groups">등록된 공부 그룹이 없습니다.</p>
    <%
        }
    %>
</div>
</body>
</html>
