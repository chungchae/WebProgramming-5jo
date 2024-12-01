<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Day" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>그룹 상세</title>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/global.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/groupPage.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
<div class="div">
    <div class="header">
        <div class="container">
            <a href="<%= request.getContextPath() %>/main">
                <div class="web-logo">
                    <img class="logo" alt="" src="<%= request.getContextPath() %>/media/Icon.svg">
                    <div class="logo-text">Project</div>
                </div>
            </a>
            <div class="nav">
                <div class="haeding-name">
                    <div class="nav-component">
                        <div class="label"><a href="<%= request.getContextPath() %>/groupCreate.jsp">새 모임 만들기</a></div>
                    </div>
                    <div class="nav-component">
                        <div class="label"><a href="<%= request.getContextPath() %>/main">모임 둘러보기</a></div>
                    </div>
                    <div class="nav-component">
                        <div class="label"><a href="<%= request.getContextPath() %>/user/mypage">마이페이지</a></div>
                    </div>
                    <div class="nav-component logout">
                        <a href="<%= request.getContextPath() %>/user/logout"><div class="label">로그아웃</div></a>
                    </div>
                    <div class="nav-component">
                        <a href="<%= request.getContextPath() %>/user/mypage"><img class="icon-profile" alt="" src="<%= request.getContextPath() %>/media/icon-profile.png"></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="background-image-area"></div>
    <div class="background-under-area"></div>
    <div class="background">
        <%
            Group group = (Group) request.getAttribute("group");
            List<User> users = (List<User>) request.getAttribute("users");
            List<String> categories = (List<String>) request.getAttribute("categories");
        %>
        <div class="intro">
            <div class="intro-text"><%= group != null ? group.getTitle() : "모임 정보 없음" %></div>
        </div>
        <div class="member-status">
            <img class="icon-people" alt="" src="<%= request.getContextPath() %>/media/icon-people.png">
            <div class="member-status-text"><%= group != null ? group.getCurrentMembers() + "/" + group.getMaxMembers() : "N/A" %></div>
        </div>
        <div class="section-tag">
            <%
                if (categories != null && !categories.isEmpty()) {
                    for (String category : categories) {
            %>
            <div class="tag">
                <div class="tag-box" style="background-color:#e9e587">
                    <div class="tag-text"><%= category %></div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="tag">카테고리가 없습니다.</div>
            <%
                }
            %>
        </div>
        <div class="section-time">
            <div class="time-text">모임 시간</div>
            <%
                List<Day> days = group != null ? group.getDays() : null;
                if (days != null && !days.isEmpty()) {
                    for (Day day : days) {
            %>
            <div class="meeting">
                <div class="date"><%= day.getDay() %></div>
                <div class="time"><%= day.getStartTime() %>~<%= day.getEndTime() %></div>
            </div>
            <%
                }
            } else {
            %>
            <div class="meeting">운영 시간 정보가 없습니다.</div>
            <%
                }
            %>
        </div>
        <div class="member-info">
            <div class="member-text">구성원</div>
            <table class="member">
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
        </div>
        <div class="details">
            <div class="detail-text">모임 설명</div>
            <div class="meeting-detail"><%= group != null ? group.getDescription() : "설명 없음" %></div>
        </div>
        <div class="box-button">
            <a href="<%= request.getContextPath() %>/main"><input type="button" value="메인으로 이동" class="submitbox"></a>
        </div>
    </div>
</div>
</body>
</html>
