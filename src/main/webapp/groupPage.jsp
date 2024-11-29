<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Group" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
  	
    <link rel="stylesheet" href="./global.css" />
  	<link rel="stylesheet" href="./groupPage.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
<%
    Group group = (Group) request.getAttribute("group");
    
	// 이하 필드 초기화값을 null로 지정
	String title = "언어 교환 모임";
    String[] categories = {"토론", "공부", "언어"};
    String description = "각자 원하는 언어를 배우는 모임입니다! 모임 내에서 멘토를 정해 서로 구사 가능한 언어를 가르쳐주고, 배울 수 있어요. 언어 관련 시험 대비 목적도 좋습니다. 함께 공부해요!";
    String imgUrl = "media/Background-image.png";
	int maxMembers = 15;
	int currentMembers = 3;
	String meetingDay = "화";
	String start = "10:00";
	String end = "12:00";
	
    if (group != null) {
    	title = group.getTitle();
    	//categories = group.getCategory();
    	description = group.getDescription();
    	imgUrl = group.getImageUrl();
    	maxMembers = group.getMaxMembers();
    	currentMembers = group.getCurrentMembers();
    }
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
							<div class="label"><a href="groupCreate.html">새 모임 만들기</a></div>
						</div>
						<div class="nav-component">
							<div class="label"><a href="index.html">모임 둘러보기</a></div>
						</div>
						<div class="nav-component">
							<div class="label"><a href="mypage.html">마이페이지</a></div>
						</div>
						<div class="nav-component" class="logout">
							<div class="label">로그아웃</div>
						</div>
						<div class="nav-component">
							<img class="icon-profile" alt="" src="media/icon-profile.png">
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
				for (String category: categories) {
			%>
				<div class="tag">
					<div class="tag-box" style="background-color: <%=getCategoryColor(category)%>;">
						<div class="tag-text"><%=category %></div>
					</div>
				</div>
			<% } %>
			</div>
		
			<div class="section-time">
				<div class="time-text">모임 시간</div>
				<div class="meeting">
					<div class="date"><%=meetingDay %></div>
					<div class="time"><%=start %>~<%=end %></div>
				</div>
			</div>

			<div class="member-info">
				<div class="member-text">구성원</div>
				<table class="member">
					<tr>
						<td class="leader-icon"><img src="media/leader.png" alt="" width="25px" height="25px"></td>
						<td class="user-icon"><img src="media/icon-User.png" alt="" width="30px" height="30px"></td>
						<td class="user-name">김경영</td>
						<td class="major">경영학과</td>
						<td class="grade">3학년</td>
					</tr>
					<tr>
						<td class="leader-icon"></td>
						<td class="user-icon"><img src="media/icon-User.png" alt="" width="30px" height="30px"></td>
						<td class="user-name">이컴공</td>
						<td class="major">컴퓨터공학과</td>
						<td class="grade">3학년</td>
					</tr>
					<tr>
						<td class="leader-icon"></td>
						<td class="user-icon"><img src="media/icon-User.png" alt="" width="30px" height="30px"></td>
						<td class="user-name">박회계</td>
						<td class="major">회계학과</td>
						<td class="grade">2학년</td>
					</tr>
				</table>

			</div>

			<div class="details">
				<div class="detail-text">모임 설명</div>
				<div class="meeting-detail">
					<%=description %>
				</div>

			</div>

			<div class="box-button">
				<input type="submit" value="모임 가입하기" class="submitbox">
			</div>    			
    	</div>
    </div>
</body>
</html>
<%!
private String getCategoryColor(String category) {
	String result;
	switch(category) {
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
%>