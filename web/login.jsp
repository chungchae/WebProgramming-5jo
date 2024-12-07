<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>로그인</title>
    <link rel="stylesheet"  href="./global.css" />
    <link rel="stylesheet"  href="./login.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
</head>
<body>
<div class="div">
    <div class="header">
        <div class="container">
            <div class="web-logo">
                <a href="/main">
                    <img class="logo" alt="" src="media/Icon.svg">
                    <div class="logo-text">Project</div>
                </a>
            </div>
            <div class="nav" style="display: none;">
                <div class="haeding-name">
                    <div class="nav-component">
                        <div class="label">새 모임 만들기</div>
                    </div>
                    <div class="nav-component">
                        <div class="label">모임 둘러보기</div>
                    </div>
                    <div class="nav-component">
                        <div class="label">마이페이지</div>
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

    <div class="background">
        <div class="title">
            <div class="title-text">로그인</div>
        </div>
        <form action='user/login' method='post'>
            <div class="input-box-email">
                <div class="box"></div>
                <input type="email" name="email" placeholder="이메일을 입력하세요" class="inputbox" />
            </div>

            <div class="input-box-password">
                <div class="box"></div>
                <input type="password" name="password" placeholder="비밀번호를 입력하세요" class="inputbox" />
            </div>

            <div class="remember-account">
                <input type="checkbox" name="remember" class="checkbox">
                <div class="remember-account-text">회원정보 기억하기</div>
                <a href="./signup.jsp" class="signup-link">회원가입</a>
            </div>

            <div class="input-box-submit">
                <div class="button"></div>
                <input type="submit" name="login" value="로그인하기" class="submit" />
            </div>
        </form>
    </div>
</div>
</body>
</html>
