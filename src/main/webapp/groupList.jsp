<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
	
	<link rel="stylesheet"  href="./global.css" />
  	<link rel="stylesheet"  href="./groupList.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
<%
	List<Group> groups = (List<Group>) request.getAttribute("groups");
	String groupType = (String) request.getAttribute("groupType");	// 수정: 현재 조회 중인 모임의 종류 정보를 받아야야 합니다. (ex. 운동 모임, 공부 모임 ...)
	List<Day> days = new ArrayList<>();
	List<String> categories;
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
						<div class="nav-component" class="logout">
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
			<div class="category-name"><%=groupType %> 모임</div>
	<%
		int groupcnt = 0;
		for (Group group: groups) {
			categories = getCategories(group.getCategory());
			if (groupcnt % 4 == 0) {
	%>
			<div class="card-set">
	<% 
			}
	%>
			<a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>">
				<div class="card">
					<div class="image-area">
						<img src="<%=group.getImageUrl() %>" alt="" class="card-image">
					</div>
					<div class="info-area">
						<div class="meeting-name"><%=group.getTitle() %></div>
						<div class="member-status">
							<img class="icon-people" alt="" src="media/icon-people.png">
							<div class="member-status-text"><%=group.getCurrentMembers() %>/<%=group.getMaxMembers() %></div>
						</div>
						<div class="meeting-time">
				<%
					int daycnt = 0;
					for (Day day: days) {
						if (daycnt != 0) {
					
				%>
						,&nbsp;
				<%
						}
				%>
						<%=day.getDay() %>&nbsp;<%=day.getStartTime() %>~<%=day.getEndTime() %>
				<%
					}
				%>
						</div>
					</div>
					<div class="tag-area">
			<%
				for (String tag: categories) {
			%>
						<div class="tag">
							<div class="tag-box" style="background-color:<%=getCategoryColor(tag) %>">
								<div class="tag-text"><%=tag %></div></div>
						</div>
			<%
				}
			%>
					</div>
				</div>
			</a>
			<%
				groupcnt++;
				if (groupcnt % 4 == 0) {
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
<%! private String getCategoryColor(String category) {
	String result;
	switch (category) {
	case "토론": result = "#e9e587"; break;
	case "공부": result = "#87b6e9"; break;
	case "언어": result = "#e98787"; break;
	case "자유": result = "#cecece"; break;
	case "운동": result = "#8be3f4"; break;
	case "취미": result = "#87e9ba"; break;
	default: result = "grey"; break;
	}
	return result;
}
private List<String> getCategories(String category) {
	List<String> categories = new ArrayList<>();
	StringTokenizer tokenizer = new StringTokenizer(category, " ");
	String tag = null;
	int cnt = 0;
	
	while (tokenizer.hasMoreTokens()) {
		tag = tokenizer.nextToken();
		categories.add(tag);
		cnt++;
		if (cnt>3) break;
	}
	return categories;
}
%>