<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
  	
    <link rel="stylesheet" href="./global.css" />
  	<link rel="stylesheet" href="./groupCreate.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
	<script src="./groupCreate.js"></script>
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
		<div class="background-image-area"></div>
		<div class="background">
			<div class="intro">
				<img class="check-icon" alt="" src="media/icon-check.png">
				<div class="intro-text">모임 정보 입력</div>
			</div>
			<form method="post" action="<%= request.getContextPath() %>/groupCreate" onsubmit="return checkForm()">
				<div class="input-field">
					<div class="input-kind">모임 이름</div>
					<div class="box1">
						<input type="text" name="title" class="inputbox" placeholder="모임 이름을 입력하세요" required>
					</div>
		  		</div>

				<div class="input-field">
					<div class="input-kind">모임 인원</div>
        			<div class="box1">
						<input type="number" name="maxMembers" class="inputbox" placeholder="인원 수를 입력하세요(3~15명)" min="3" max="15" required>
        			</div>
      			</div>

				<div class="input-field days">
					<div class="input-kind">모임 시간</div>
					<div class="box2">
						<select name="day1" class="selectbox" id="day1">
							<option disabled selected hidden>요일</option>
							<option value="monday">월요일</option>
							<option value="tuesday">화요일</option>
							<option value="wednesday">수요일</option>
							<option value="thursday">목요일</option>
							<option value="friday">금요일</option>
							<option value="saturday">토요일</option>
							<option value="sunday">일요일</option>
						</select>
					</div>
					<div class="box3">
						<input type="time" class="timebox" name="start1" id="start1">
					</div>
					~
					<div class="box3">
						<input type="time" class="timebox" name="end1" id="end1">
					</div>
        			<input type="button" class="plus-button" onclick="addDay()">
      			</div>
				<div class="input-field days hidden">
					<div class="wrapper">
					<div class="box2">
						<select name="day2" class="selectbox" id="day2">
							<option selected>요일</option>
							<option value="monday">월요일</option>
							<option value="tuesday">화요일</option>
							<option value="wednesday">수요일</option>
							<option value="thursday">목요일</option>
							<option value="friday">금요일</option>
							<option value="saturday">토요일</option>
							<option value="sunday">일요일</option>
						</select>
					</div>
					<div class="box3">
						<input type="time" class="timebox" name="start2" id="start2">
					</div>
					~
					<div class="box3">
						<input type="time" class="timebox" name="end2" id="end2">
					</div>
					</div>
      			</div>
				<div class="input-field days hidden">
					<div class="wrapper">
					<div class="box2">
						<select name="day3" class="selectbox" id="day3">
							<option selected>요일</option>
							<option value="monday">월요일</option>
							<option value="tuesday">화요일</option>
							<option value="wednesday">수요일</option>
							<option value="thursday">목요일</option>
							<option value="friday">금요일</option>
							<option value="saturday">토요일</option>
							<option value="sunday">일요일</option>
						</select>
					</div>
					<div class="box3">
						<input type="time" class="timebox" name="start3" id="start3">
					</div>
					~
					<div class="box3">
						<input type="time" class="timebox" name="end3" id="end3">
					</div>
        			</div>
      			</div>

      			<div class="input-field">
        			<div class="input-kind">태그(최대 3개)</div>
					<div class="wrapper">
					<div class="box2">
						<select name="category1" class="selectbox tags">
							<option hidden selected>태그 1</option>
							<option value="exercise">운동</option>
							<option value="study">공부</option>
							<option value="free">자유</option>
							<option value="debate">토론</option>
							<option value="language">언어</option>
							<option value="hobby">취미</option>
						</select>
					</div>
					<div class="box2">
						<select name="category2" class="selectbox tags">
							<option disabled hidden selected>태그 2</option>
							<option value="exercise">운동</option>
							<option value="study">공부</option>
							<option value="free">자유</option>
							<option value="debate">토론</option>
							<option value="language">언어</option>
							<option value="hobby">취미</option>
						</select>
					</div>
					<div class="box2">
						<select name="category3" class="selectbox tags">
							<option disabled hidden selected>태그 3</option>
							<option value="exercise">운동</option>
							<option value="study">공부</option>
							<option value="free">자유</option>
							<option value="debate">토론</option>
							<option value="language">언어</option>
							<option value="hobby">취미</option>
						</select>
					</div>
					</div>
      			</div>
				
				<div class="input-field">
					<div class="input-kind">모임 설명</div>
					<div class="box4">
						<textarea placeholder="모임을 자유롭게 소개해주세요" name="description" class="textbox" required></textarea>
					</div>
      			</div>

				<div class="box-button">
					<input type="submit" value="모임 시작하기" class="submitbox">
			 	</div> 
			</form>    			
    	</div>
    	
    	<div class="add-background">배경 이미지 추가</div>
    </div>
</body>
</html>