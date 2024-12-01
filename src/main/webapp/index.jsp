<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
	<title>Project</title>
	<link rel="stylesheet"  href="./global.css" />
  	<link rel="stylesheet"  href="./index.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
<%
	List<List> groupList = new ArrayList<>();
	List<Group> recentGroups = new ArrayList<>();
	List<Group> sportsGroups = new ArrayList<>();
	List<Group> studyGroups = new ArrayList<>();
	/*
	recentGroups = (List<Group>) request.getAttribute("latestGroups");
	sportsGroups = (List<Group>) request.getAttribute("exerciseGroups");
	studyGroups = (List<Group>) request.getAttribute("studyGroups");
	*/
	Group newGroup = new Group(1,"모임", "토론 언어", "상세 설명", "media/example1.png", 15,3);
	List<Day> newDays = new ArrayList<>();
	Day day1 = new Day();
	day1.setDay("월");
	day1.setStartTime("10:00");
	day1.setEndTime("12:00");
	newDays.add(day1);
	newGroup.setDays(newDays);
	
	recentGroups.add(newGroup);
	sportsGroups.add(newGroup);
	studyGroups.add(newGroup);
	groupList.add(recentGroups);
	groupList.add(sportsGroups);
	groupList.add(studyGroups);
	
	String groupTypes[] = { "최근", "운동", "공부" };
	String iconTypes[] = { "clock", "fire", "book" }; 
	String groupType, iconType;
	List<Group> groups;
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
		<div class="search-group">
      		<div class="search-box">
				<form method="get" action="<%= request.getContextPath() %>/groupSearch">
					<input type="text" name="search" id="search" placeholder="모임을 검색해보세요!" />
					<input type="submit" id="button-search" value="">
				</form>
			</div>
    	</div>
    	<div class="section-group">
	<%
		for (int i=0; i<3; i++) {
			groupType = groupTypes[i];
			iconType = iconTypes[i];
			groups = groupList.get(i);
	%>
		<div class="section-category">
			<div class="category-wrapper">
				<img class="icon-clock" src="media/icon-clock.png" alt="">
				<div class="category-name">최근 모임</div>
			</div>
			<div class="plus">
				<a href="groupList.jsp"><img class="icon-plus" src="media/icon-plus.png" alt=""></a>
			</div>
			<div class="card-set">
			<%
				for (int groupcnt = 0; groupcnt < 4; groupcnt++) {
					boolean flag = true;
					try {
						Group group = groups.get(groupcnt);
						List<String> categories = getCategories(group.getCategory());
						List<Day> days = group.getDays();
			%>
			<a href="<%= request.getContextPath() %>/groupDetail?id=<%=group.getId() %>">
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
						<div class="meeting-time">화 10:00~12:00</div>
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
					} catch (Exception e) {	}				
				}
			%>
			</div>
		</div>
			<% 
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