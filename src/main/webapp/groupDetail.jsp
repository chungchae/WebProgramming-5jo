<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, width=device-width">
	<link rel="stylesheet" href="css/global.css" />
	<link rel="stylesheet" href="css/groupPage.css?after" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@400&display=swap" />
</head>
<body>
<%
	String sessionEmail = (String) session.getAttribute("email");
	
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
				</div>
			</a>
			<div class="nav">
			<%
				if (sessionEmail != null) {
			%>
				<div class="nav-component">
			<%
				} else {
			%>
				<div class="nav-component" style="visibility: hidden;">
			<%
				}
			%>
					<div class="label"><a href="/groupCreate.jsp">새 모임 만들기</a></div>
				</div>
				<div class="nav-component">
					<div class="label"><a href="/main">모임 둘러보기</a></div>
				</div>
				<div class="nav-component">
					<div class="label">
				<%
					if (sessionEmail != null) {
				%>
						<a href="/user/mypage">마이페이지</a></div>
				<%
					} else { 
				%>
						<a href="/signup.jsp">회원가입</a></div>
				<%
					}
				%>
				
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
	<img src="media/<%= group.getImageUrl() != null ? "group" + group.getId() + ".png" : "/placeholder.png" %>" alt="" class="card-image">
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
		<%
			String statement = (String) request.getAttribute("statement"); // 방장인지 확인
		%>
		
			<%
				if ("방장".equals(statement)) {
			%>
			<div class="button-area">
			<div class="small-box-button" style="background-color: #33b4ff;">
				<form action="<%= request.getContextPath() %>/groupEdit" method="get">
				<input type="hidden" name="id" value="<%= group.getId() %>">
				<input type="submit" value="수정하기" class="submit">
				</form>
			</div>
			<div class="small-box-button" style="background-color: #FF709E;">
				<form action="<%= request.getContextPath() %>/groupDelete" method="get" style="display:inline;">
				<input type="hidden" name="id" value="<%= group.getId() %>">
				<input type="submit" value="삭제하기" class="submit">
				</form>
			</div>
			</div>
			<%
			} else if ("가입대기".equals(statement) == true) {
			%>
			<div class="box-button">
				<input type="hidden" name="groupId" value="<%= group.getId() %>">
				<input type="submit" value="가입 신청 중" class="submitbox">
				</form>
			</div>
			<%
				} else if ("회원".equals(statement) == true) {
			%>
			<div class="box-button">
					<input type="hidden" name="groupId" value="<%= group.getId() %>">
					<input type="submit" value="모임 참여 중" class="submitbox">
				</form>
			</div>
			<%
				} else {
			%>
			<div class="box-button">
				<form action="<%= request.getContextPath() %>/groupJoin" method="post">
					<input type="hidden" name="groupId" value="<%= group.getId() %>">
					<input type="submit" value="모임 가입하기" class="submitbox">
				</form>
			</div>
			<%
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
