<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>그룹 생성</title>
</head>
<body>
<h1>그룹 생성</h1>
<form method="POST" action="/groupCreate">
  <label>제목:</label>
  <input type="text" name="title" required><br>

  <label>카테고리:</label>
  <input type="text" name="category" required><br>

  <label>설명:</label>
  <textarea name="description" required></textarea><br>

  <label>이미지 URL:</label>
  <input type="text" name="imageUrl"><br>

  <label>최대 인원:</label>
  <input type="number" name="maxMembers" required><br>

  <h3>운영 요일</h3>
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
  <button type="button" onclick="addDay()">추가</button>
  <div id="daysContainer"></div>

  <button type="submit">생성</button>
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
</body>
</html>
