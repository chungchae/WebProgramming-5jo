<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Group" %>
<%@ page import="model.Day" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
  <title>그룹 수정</title>
</head>
<body>
<h1>그룹 수정</h1>
<%
  Group group = (Group) request.getAttribute("group");
  List<String> categories = (List<String>) request.getAttribute("categories");
  List<Day> days = (List<Day>) request.getAttribute("days");

  if (group != null) {
%>
<form method="POST" action="<%= request.getContextPath() %>/groupUpdate">
  <input type="hidden" name="id" value="<%= group.getId() %>">

  <label>제목:</label>
  <input type="text" name="title" value="<%= group.getTitle() %>" required><br>

  <label>카테고리:</label>
  <div>
    <label>카테고리 1:</label>
    <select name="categories[]" required>
      <option value="" disabled hidden <%= categories != null && categories.size() > 0 ? "" : "selected" %>>카테고리를 선택하세요</option>
      <option value="운동" <%= categories != null && categories.contains("운동") ? "selected" : "" %>>운동</option>
      <option value="공부" <%= categories != null && categories.contains("공부") ? "selected" : "" %>>공부</option>
      <option value="자유" <%= categories != null && categories.contains("자유") ? "selected" : "" %>>자유</option>
      <option value="토론" <%= categories != null && categories.contains("토론") ? "selected" : "" %>>토론</option>
      <option value="언어" <%= categories != null && categories.contains("언어") ? "selected" : "" %>>언어</option>
      <option value="취미" <%= categories != null && categories.contains("취미") ? "selected" : "" %>>취미</option>
    </select><br>

    <label>카테고리 2:</label>
    <select name="categories[]">
      <option value="" disabled hidden <%= categories != null && categories.size() > 1 ? "" : "selected" %>>카테고리를 선택하세요</option>
      <option value="운동" <%= categories != null && categories.contains("운동") ? "selected" : "" %>>운동</option>
      <option value="공부" <%= categories != null && categories.contains("공부") ? "selected" : "" %>>공부</option>
      <option value="자유" <%= categories != null && categories.contains("자유") ? "selected" : "" %>>자유</option>
      <option value="토론" <%= categories != null && categories.contains("토론") ? "selected" : "" %>>토론</option>
      <option value="언어" <%= categories != null && categories.contains("언어") ? "selected" : "" %>>언어</option>
      <option value="취미" <%= categories != null && categories.contains("취미") ? "selected" : "" %>>취미</option>
    </select><br>

    <label>카테고리 3:</label>
    <select name="categories[]">
      <option value="" disabled hidden <%= categories != null && categories.size() > 2 ? "" : "selected" %>>카테고리를 선택하세요</option>
      <option value="운동" <%= categories != null && categories.contains("운동") ? "selected" : "" %>>운동</option>
      <option value="공부" <%= categories != null && categories.contains("공부") ? "selected" : "" %>>공부</option>
      <option value="자유" <%= categories != null && categories.contains("자유") ? "selected" : "" %>>자유</option>
      <option value="토론" <%= categories != null && categories.contains("토론") ? "selected" : "" %>>토론</option>
      <option value="언어" <%= categories != null && categories.contains("언어") ? "selected" : "" %>>언어</option>
      <option value="취미" <%= categories != null && categories.contains("취미") ? "selected" : "" %>>취미</option>
    </select>
  </div><br>

  <label>설명:</label>
  <textarea name="description" required><%= group.getDescription() %></textarea><br>

  <label>이미지 URL:</label>
  <input type="text" name="imageUrl" value="<%= group.getImageUrl() %>"><br>

  <label>최대 인원:</label>
  <input type="number" name="maxMembers" value="<%= group.getMaxMembers() %>" required><br>

  <h3>운영 시간</h3>
  <div id="daysContainer">
    <%
      if (days != null && !days.isEmpty()) {
        for (Day day : days) {
    %>
    <div>
      <label>요일:</label>
      <select name="days[]" required>
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
    <%
      }
    } else {
    %>
    <div>
      <label>요일:</label>
      <select name="days[]" required>
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
    <%
      }
    %>
  </div>
  <button type="button" onclick="addDay()">+ 추가</button><br>

  <button type="submit">저장</button>
</form>
<script>
  function addDay() {
    const container = document.getElementById('daysContainer');
    const div = document.createElement('div');
    div.innerHTML = `
      <label>요일:</label>
      <select name="days[]" required>
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
</body>
</html>
