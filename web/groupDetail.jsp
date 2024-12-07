<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, width=device-width">
	<link rel="stylesheet" href="global.css" />
	<link rel="stylesheet" href="groupPage.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@400&display=swap" />
</head>
<body>
<%
	Group group = (Group) request.getAttribute("group");
	List<Category> categories = group.getCategories(); // 그룹에 연결된 카테고리
	List<User> users = (List<User>) request.getAttribute("users");
	List<Day> meetingDays = group.getDays();

	// 그룹 기본 정보
	String title = group.getTitle();
	String description = group.getDescription();
	String imgUrl = group.getImageUrl();
	int maxMembers = group.getMaxMembers();
	int currentMembers = group.getCurrentMembers();
%>
<div class="div">
	<div class="header">
		<div class="container">
			<a href="/main">
				<div class="web-logo">
					<img class="logo" alt="" src="media/Icon.svg">
					<div class="logo-text">Project</div>
				</div></a>
			<div class="nav">
				<div class="haeding-name">
					<div class="nav-component">
						<div class="label"><a href="/groupCreate">새 모임 만들기</a></div>
					</div>
					<div class="nav-component">
						<div class="label"><a href="/main">모임 둘러보기</a></div>
					</div>
					<div class="nav-component">
						<div class="label"><a href="/user/mypage">마이페이지</a></div>
					</div>
					<div class="nav-component logout">
						<a href="/user/logout"><div class="label">로그아웃</div></a>
					</div>
					<div class="nav-component">
						<a href="/user/mypage"><img class="icon-profile" alt="" src="media/icon-profile.png"></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="background-image-area" style="background-image: url('<%= imgUrl != null ? imgUrl : "media/default-group.png" %>');"></div>
	<div class="background-under-area"></div>
	<div class="background">
		<div class="intro">
			<div class="intro-text"><%= title %></div>
		</div>
		<div class="member-status">
			<img class="icon-people" alt="" src="media/icon-people.png">
			<div class="member-status-text"><%= currentMembers %>/<%= maxMembers %></div>
		</div>
		<div class="section-tag">
			<%
				if (categories != null && !categories.isEmpty()) {
					for (Category category : categories) {
			%>
			<div class="tag">
				<div class="tag-box" style="background-color: <%= getCategoryColor(category.getCategoryName()) %>;">
					<div class="tag-text"><%= category.getCategoryName() %></div>
				</div>
			</div>
			<%
				}
			} else {
			%>
			<div class="tag">
				<div class="tag-box" style="background-color: grey;">
					<div class="tag-text">카테고리 없음</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div class="section-time">
			<%
				if (meetingDays != null && !meetingDays.isEmpty()) {
					int dayCnt = 0;
					for (Day day : meetingDays) {
						if (dayCnt == 0) {
			%>
			<div class="time-text">모임 시간</div>
			<%
			} else {
			%>
			<div class="time-text"></div>
			<%
				}
			%>
			<div class="meeting">
				<div class="date"><%= day.getDay() %></div>
				<div class="time"><%= day.getStartTime() %>~<%= day.getEndTime() %></div>
			</div>
			<%
					dayCnt++;
				}
			} else {
			%>
			<div class="time-text">모임 시간이 등록되지 않았습니다.</div>
			<%
				}
			%>
		</div>
		<div class="member-info">
			<div class="member-text">구성원</div>
			<table class="member">
				<%
					if (users != null && !users.isEmpty()) {
						int i = 0;
						for (User user : users) {
				%>
				<tr>
					<%
						if (i == 0) { // 첫 번째 유저를 리더로 표시
					%>
					<td class="leader-icon"><img src="media/leader.png" alt="" width="25px" height="25px"></td>
					<%
					} else {
					%>
					<td class="leader-icon"></td>
					<%
						}
					%>
					<td class="user-icon"><img src="media/icon-User.png" alt="" width="30px" height="30px"></td>
					<td class="user-name"><%= user.getName() %></td>
					<td class="major"><%= user.getMajor() %></td>
					<td class="grade"><%= user.getGrade() %>학년</td>
				</tr>
				<%
						i++;
					}
				} else {
				%>
				<tr>
					<td colspan="5">구성원이 없습니다.</td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<div class="details">
			<div class="detail-text">모임 설명</div>
			<div class="meeting-detail">
				<%= description %>
			</div>
		</div>
		<form class="box-button" action="/groupJoin" method="post">
			<input type="hidden" value="<%= group.getId() %>" name="groupId">
			<input type="submit" value="모임 가입하기" class="submitbox">
		</form>
	</div>
</div>
</body>
</html>
<%!
	private String getCategoryColor(String category) {
		switch (category) {
			case "토론": return "#e9e587";
			case "공부": return "#87b6e9";
			case "언어": return "#e98787";
			case "자유": return "#cecece";
			case "운동": return "#8be3f4";
			case "취미": return "#87e9ba";
			default: return "grey";
		}
	}
%>
