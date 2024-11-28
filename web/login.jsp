<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 100%;
            max-width: 400px;
            margin: 100px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>로그인</h1>
    <form action="user/login" method="POST">
        <!-- 이메일 입력 -->
        <label for="email">이메일</label>
        <input type="text" id="email" name="email" required placeholder="이메일을 입력하세요">

        <!-- 비밀번호 입력 -->
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">

        <!-- 로그인 버튼 -->
        <button type="submit">로그인</button>
    </form>
    <p style="text-align: center; margin-top: 15px;">
        <a href="signup.jsp">회원가입</a>
    </p>
</div>
</body>
</html>