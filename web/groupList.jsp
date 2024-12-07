<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, width=device-width">
	<title>그룹 목록</title>
	<link rel="stylesheet" href="./global.css" />
	<link rel="stylesheet" href="./groupList.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@400&display=swap" />
</head>
<body>
<%
	List<Group> groups = (List<Group>) request.getAttribute("groups");
%>
<div class="div">
	<div class="header">
		<div class="container">
			<a href="webp/main">
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
	<div class="section-group">
		<div class="category-name">최근 모임</div>
		<%
			int groupCnt = 0;
			for (Group group : groups) {
				if (groupCnt % 4 == 0) {
		%>
		<div class="card-set">
			<%
				}
			%>
			<a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>">
				<div class="card">
					<div class="image-area">
						<img src="<%= group.getImageUrl() %>" alt="" class="card-image">
					</div>
					<div class="info-area">
						<div class="meeting-name"><%= group.getTitle() %></div>
						<div class="member-status">
							<img class="icon-people" alt="" src="media/icon-people.png">
							<div class="member-status-text"><%= group.getCurrentMembers() %>/<%= group.getMaxMembers() %></div>
						</div>
						<div class="meeting-time">
							<%
								int dayCnt = 0;
								List<Day> days = group.getDays();
								for (Day day : days) {
									if (dayCnt != 0) {
							%>
							,&nbsp;
							<%
								}
							%>
							<%= day.getDay() %>&nbsp;<%= day.getStartTime() %>~<%= day.getEndTime() %>
							<%
									dayCnt++;
								}
							%>
						</div>
					</div>
					<div class="tag-area">
						<%
							List<Category> categories = group.getCategories();
							if (categories != null && !categories.isEmpty()) {
								for (Category category : categories) {
						%>
						<div class="tag">
							<div class="tag-box" style="background-color:<%= getCategoryColor(category.getCategoryName()) %>">
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
				</div>	<!-- card -->
			</a>
			<%
				groupCnt++;
				if (groupCnt % 4 == 0) {
			%>
		</div>
		<%
				}
			}
		%>
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
