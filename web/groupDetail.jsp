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
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
<%
    Group group = (Group) request.getAttribute("group");
	List<User> users = new ArrayList<>(); 
	Object obj = request.getAttribute("users");
	List<Day> meetingDays = new ArrayList<>();  // 모임 날짜 및 시간 필드 서버에서 받아오도록 수정 필요
	
	// 이하 필드 초기화값을 null로 지정
	String title = null;
	String category = null;
    String description = null;
    String imgUrl = null;
	int maxMembers = 0;
	int currentMembers = 0;
	int groupId = 0;
	
	// get group info
    if (group != null) {
    	groupId = group.getId();
    	title = group.getTitle();
    	category = group.getCategory();
    	description = group.getDescription();
    	imgUrl = group.getImageUrl();
    	maxMembers = group.getMaxMembers();
    	currentMembers = group.getCurrentMembers();
    }
    
	// get category list
    List<String> categories = getCategories(category);
    
	// get member list;
    if (obj instanceof List) {
	    List<?> tempList = (List<?>) obj;
	    if (!tempList.isEmpty() && tempList.get(0) instanceof User) { // 내부 요소 검사
	        users = (List<User>) obj; // 캐스팅
	    }
	}
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
		<div class="background-image-area" style="background-image: url('<%=imgUrl %>');"></div>
		<div class="background-under-area"></div>
		<div class="background">
			<div class="intro">
				<div class="intro-text"><%=title %></div>
			</div>
			<div class="member-status">
				<img class="icon-people" alt="" src="media/icon-people.png">
				<div class="member-status-text"><%=currentMembers %>/<%=maxMembers %></div>
		  	</div>
			<div class="section-tag">
			<%
				for (String tag: categories) {
			%>
				<div class="tag">
					<div class="tag-box" style="background-color: <%=getCategoryColor(tag)%>;">
						<div class="tag-text"><%=tag %></div>
					</div>
				</div>
			<% } %>
			</div>
			
			<div class="section-time">
			<%
				int daycnt = 0;
				for (Day day: meetingDays) {
					if (daycnt == 0) {
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
					<div class="date"><%=day.getDay() %></div>
					<div class="time"><%=day.getStartTime() %>~<%=day.getEndTime() %></div>
				</div>
			<%	daycnt++;
				}
			%>
			</div>
			
			<div class="member-info">
				<div class="member-text">구성원</div>
				<table class="member">
				<% 
					int i = 0;
					String name = null;
					String major = null;
					int grade = 0;
					for (User user: users) {
						name = user.getName();
						major = user.getMajor();
						grade = user.getGrade();
				%>
					<tr>
				<%
					if (i==0) {
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
						<td class="user-name"><%=name %></td>
						<td class="major"><%=major %></td>
						<td class="grade"><%=grade %>학년</td>
					</tr>
				<%
					i++;
					}
				%>
				</table>
			</div>
			
			<div class="details">
				<div class="detail-text">모임 설명</div>
				<div class="meeting-detail">
					<%=description %>
				</div>
			</div>
			
			<form class="box-button" action="/group/join" method="post">
				<input type="hidden" value="<%=groupId %>" name="groupId">
				<input type="submit" value="모임 가입하기" class="submitbox">
			</form>
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
