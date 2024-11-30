<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
  	
    <link rel="stylesheet" href="./global.css" />
  	<link rel="stylesheet" href="./mypage.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
    <script src="./mypage.js"></script>
</head>
<body>
<%
	User user;	// 수정: 세선에서 유저 정보 받아와야 합니다
	List<Group> groups = new ArrayList<>(); 	// 수정: 사용자의 소속 그룹 정보를 받아와야 합니다.
	List<Day> days = new ArrayList<>();			// 수정: 그룹 모임 날짜 정보를 받아와야 합니다.
	String userName = user.getName();
	String university = user.getUniv();
	String major = user.getMajor();
	String userEmail = user.getEmail();
	String userPw = user.getPassword();
	String hobby = user.getHobby();
	int grade = user.getGrade();
	String introduction = user.getIntroduction();
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
        <div class="section-profile">
            <table id="profile">
                <tr>
                    <td colspan="2" class="blank"><div id="button-box-modify"><button type="button" id="button-modify" onclick="modalOpen()">수정</button></div></td>
                </tr>
                <tr>
                    <td rowspan="3"><div id="profile-image"></div></td>
                    <td id="name"><%=userName %></td>
                </tr>
                <tr>
                    <td id="affiliation"><%=university %> <%=major %> <%=grade %>학년</td>
                </tr>
                <tr>
                    <td id="self-introduction"><%=introduction %></td>
                </tr>
                <tr>
                    <td colspan="2" class="blank"></td>
                </tr>
            </table>
        </div>
        <div class="section-meeting">
            <div class="section-title">가입된 모임</div>
          <%
          	for (Group group: groups) {
          %>
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
                    	daycnt++;
                    	}
                    %>
                    </div>
                    <div class="button-area">
                        <div class="button-box-withdrawal">
                            <button type="button" class="withdrawal">탈퇴</button>
                        </div>  
                    </div>
                </div>
            </div>
       <%
          	}     
       %>
        </div>
        <div class="section-notice">
            <div class="section-title">알림</div>
            <div class="notice-line">
                <div class="notice-content">
                    김다독 님이 다독왕만들기 모임에 가입을 신청했습니다.
                </div>
                <div class="button-box-accept">
                    <button type="button" class="accept">수락</button>
                </div>
                <div class="button-box-reject" >
                    <button type="button" class="reject">거절</button>
                </div>
            </div>
            <div class="notice-line">
                <div class="notice-content">
                    김정독 님이 다독왕만들기 모임에서 탈퇴하였습니다.
                </div>
            </div>
        </div>
    </div>
    <div id="modalContainer" class="hidden">
        <div id="wrapper">
            <button id="modalCloseButton" onclick="modalClose()"></button>
            <div id="modalContent">
                <div id="modal-title">회원정보 수정</div>
                <form method="post" action="/user">
                    <div class="input-field">
                        <div class="input-kind">이름</div>
                        <div class="box">
                            <input type="text" name="name" class="inputbox" value=<%=userName %> disabled>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">이메일</div>
                        <div class="box">
                            <input type="email" name="email" class="inputbox" value=<%=userEmail %> disabled>
                        </div>
                    </div>
                    
                    <div class="input-field">
                        <div class="input-kind">비밀번호</div>
                        <div class="box">
                            <input type="password" name="password" class="inputbox" value=<%=userPw %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">대학교</div>
                        <div class="box">
                            <input type="text" name="univ" class="inputbox" value=<%=university %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">전공</div>
                        <div class="box">
                            <input type="text" name="major" id="major" class="inputbox" value=<%=major %>>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">학년</div>
                        <div class="box">
                            <select name="grade" class="inputbox">
                                <option value="1">1학년</option>
                                <option value="2">2학년</option>
                                <option value="3">3학년</option>
                                <option value="4">4학년</option>
                            </select>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">취미</div>
                        <div class="box">
                            <input type="text" name="hobby" class="inputbox" value=<%=hobby %> required>
                        </div>
                    </div>

                    <div class="input-field">
                        <div class="input-kind">자기소개</div>
                        <div class="box-large">
                            <textarea name="introduction" class="textbox" required><%=introduction %></textarea>
                        </div>
                    </div>

                    <div class="submit-field">
                        <div class="button">
                            <input type="submit" name="signup" value="정보수정" class="submit"></div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <script>
		const grade = document.getElementById("grade");
		grade.value ="<%=grade%>"
	</script>
</body>
</html>