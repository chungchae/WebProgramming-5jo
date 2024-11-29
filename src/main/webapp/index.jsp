<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Group" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
	
	<link rel="stylesheet"  href="./global.css" />
  	<link rel="stylesheet"  href="./index.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
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
		<div class="search-group">
      		<div class="search-box"></div>
            <form method="get" action="<%= request.getContextPath() %>/groupSearch">
      			<input type="submit" id="button-search" value="">
      			<input type="text" name="groupName" id="search" placeholder="모임을 검색해보세요!" required/>
			</form>
    	</div>
		<div class="section-category">
			<div class="category">
				<div class="category-name">최근 모임</div>
				<img class="icon-clock" alt="" src="media/icon-clock.png">
			</div>
      		<img class="icon-plus" alt="" src="media/icon-plus.png">
			<div class="card-set">
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example1.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">3/15</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
						  </div>
						  <div class="title">
								<div class="title-text">다독왕만들기</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#e9e587">
								</div>
								<div class="tag-text">토론</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#87e9ba">
								</div>
								<div class="tag-text">취미</div>
						  </div>
					</div>
			  	</div>
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example2.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">3/15</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">언어 교환 모임</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#e98787"></div>
								<div class="tag-text">언어</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#87b6e9">
								</div>
								<div class="tag-text">공부</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#e9e587">
								</div>
								<div class="tag-text">토론</div>
						  </div>
					</div>
			  	</div>
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example3.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00, 목 13:00 ~ 15:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">8/10</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">공강 배드민턴</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#cecece">
								</div>
								<div class="tag-text">자유</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#8be3f4">
								</div>
								<div class="tag-text">운동</div>
						  </div>
					</div>
			  	</div>
      			<div class="card">
        				<div class="card-frame">
          					<img class="card-image" alt="" src="media/example4.png">
          					
							<div class="title">
            					<div class="title-text">컴네 중간</div>
          					</div>

          					<div class="time-info">
            						<div class="time-info-text">화 10:00 ~ 12:00, 목 13:00 ~ 15:00</div>
          					</div>
          					<div class="member-status">
            						<div class="member-status-text">4/5</div>
            						<img class="icon-people" alt="" src="media/icon-people.png">
            						
          					</div>
          					
        				</div>
        				<div class="section-tag">
          					<div class="tag">
            						<div class="tag-box" style="background-color:#cecece">
            						</div>
            						<div class="tag-text">자유</div>
          					</div>
          					<div class="tag">
            						<div class="tag-box" style="background-color:#87b6e9">
            						</div>
            						<div class="tag-text">공부</div>
          					</div>
        				</div>
      			</div>
			</div>
    	</div>
		<div class="section-category">
			<div class="category">
				<div class="category-name">운동 모임</div>
				<img class="icon-fire" alt="" src="media/icon-fire.png">
			</div>
      		<img class="icon-plus" alt="" src="media/icon-plus.png">
			<div class="card-set">
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example1.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">3/15</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">다독왕만들기</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#e9e587">
								</div>
								<div class="tag-text">토론</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#87e9ba">
								</div>
								<div class="tag-text">취미</div>
						  </div>
					</div>
			  	</div>
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example2.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">3/15</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">언어 교환 모임</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#e98787">
								</div>
								<div class="tag-text">언어</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#87b6e9">
								</div>
								<div class="tag-text">공부</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#e9e587">
								</div>
								<div class="tag-text">토론</div>
						  </div>
					</div>
			  	</div>
      			<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example3.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00, 목 13:00 ~ 15:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">8/10</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">공강 배드민턴</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#cecece">
								</div>
								<div class="tag-text">자유</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#8be3f4">
								</div>
								<div class="tag-text">운동</div>
						  </div>
					</div>
			 	</div>
      			<div class="card">
        			<div class="card-frame">
          				<img class="card-image" alt="" src="media/example4.png">
          				<div class="time-info">
            					<div class="time-info-text">화 10:00 ~ 12:00, 목 13:00 ~ 15:00</div>
          				</div>
          				<div class="member-status">
            				<div class="member-status-text">4/5</div>
            				<img class="icon-people" alt="" src="media/icon-people.png">
            			</div>
          				<div class="title">
            				<div class="title-text">컴네 중간</div>
          				</div>
        			</div>
        			<div class="section-tag">
          				<div class="tag">
            						<div class="tag-box" style="background-color:#cecece">
            						</div>
            						<div class="tag-text">자유</div>
          				</div>
          				<div class="tag">
            				<div class="tag-box" style="background-color:#87b6e9">
            				</div>
            				<div class="tag-text">공부</div>
          				</div>
        			</div>
      			</div>
			</div>
		</div>
    	<div class="section-category">
			<div class="category">
				<div class="category-name">공부 모임</div>
				<img class="icon-book" alt="" src="media/icon-book.png">
			</div>
      		<img class="icon-plus" alt="" src="media/icon-plus.png">

			<div class="card-set">
				<div class="card">
					<div class="card-frame">
						<img class="card-image" alt="" src="media/example1.png">
						<div class="title">
							<div class="title-text">다독왕만들기</div>
					  	</div>
						<div class="time-info">
							<div class="time-info-text">화 10:00 ~ 12:00</div>
						</div>
						<div class="member-status">
							<div class="member-status-text">3/15</div>
							<img class="icon-people" alt="" src="media/icon-people.png">	
						</div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#e9e587">
								</div>
								<div class="tag-text">토론</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#87e9ba">
								</div>
								<div class="tag-text">취미</div>
						  </div>
					</div>
			  	</div>
				<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example2.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">3/15</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">언어 교환 모임</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#e98787">
								</div>
								<div class="tag-text">언어</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#87b6e9">
								</div>
								<div class="tag-text">공부</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#e9e587">
								</div>
								<div class="tag-text">토론</div>
						  </div>
					</div>
			 	</div>
      			<div class="card">
					<div class="card-frame">
						  <img class="card-image" alt="" src="media/example3.png">
						  
						  <div class="time-info">
								<div class="time-info-text">화 10:00 ~ 12:00, 목 13:00 ~ 15:00</div>
						  </div>
						  <div class="member-status">
								<div class="member-status-text">8/10</div>
								<img class="icon-people" alt="" src="media/icon-people.png">
								
						  </div>
						  <div class="title">
								<div class="title-text">공강 배드민턴</div>
						  </div>
					</div>
					<div class="section-tag">
						  <div class="tag">
								<div class="tag-box" style="background-color:#cecece">
								</div>
								<div class="tag-text">자유</div>
						  </div>
						  <div class="tag">
								<div class="tag-box" style="background-color:#8be3f4">
								</div>
								<div class="tag-text">운동</div>
						  </div>
					</div>
			  	</div>
      			<div class="card">
        			<div class="card-frame">
          				<img class="card-image" alt="" src="media/example4.png">
          				<div class="title">
            				<div class="title-text">컴네 중간</div>
          				</div>
          				<div class="time-info">
            				<div class="time-info-text">화 10:00 ~ 12:00, 목 13:00 ~ 15:00</div>
          				</div>
						<div class="member-status">
            				<div class="member-status-text">4/5</div>
            				<img class="icon-people" alt="" src="media/icon-people.png">		
          				</div>
        			</div>
        			<div class="section-tag">
          				<div class="tag">
            				<div class="tag-box" style="background-color:#cecece">
            				</div>
            				<div class="tag-text">자유</div>
          				</div>
          				<div class="tag">
            				<div class="tag-box" style="background-color:#87b6e9">
            				</div>
            				<div class="tag-text">공부</div>
          				</div>
        			</div>
      			</div>
			</div>
    	</div>
  	</div>
</body>
</html>