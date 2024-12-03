<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // 세션에서 값 가져오기
  Long userId = (Long) session.getAttribute("userId"); // userId를 Long으로 가져옴
  String userMessage;

  if (userId == null) {
    userMessage = "Unknown User"; // 세션값이 없는 경우 기본 메시지 설정
  } else {
    userMessage = "User ID: " + userId; // 세션값이 있는 경우 해당 ID 표시
  }
%>
<html>
<head>
  <title>로그인 성공</title>
  <script>
    // JSP에서 가져온 세션 값을 JavaScript 변수로 전달
    const userMessage = "<%= userMessage %>";
    alert("환영합니다, " + userMessage + "!");
  </script>
</head>
<body>
<h1>5jo Web Service</h1>
<p>로그인에 성공하셨습니다. 환영합니다!</p>
</body>
</html>
