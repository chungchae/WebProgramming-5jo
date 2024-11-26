<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>모임 검색</title>
</head>
<body>
<h1>모임 검색</h1>
<form method="GET" action="/groupSearch">
    <label>모임 타입:</label>
    <input type="text" name="groupType" required><br>
    <label>모임 이름:</label>
    <input type="text" name="groupName" required><br>
    <button type="submit">검색</button>
</form>
</body>
</html>
