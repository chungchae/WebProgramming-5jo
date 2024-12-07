<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <link rel="stylesheet" href="./global.css"/>
    <link rel="stylesheet" href="./mypage.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
    <script src="/mypage.js"></script>

</head>
<body>
<%
    User user = (User) request.getAttribute("user");
    List<Group> groups = (List<Group>) request.getAttribute("groups");
    List<Alert> alerts = (List<Alert>) request.getAttribute("alerts");
%>
<div class="div">
    <div class="header">
        <div class="container">
            <a href="/main">
                <div class="web-logo">
                    <img class="logo" alt="" src="media/Icon.svg">
                    <div class="logo-text">Project</div>
                </div>
            </a>
            <div class="nav">
                <div class="haeding-name">
                    <div class="nav-component">
                        <div class="label"><a href="/groupCreate.jsp">새 모임 만들기</a></div>
                    </div>
                    <div class="nav-component">
                        <div class="label"><a href="/main">모임 둘러보기</a></div>
                    </div>
                    <div class="nav-component">
                        <div class="label"><a href="/user/mypage">마이페이지</a></div>
                    </div>
                    <div class="nav-component" class="logout">
                        <a href="/user/logout"><div class="label">로그아웃</div></a>
                    </div>
                    <div class="nav-component">
                        <a href="/user/mypage"><img class="icon-profile" alt="" src="/media/icon-profile.png"></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="section-profile">
        <% if (user != null) { %>
        <table id="profile">
            <tr>
                <td colspan="2" class="blank"><div id="button-box-modify"><button type="button" id="button-modify" onclick="modalOpen()">수정</button></div></td>
            </tr>
            <tr>
                <td rowspan="3"><div id="profile-image"></div></td>
                <td id="name"><%= user.getName() %></td>
            </tr>
            <tr>
                <td id="affiliation"> <%= user.getMajor() %> <%= user.getIntroduction() %> <%= user.getGrade() %>학년</td>
            </tr>
            <tr>
                <td id="self-introduction"><%= user.getEmail() %></td>
            </tr>
            <tr>
                <td colspan="2" class="blank"></td>
            </tr>
        </table>
        <% } else { %>
        <p>사용자 정보가 없습니다.</p>
        <% } %>
    </div>

    <div class="section-meeting">
        <div class="section-title">가입된 모임</div>
        <% if (groups != null && !groups.isEmpty()) { %>
        <% for (Group group : groups) { %>
        <div class="card">
            <div class="info-area">
                <div class="meeting-name"><%= group.getTitle() %></div>
                <div><%= group.getCategory()%></div>
                <div class="meeting-time">\
           <%
           		List<Day> days = group.getDays();
           		int dayCnt = 0;
           		for (Day day: days) {
           			if (dayCnt != 0) {
           %>
           				,&nbsp;
           <%
           			}
           %>
           			<%=day.getDay() %>&nbsp;<%=day.getStartTime() %>~<%=day.getEndTime() %>
           <%
           		dayCnt++;
           		}
           %>
                </div>
            </div>
            <div class="button-area">
                <form class="button-box-withdrawal" method="post" action="/group/leave">
                    <input type="hidden" name="groupId" value="<%=group.getId() %>">
                    <button type="submit" class="withdrawal">탈퇴</button>
                </form>
            </div>
        </div>

        <% } %>
        <% } else { %>
        <p>가입된 모임이 없습니다.</p>
        <% } %>
    </div>

    <div class="section-notice">
        <div class="section-title">알림</div>
        <% if (alerts != null && !alerts.isEmpty()) { %>
        <% for (Alert alert : alerts) { %>
        <div class="notice-line">
            <div class="notice-content">
                <%= alert.getUserName() %> 님이 <%= alert.getGroupTitle() %> 모임에 가입을 신청했습니다.
            </div>
            <form class="button-box-accept" action="/group/accept" method="post">
                <input type="hidden" value="<%= alert.getUserId() %>" name="userId">
                <input type="hidden" value="<%= alert.getGroupId() %>" name="groupId">
                <button type="submit" class="accept">수락</button>
            </form>
            <form class="button-box-reject" action="/group/reject" method="post">
                <input type="hidden" value="<%= alert.getUserId() %>" name="userId">
                <input type="hidden" value="<%= alert.getGroupId() %>" name="groupId">
                <button type="submit" class="reject">거절</button>
            </form>
        </div>
        <% } %>
        <% } else { %>
        <p>알림이 없습니다.</p>
        <% } %>
    </div>


    <div id="modalContainer" class="hidden">
        <div id="wrapper">
            <button id="modalCloseButton" onclick="modalClose()"></button>
            <div id="modalContent">
                <div id="modal-title">회원정보 수정</div>
                <form method="post" action="/user">
                    <div class="input-field">
                        <div class="input-kind">이름</div>
                        <div class="box">
                            <input type="text" name="name" class="inputbox" value=<%=user.getName() %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">이메일</div>
                        <div class="box">
                            <input type="email" name="email" class="inputbox" value=<%=user.getPassword() %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">비밀번호</div>
                        <div class="box">
                            <input type="password" name="password" class="inputbox" value=<%=user.getUniv() %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">대학교</div>
                        <div class="box">
                            <input type="text" name="univ" class="inputbox" value=<%=user.getMajor() %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">전공</div>
                        <div class="box">
                            <input type="text" name="major" id="major" class="inputbox" value=<%=user.getIntroduction() %>>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">학년</div>
                        <div class="box">
                            <select name="grade" class="inputbox">
                                <option value="1">1학년</option>
                                <option value="2">2학년</option>
                                <option value="3">3학년</option>
                                <option value="4">4학년</option>
                            </select>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">취미</div>
                        <div class="box">
                            <input type="text" name="hobby" class="inputbox" value=<%=user.getHobby() %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">자기소개</div>
                        <div class="box-large">
                            <textarea name="introduction" class="textbox" required><%=user.getEmail() %></textarea>
                        </div>
                    </div>

                    <div class="submit-field">
                        <div class="button" action="/user" method="post">
                            <input type="submit" name="signup" value="정보수정" class="submit"></div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <script>
        const grade = document.getElementById("grade");
        grade.value ="<%=user.getGrade()%>"
    </script>

</body>
</html>
