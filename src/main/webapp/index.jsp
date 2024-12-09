<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Group" %>
<%@ page import="model.Category" %>
<%@ page import="model.Day" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, width=device-width">
	<title>그룹 목록</title>
	<link rel="stylesheet" href="css/global.css" />
	<link rel="stylesheet" href="css/groupList.css?after" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@400&display=swap" />
</head>
<body>
<%
	String sessionEmail = (String) request.getAttribute("email");
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
				<div class="nav-component">
					<div class="label"><a href="/groupCreate.jsp">새 모임 만들기</a></div>
				</div>
				<div class="nav-component">
					<div class="label"><a href="/main">모임 둘러보기</a></div>
				</div>
				<div class="nav-component">
					<div class="label"><a href="/user/mypage">마이페이지</a></div>
				</div>
				<%
					if(sessionEmail==null){
				%>
				<div class="nav-component">
					<a href="/login.jsp"><div class="label">로그인</div></a>
				</div>
				<%
					}
				%>
				<%
					if(sessionEmail!=null){
				%>
				<div class="nav-component">
					<a href="/user/logout"><div class="label">로그아웃</div></a>
				</div>
				<%
					}
				%>
				<div class="nav-component">
					<a href="/user/mypage"><img class="icon-profile" alt="" src="media/icon-profile.png"></a>
				</div>
			</div>
		</div>
	</div>
	<div class="search-group">
		<div class="search-box">
			<form method="get" action="<%= request.getContextPath() %>/groupSearch">
				<input type="text" name="search" id="search" placeholder="모임을 검색해보세요!" />
				<input type="submit" id="button-search" value="" />
			</form>
		</div>
	</div>
	<div class="groups-container">
		<h2 style="width: 100%; margin-left: 50px;">최신 그룹 <a href="/groupList"><img class="icon-plus" src="/media/icon-plus.png" alt=""></a></h2>


		<div class="group-container">
			<%
				List<Group> latestGroups = (List<Group>) request.getAttribute("latestGroups");
				if (latestGroups != null && !latestGroups.isEmpty()) {
					int groupCnt = 0;
					for (Group group : latestGroups) {
			%>
			<a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>" class="card">
				<div class="image-area">
					<img src="media/<%= group.getImageUrl() != null ? "group" + group.getId() + ".png" : "/placeholder.png" %>" alt="" class="card-image">
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
			</a>
			<%
				groupCnt++;
				if (groupCnt % 4 == 0) {
			%>
			<div style="clear:both;"></div>
			<%
					}
				}
			} else {
			%>
			<p class="no-groups">등록된 최신 그룹이 없습니다.</p>
			<%
				}
			%>
		</div>

		<h2 style="width: 100%; margin-left: 50px;">운동 그룹</h2>
		<div class="group-container" style="margin-bottom: 40px;">
			<%
				List<Group> exerciseGroups = (List<Group>) request.getAttribute("exerciseGroups");
				if (exerciseGroups != null && !exerciseGroups.isEmpty()) {
					int groupCnt = 0;
					for (Group group : exerciseGroups) {
			%>
			<a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>" class="card">
				<div class="image-area">
					<img src="media/<%= group.getImageUrl() != null ? "group" + group.getId() + ".png" : "/placeholder.png" %>" alt="" class="card-image">
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
			</a>
			<%
				groupCnt++;
				if (groupCnt % 4 == 0) {
			%>
			<div style="clear:both;"></div>
			<%
					}
				}
			} else {
			%>
			<p class="no-groups">등록된 최신 그룹이 없습니다.</p>
			<%
				}
			%>
		</div>

		<h2 style="width: 100%; margin-left: 50px;">공부 그룹</h2>
		<div class="group-container" style="margin-bottom: 40px;">
			<%
				List<Group> studyGroups = (List<Group>) request.getAttribute("studyGroups");
				if (studyGroups != null && !studyGroups.isEmpty()) {
					int groupCnt = 0;
					for (Group group : studyGroups) {
			%>
			<a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>" class="card">
				<div class="image-area">
					<img src="media/<%= group.getImageUrl() != null ? "group" + group.getId() + ".png" : "/placeholder.png" %>" alt="" class="card-image">
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
			</a>
			<%
				groupCnt++;
				if (groupCnt % 4 == 0) {
			%>
			<div style="clear:both;"></div>
			<%
					}
				}
			} else {
			%>
			<p class="no-groups">등록된 최신 그룹이 없습니다.</p>
			<%
				}
			%>
		</div>
	</div>
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
</body>
</html>
