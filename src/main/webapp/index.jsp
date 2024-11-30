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
	List<List> groupList = null;
	List<Group> recentGroups = null;
	List<Group> sportsGroups = null;
	List<Group> studyGroups = null;
	
	// 수정: 종류별 모임 정보를 받아와야합니다.
	recentGroups = (List<Group>) request.getAttribute("recentGroups");
	sportsGroups = (List<Group>) request.getAttribute("sportsGroups");
	studyGroups = (List<Group>) request.getAttribute("studyGroups");
	

	groupList.add(recentGroups);
	groupList.add(sportsGroups);
	groupList.add(studyGroups);
	
	String groupTypes[] = { "최근", "운동", "공부" };
	String iconTypes[] = { "clock", "fire", "book" }; 
	String groupType, iconType;
	List<Group> groups;
	String invisible = "style='visibility: invisible;'";
%>
  	<div class="div">
		<div class="header">
			<div class="container">
				<a href="index.html">
				<div class="web-logo">
					<img class="logo" alt="" src="media/Icon.svg">
					<div class="logo-text">Project</div>
				</div></a>
				<div class="nav">
					<div class="haeding-name">
						<div class="nav-component">
							<div class="label"><a href="groupCreate.jsp">새 모임 만들기</a></div>
						</div>
						<div class="nav-component">
							<div class="label"><a href="index.jsp">모임 둘러보기</a></div>
						</div>
						<div class="nav-component">
							<div class="label"><a href="/user/mypage">마이페이지</a></div>
						</div>
						<div class="nav-component" class="logout">
							<div class="label"><a href="/user/logout">로그아웃</a></div>
						</div>
						<div class="nav-component">
							<img class="icon-profile" alt="" src="media/icon-profile.png">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="search-group">
      		<div class="search-box"></div>
            <form method="get" action="<%= request.getContextPath() %>/groupSearch">
      			<input type="submit" id="button-search" value="">
      			<input type="text" name="groupName" id="search" placeholder="모임을 검색해보세요!" required/>
			</form>
    	</div>
	<%
		for (int i=0; i<3; i++) {
			groupType = groupTypes[i];
			iconType = iconTypes[i];
			groups = groupList.get(i);
	%>
		<div class="section-category">
			<div class="category">
				<div class="category-name"><%=groupType %> 모임</div>
				<img class="icon-<%=iconType %>" alt="" src="media/icon-<%=iconType %>.png">
			</div>
      		<a href="groupList.jsp"><img class="icon-plus" alt="" src="media/icon-plus.png"></a>
			<div class="card-set">
			<%
				for (int groupcnt = 0; groupcnt < 4; groupcnt++) {
					boolean flag = true;
					try {
						Group group = groups.get(groupcnt);
						List<String> categories = getCategories(group.getCategory());
			%>
			<a href="<%= request.getContextPath() %>/groupPage?id=<%= group.getId() %>">
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="<%=group.getImageUrl() %>">
						  
						  <div class="time-info">
								<div class="time-info-text">
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
						  <div class="member-status">
								<div class="member-status-text"><%= group.getCurrentMembers() %>/<%= group.getMaxMembers() %></div>
								<img class="icon-people" alt="" src="media/icon-people.png">
						  </div>
						  <div class="title">
								<div class="title-text"><%=group.getTitle() %></div>
						  </div>
					</div>
					<div class="section-tag">
						<%
							for (String category: categories) {
						%>
						  <div class="tag">
								<div class="tag-box" style="background-color:<%=getCategoryColor(category)%>">
								</div>
								<div class="tag-text"><%=category %></div>
						  </div>
						<%
							}
						 %>
					</div>
			  	</div>
			  </a>
			<%			
					} catch (Exception e) {					
			%>
				<div class="card" style="visibility: invisible; background-color:none;">
					<div class="card-frame"></div>
				</div>
			<%
					}
				}
		}
			%>
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