<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Day" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>그룹 상세</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/groupPage.css">
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
                        <a href="<%= request.getContextPath() %>/user/mypage">
                            <img class="icon-profile" alt="" src="<%= request.getContextPath() %>/media/icon-profile.png">
                        </a>
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
            Long sessionUserId = (Long) session.getAttribute("userId");
            Long leaderUserId = (Long) request.getAttribute("leaderUserId");
            String statement = (String) request.getAttribute("statement"); // statement 값 가져오기

            if (group != null) {
        %>
        <div class="intro">
            <div class="intro-text"><%= group.getTitle() %></div>
        </div>
        <div class="member-status">
            <img class="icon-people" alt="" src="<%= request.getContextPath() %>/media/icon-people.png">
            <div class="member-status-text"><%= group.getCurrentMembers() %>/<%= group.getMaxMembers() %></div>
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
                }
            %>
        </div>
        <div class="section-time">
            <div class="time-text">모임 시간</div>
            <%
                List<Day> days = group.getDays();
                if (days != null && !days.isEmpty()) {
                    for (Day day : days) {
            %>
            <div class="meeting">
                <div class="date"><%= day.getDay() %></div>
                <div class="time"><%= day.getStartTime() %>~<%= day.getEndTime() %></div>
            </div>
            <%
                    }
                }
            %>
        </div>
        <div class="member-info">
            <div class="member-text">구성원</div>
            <table class="member">
                <tbody>
                <%
                    if (users != null && !users.isEmpty()) {
                        for (User user : users) {
                %>
                <tr>
                    <td class="leader-icon">
                        <%
                            if (leaderUserId != null && leaderUserId.equals(user.getId())) {
                        %>
                        <img src="<%= request.getContextPath() %>/media/icon-leader.png" alt="" width="25px" height="25px">
                        <%
                            }
                        %>
                    </td>
                    <td class="user-icon"><img src="<%= request.getContextPath() %>/media/icon-User.png" alt="" width="30px" height="30px"></td>
                    <td class="user-name"><%= user.getName() %></td>
                    <td class="major">컴퓨터공학과</td> <!-- 수정 필요 -->
                    <td class="grade">3학년</td> <!-- 수정 필요 -->
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5">구성원이 없습니다.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <div class="details">
            <div class="detail-text">모임 설명</div>
            <div class="meeting-detail">
                <%= group.getDescription() %>
            </div>
        </div>
        <%
            if ("방장".equals(statement)) {
        %>
        <div class="box-button">
            <a href="<%= request.getContextPath() %>/groupEdit?id=<%= group.getId() %>" class="submitbox">수정</a>
            <a href="<%= request.getContextPath() %>/groupDelete?id=<%= group.getId() %>" class="submitbox"
               onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        </div>
        <%
        } else if ("회원".equals(statement)) {
        %>
        <div class="box-button">
            <button class="submitbox" disabled>참여 중</button>
        </div>
        <%
        } else if ("가입대기".equals(statement)) {
        %>
        <div class="box-button">
            <button class="submitbox" disabled>대기 중</button>
        </div>
        <%
        } else {
        %>
        <div class="box-button">
            <form method="POST" action="<%= request.getContextPath() %>/groupJoin">
                <input type="hidden" name="id" value="<%= group.getId() %>">
                <button type="submit" class="submitbox">가입 신청</button>
            </form>
        </div>
        <%
            }
        } else {
        %>
        <p>그룹 정보를 찾을 수 없습니다.</p>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
