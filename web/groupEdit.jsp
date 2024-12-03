<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.Day" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>그룹 수정</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/groupCreate.css">
</head>
<body>
<div class="div">
  <h1 class="title">그룹 수정</h1>
  <%
    Group group = (Group) request.getAttribute("group");
    List<String> categories = (List<String>) request.getAttribute("categories");
    List<Day> days = (List<Day>) request.getAttribute("days");

    if (group != null) {
  %>
  <form method="POST" action="<%= request.getContextPath() %>/groupUpdate" class="form-container">
    <input type="hidden" name="id" value="<%= group.getId() %>">

    <!-- 제목 -->
    <div class="input-field">
      <label class="input-kind">제목:</label>
      <div class="box1">
        <input type="text" name="title" value="<%= group.getTitle() %>" class="inputbox" required>
      </div>
    </div>

    <!-- 카테고리 -->
    <div class="input-field">
      <label class="input-kind">카테고리:</label>
      <div class="category-group">
        <% for (int i = 0; i < 3; i++) { %>
        <select name="categories[]" class="selectbox">
          <option value="" disabled hidden <%= categories != null && categories.size() > i ? "" : "selected" %>>카테고리를 선택하세요</option>
          <option value="운동" <%= categories != null && categories.contains("운동") && categories.indexOf("운동") == i ? "selected" : "" %>>운동</option>
          <option value="공부" <%= categories != null && categories.contains("공부") && categories.indexOf("공부") == i ? "selected" : "" %>>공부</option>
          <option value="자유" <%= categories != null && categories.contains("자유") && categories.indexOf("자유") == i ? "selected" : "" %>>자유</option>
          <option value="토론" <%= categories != null && categories.contains("토론") && categories.indexOf("토론") == i ? "selected" : "" %>>토론</option>
          <option value="언어" <%= categories != null && categories.contains("언어") && categories.indexOf("언어") == i ? "selected" : "" %>>언어</option>
          <option value="취미" <%= categories != null && categories.contains("취미") && categories.indexOf("취미") == i ? "selected" : "" %>>취미</option>
        </select>
        <% } %>
      </div>
    </div>

    <!-- 설명 -->
    <div class="input-field">
      <label class="input-kind">설명:</label>
      <div class="box4">
        <textarea name="description" class="textbox" required><%= group.getDescription() %></textarea>
      </div>
    </div>

    <!-- 이미지 URL -->
    <div class="input-field">
      <label class="input-kind">이미지 URL:</label>
      <div class="box1">
        <input type="text" name="imageUrl" value="<%= group.getImageUrl() %>" class="inputbox">
      </div>
    </div>

    <!-- 최대 인원 -->
    <div class="input-field">
      <label class="input-kind">최대 인원:</label>
      <div class="box1">
        <input type="number" name="maxMembers" value="<%= group.getMaxMembers() %>" class="inputbox" required>
      </div>
    </div>

    <!-- 운영 시간 -->
    <div class="input-field">
      <label class="input-kind">운영 시간:</label>
      <div id="daysContainer">
        <% if (days != null && !days.isEmpty()) { %>
        <% for (Day day : days) { %>
        <div class="day-field">
          <label>요일:</label>
          <select name="days[]" class="selectbox" required>
            <option value="월" <%= "월".equals(day.getDay()) ? "selected" : "" %>>월</option>
            <option value="화" <%= "화".equals(day.getDay()) ? "selected" : "" %>>화</option>
            <option value="수" <%= "수".equals(day.getDay()) ? "selected" : "" %>>수</option>
            <option value="목" <%= "목".equals(day.getDay()) ? "selected" : "" %>>목</option>
            <option value="금" <%= "금".equals(day.getDay()) ? "selected" : "" %>>금</option>
            <option value="토" <%= "토".equals(day.getDay()) ? "selected" : "" %>>토</option>
            <option value="일" <%= "일".equals(day.getDay()) ? "selected" : "" %>>일</option>
          </select>
          <label>시작 시간:</label>
          <input type="time" name="startTimes[]" value="<%= day.getStartTime() %>" required>
          <label>종료 시간:</label>
          <input type="time" name="endTimes[]" value="<%= day.getEndTime() %>" required>
          <button type="button" onclick="this.parentElement.remove()">삭제</button>
        </div>
        <% } %>
        <% } else { %>
        <div class="day-field">
          <label>요일:</label>
          <select name="days[]" class="selectbox" required>
            <option value="월">월</option>
            <option value="화">화</option>
            <option value="수">수</option>
            <option value="목">목</option>
            <option value="금">금</option>
            <option value="토">토</option>
            <option value="일">일</option>
          </select>
          <label>시작 시간:</label>
          <input type="time" name="startTimes[]" required>
          <label>종료 시간:</label>
          <input type="time" name="endTimes[]" required>
        </div>
        <% } %>
      </div>
      <button type="button" onclick="addDay()" class="add-day-button">+ 추가</button>
    </div>

    <!-- 저장 버튼 -->
    <div class="box-button">
      <button type="submit" class="submitbox">저장</button>
    </div>
  </form>

  <script>
    function addDay() {
      const container = document.getElementById('daysContainer');
      const div = document.createElement('div');
      div.className = 'day-field';
      div.innerHTML = `
        <label>요일:</label>
        <select name="days[]" class="selectbox" required>
          <option value="월">월</option>
          <option value="화">화</option>
          <option value="수">수</option>
          <option value="목">목</option>
          <option value="금">금</option>
          <option value="토">토</option>
          <option value="일">일</option>
        </select>
        <label>시작 시간:</label>
        <input type="time" name="startTimes[]" required>
        <label>종료 시간:</label>
        <input type="time" name="endTimes[]" required>
        <button type="button" onclick="this.parentElement.remove()">삭제</button>
      `;
      container.appendChild(div);
    }
  </script>
  <%
  } else {
  %>
  <p>그룹 정보를 찾을 수 없습니다.</p>
  <%
    }
  %>
</div>
</body>
</html>
