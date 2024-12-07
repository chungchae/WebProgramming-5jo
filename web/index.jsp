<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, width=device-width">
	<title>Project</title>
	<link rel="stylesheet" href="./global.css" />
	<link rel="stylesheet" href="./index.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" />
</head>
<body>
<%
	// 데이터 확인 및 로드
	List<List> groupList = new ArrayList<>();
	List<Group> recentGroups = (List<Group>) request.getAttribute("lastestGroups");
	List<Group> sportsGroups = (List<Group>) request.getAttribute("exerciseGroups");
	List<Group> studyGroups = (List<Group>) request.getAttribute("studyGroups");
	String sessionId = (String) request.getAttribute("sessionId");
	String sessionEmail = (String) request.getAttribute("email");

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
				<input type="submit" id="button-search" value="">
			</form>
		</div>
	</div>
	<div class="section-group">
		<%
			// 카테고리별 그룹 렌더링
			for (int i = 0; i < groupList.size(); i++) {
				groupType = groupTypes[i];
				iconType = iconTypes[i];
				groups = groupList.get(i);
		%>
		<div class="section-category">
			<div class="category-wrapper">
				<img class="icon-<%= iconType %>" src="media/icon-<%= iconType %>.png" alt="">
				<div class="category-name"><%= groupType %> 모임</div>
			</div>
			<div class="plus">
				<a href="/groupList"><img class="icon-plus" src="media/icon-plus.png" alt=""></a>
			</div>
			<div class="card-set">
				<%
					// 그룹 카드 생성
					for (int groupcnt = 0; groupcnt < 4; groupcnt++) {
						try {
							Group group = groups.get(groupcnt);
							List<String> categories = getCategories(group.getCategory());
							List<Day> days = group.getDays();
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
									int daycnt = 0;
									for (Day day : days) {
										if (daycnt != 0) { %>, &nbsp;<% }
							%>
								<%= day.getDay() %>&nbsp;<%= day.getStartTime() %>~<%= day.getEndTime() %>
								<%
										daycnt++;
									}
								%>
							</div>
						</div>
						<div class="tag-area">
							<%
								for (String tag : categories) {
							%>
							<div class="tag">
								<div class="tag-box" style="background-color:<%= getCategoryColor(tag) %>">
									<div class="tag-text"><%= tag %></div>
								</div>
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
				<div class="card" style="background-color: inherit; font-size: 24px; margin-left: 60px; vertical-align: baseline;">
					해당하는 모임이 없습니다.
				</div>
				<%
							break;
						}
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
<%!
	// 헬퍼 메소드
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

	private List<String> getCategories(String category) {
		List<String> categories = new ArrayList<>();
		if (category == null || category.isEmpty()) {
			return categories; // category가 null 또는 빈 문자열이면 빈 리스트 반환
		}
		StringTokenizer tokenizer = new StringTokenizer(category, " ");
		String tag = null;
		int cnt = 0;

		while (tokenizer.hasMoreTokens()) {
			tag = tokenizer.nextToken();
			categories.add(tag);
			cnt++;
			if (cnt > 3) break;
		}
		return categories;
	}
%>
