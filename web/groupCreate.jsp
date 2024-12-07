<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1, width=device-width">

  <!-- 외부 CSS 파일 불러오기 -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/global.css" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/groupCreate.css" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend+Deca:wght@400&display=swap" />
</head>
<body>
<div class="div">
  <div class="header">
    <div class="container">
      <a href="<%= request.getContextPath() %>/main">
        <div class="web-logo">
          <img class="logo" alt="" src="<%= request.getContextPath() %>/media/Icon.svg">
          <div class="logo-text">Project</div>
        </div>
      </a>
      <div class="nav">
        <div class="haeding-name">
          <div class="nav-component">
            <div class="label"><a href="<%= request.getContextPath() %>/groupCreate.jsp">새 모임 만들기</a></div>
          </div>
          <div class="nav-component">
            <div class="label"><a href="<%= request.getContextPath() %>/main">모임 둘러보기</a></div>
          </div>
          <div class="nav-component">
            <div class="label"><a href="<%= request.getContextPath() %>/user/mypage">마이페이지</a></div>
          </div>
          <div class="nav-component logout">
            <a href="<%= request.getContextPath() %>/user/logout">
              <div class="label">로그아웃</div>
            </a>
          </div>
          <div class="nav-component">
            <a href="<%= request.getContextPath() %>/user/mypage">
              <img class="icon-profile" alt="" src="<%= request.getContextPath() %>/media/icon-profile.png">
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="background-image-area"></div>
  <div class="background">
    <div class="intro">
      <img class="check-icon" alt="" src="<%= request.getContextPath() %>/media/icon-check.png">
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
        <div class="input-kind" style="inline-block;">모임 시간
        <button type="button" class="plus-button" onclick="addDay()" style="margin-left:425px; margin-right: 0px; height: 25px;"></button>
        </div>
        <div id="daysContainer" style="text-align: left; margin-left: 25px; width: 600px;">
            <select name="days[]" class="selectbox" required style="display: inline-block;">
              <option disabled selected hidden>요일</option>
              <option value="월">월</option>
              <option value="화">화</option>
              <option value="수">수</option>
              <option value="목">목</option>
              <option value="금">금</option>
              <option value="토">토</option>
              <option value="일">일</option>
            </select>
            <div style="display: inline-block; margin-left: 10px;">모임 시간:
            <input type="time" class="timebox" name="startTimes[]" required>
            ~
            <input type="time" class="timebox" name="endTimes[]" required></div>
        </div>
      </div>

      <div class="input-field">
        <div class="input-kind">태그(최대 3개)</div>
        <div class="wrapper">
          <div class="box2">
            <select name="categories[]" class="selectbox tags" required>
              <option value="" hidden selected>태그 1</option>
              <option value="운동">운동</option>
              <option value="공부">공부</option>
              <option value="자유">자유</option>
              <option value="토론">토론</option>
              <option value="언어">언어</option>
              <option value="취미">취미</option>
            </select>
          </div>
          <div class="box2">
            <select name="categories[]" class="selectbox tags">
              <option value="" hidden selected>태그 2</option>
              <option value="운동">운동</option>
              <option value="공부">공부</option>
              <option value="자유">자유</option>
              <option value="토론">토론</option>
              <option value="언어">언어</option>
              <option value="취미">취미</option>
            </select>
          </div>
          <div class="box2">
            <select name="categories[]" class="selectbox tags">
              <option value="" hidden selected>태그 3</option>
              <option value="운동">운동</option>
              <option value="공부">공부</option>
              <option value="자유">자유</option>
              <option value="토론">토론</option>
              <option value="언어">언어</option>
              <option value="취미">취미</option>
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

      <div class="input-field">
        <div class="input-kind">모임 배경 이미지</div>
        <div style="margin-top: 10px; margin-left: 30px; text-align: left;">
          <input type="file" name="imageUrl" accept="image/jpeg,.png">
        </div>
      </div>

      <div class="box-button">
        <input type="submit" value="모임 시작하기" class="submitbox">
      </div>
    </form>
  </div>
</div>
</body>

<script>
  // 요일 및 시간 추가 함수
  function addDay() {
    const container = document.getElementById('daysContainer');
    const div = document.createElement('div');
    div.innerHTML = `
    	<select name="days[]" class="selectbox" required style="display: inline-block;">
    	    <option disabled selected hidden>요일</option>
    	    <option value="월">월</option>
    	    <option value="화">화</option>
    	    <option value="수">수</option>
    	    <option value="목">목</option>
    	    <option value="금">금</option>
    	    <option value="토">토</option>
    	    <option value="일">일</option>
    	  </select>
    	  <div style="display: inline-block; margin-left: 10px;">모임 시간:
    	  <input type="time" class="timebox" name="startTimes[]" required>
    	   ~
    	  <input type="time" class="timebox" name="endTimes[]" required></div>
          <button type="button" onclick="this.parentElement.remove(); dayCount--; checkDayCount();" style="margin-left: 10px;">삭제</button>
        `;
        container.appendChild(div);
        dayCount++;
  }
</script>
</html>
