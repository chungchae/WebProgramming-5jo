<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.Day" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title style="color: black;">그룹 수정</title>
  <link rel="stylesheet" href="./global.css" />
  <link rel="stylesheet" href="/groupCreate.css?after">
</head>
<body>

<div class="div">
  <%
    Group group = (Group) request.getAttribute("group");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<Day> days = (List<Day>) request.getAttribute("days");
  %>
  <div class="header">
    <div class="container">
      <a href="<%= request.getContextPath() %>/main">
        <div class="web-logo">
          <img class="logo" alt="" src="<%= request.getContextPath() %>/media/Icon.svg">
          <div class="logo-text">Project</div>
        </div>
      </a>
      <div class="nav">
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
  <div class="background-image-area"></div>
  <div class="background">
    <div class="intro">
      <img class="check-icon" alt="" src="<%= request.getContextPath() %>/media/icon-check.png">
      <div class="intro-text">모임 정보 수정</div>
    </div>
    <form method="POST" action="<%= request.getContextPath() %>/groupUpdate">
      <input type="hidden" name="id" value="<%= group.getId() %>">

      <div class="input-field">
        <div class="input-kind">모임 이름</div>
        <div class="box1">
          <input type="text" name="title" class="inputbox" value="<%= group.getTitle() %>">
        </div>
      </div>

      <div class="input-field">
        <div class="input-kind">모임 인원</div>
        <div class="box1">
          <input name="maxMembers" class="inputbox" value="<%= group.getMaxMembers() %>" min="3" max="15">
        </div>
      </div>

      <div class="input-field days">
        <div class="input-kind">모임 시간
          <button type="button" class="plus-button" onclick="addDay()" style="margin-left:425px; height: 25px;"></button>
        </div>
        <div id="daysContainer" style="margin-left: 25px; width: 600px;">
          <% if (days != null && !days.isEmpty()) { %>
          <% for (Day day : days) { %>
          <div class="day-field">
            <select name="days[]" class="selectbox" required>
              <option value="월" <%= "월".equals(day.getDay()) ? "selected" : "" %>>월</option>
              <option value="화" <%= "화".equals(day.getDay()) ? "selected" : "" %>>화</option>
              <option value="수" <%= "수".equals(day.getDay()) ? "selected" : "" %>>수</option>
              <option value="목" <%= "목".equals(day.getDay()) ? "selected" : "" %>>목</option>
              <option value="금" <%= "금".equals(day.getDay()) ? "selected" : "" %>>금</option>
              <option value="토" <%= "토".equals(day.getDay()) ? "selected" : "" %>>토</option>
              <option value="일" <%= "일".equals(day.getDay()) ? "selected" : "" %>>일</option>
            </select>
            <div style="display: inline-block; margin-left: 10px;">
              <input type="time" class="timebox" name="startTimes[]" value="<%= day.getStartTime() %>" required>
              ~
              <input type="time" class="timebox" name="endTimes[]" value="<%= day.getEndTime() %>" required>
            </div>
            <button type="button" onclick="this.parentElement.remove()" class="delete-day-button">삭제</button>
          </div>
          <% } %>
          <% } %>
        </div>
      </div>

      <div class="input-field">
        <div class="input-kind">태그(최대 3개)</div>
        <div class="wrapper">
          <% for (int i = 0; i < 3; i++) { %>
          <div class="box2">
            <select name="categories[]" class="selectbox tags">
              <option value="" <%= categories != null && categories.size() > i ? "" : "selected" %>>태그 선택</option>
              <option value="운동" <%= categories != null && categories.contains("운동") && categories.indexOf("운동") == i ? "selected" : "" %>>운동</option>
              <option value="공부" <%= categories != null && categories.contains("공부") && categories.indexOf("공부") == i ? "selected" : "" %>>공부</option>
              <option value="자유" <%= categories != null && categories.contains("자유") && categories.indexOf("자유") == i ? "selected" : "" %>>자유</option>
              <option value="토론" <%= categories != null && categories.contains("토론") && categories.indexOf("토론") == i ? "selected" : "" %>>토론</option>
              <option value="언어" <%= categories != null && categories.contains("언어") && categories.indexOf("언어") == i ? "selected" : "" %>>언어</option>
              <option value="취미" <%= categories != null && categories.contains("취미") && categories.indexOf("취미") == i ? "selected" : "" %>>취미</option>
            </select>
          </div>
          <% } %>
        </div>
      </div>

      <div class="input-field">
        <div class="input-kind">모임 설명</div>
        <div class="box4">
          <textarea placeholder="모임 설명을 입력하세요" name="description" class="textbox" required><%= group.getDescription() %></textarea>
        </div>
      </div>

      <div class="input-field">
        <div class="input-kind">모임 배경 이미지</div>
        <div style="margin-top: 10px; margin-left: 30px; text-align: left;">
          <input type="file" name="imageUrl" accept="image/jpeg,.png">
        </div>
      </div>

      <div class="box-button">
        <input type="submit" value="저장하기" class="submitbox">
      </div>
    </form>
  </div>
</div>
<script>
  function addDay() {
    const container = document.getElementById('daysContainer');
    const div = document.createElement('div');
    div.className = 'day-field';
    div.innerHTML = `
      <select name="days[]" class="selectbox" required>
        <option value="월">월</option>
        <option value="화">화</option>
        <option value="수">수</option>
        <option value="목">목</option>
        <option value="금">금</option>
        <option value="토">토</option>
        <option value="일">일</option>
      </select>
      <div style="display: inline-block; margin-left: 10px;">
        <input type="time" class="timebox" name="startTimes[]" required>
        ~
        <input type="time" class="timebox" name="endTimes[]" required>
      </div>
      <button type="button" onclick="this.parentElement.remove()" class="delete-day-button">삭제</button>
    `;
    container.appendChild(div);
  }
</script>
</body>
</html>
