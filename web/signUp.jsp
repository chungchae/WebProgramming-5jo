<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
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
        }
        input, select {
            width: 100%;
            padding: 8px;
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
        }
    </style>
</head>
<body>
<div class="container">
    <h1>회원가입</h1>
    <form action="user/signup" method="POST">
        <!-- 이메일 입력 -->
        <label for="email">이메일</label>
        <input type="text" id="email" name="email" required placeholder="이메일을 입력하세요">

        <label for="emailDomain">이메일 도메인</label>
        <input type="text" id="emailDomain" name="emailDomain" required placeholder="예: gmail.com">

        <!-- 비밀번호 입력 -->
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">

        <label for="confirmPassword">비밀번호 확인</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="비밀번호를 다시 입력하세요">

        <!-- 이름 입력 -->
        <label for="name">이름</label>
        <input type="text" id="name" name="name" required placeholder="이름을 입력하세요">

        <!-- 학교 입력 -->
        <label for="univ">학교</label>
        <input type="text" id="univ" name="univ" required placeholder="학교 이름을 입력하세요">

        <label>학년</label>
        <input type="number" name="grade" required><br>

        <!-- 전공 입력 -->
        <label for="major">전공</label>
        <input type="text" id="major" name="major" required placeholder="전공을 입력하세요">

        <!-- 취미 입력 -->
        <label for="hobby">취미</label>
        <input type="text" id="hobby" name="hobby" required placeholder="취미를 입력하세요">

        <!-- 자기소개 입력 -->
        <label for="introduction">자기소개</label>
        <textarea id="introduction" name="introduction" rows="4" required placeholder="자기소개를 입력하세요"></textarea>

        <!-- 제출 버튼 -->
        <button type="submit">회원가입</button>
    </form>
</div>

</body>
</html>