<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="initial-scale=1, width=device-width">
  	<title>회원가입</title>
    <link rel="stylesheet" href="css/global.css" />
  	<link rel="stylesheet" href="css/signup.css" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;800&display=swap" />
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lexend Deca:wght@400&display=swap" />
    <script src="signup.js"></script>
</head>
<body>
  	<div class="div">
    	<div class="header">
            <div class="container">
                <div class="web-logo">
                    <img class="logo" alt="" src="media/Icon.svg">
                    <div class="logo-text">Project</div>
                </div>
                <div class="nav" style="display:none;">
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
            <div class="title-field">
                <div class="title-text">회원가입</div>
            </div>
            <form method="post" action='user/signup' onsubmit="return formCheck()">
                <div class="input-field">
                    <div class="input-kind">이메일</div>
                    <div class="box">
                    <input type="text" class="mailbox" name="email" required placeholder="이메일"/>
                    <div style="margin-top: 7px; display: inline-block;">&nbsp;@</div>
                    <select name="emailDomain" class="mailbox" id="emailDomain" style="width: 150px; height: 35px;" required>
                    	<option disabled hidden selected>선택하세요</option>
                    	<option value="naver.com">naver.com</option>
                    	<option value="gmail.com">gmail.com</option>
                    	<option value="dgu.ac.kr">dgu.ac.kr</option>
                    </select>
                    <div class="input-guide"></div>
                </div>

                <div class="input-field">
                    <div class="input-kind">비밀번호</div>
                    <div class="box">
                        <input type="password" name="password" id="userPw" class="inputbox" placeholder="비밀번호를 입력하세요" onblur="isValidPw()"></div>
                    <div class="input-guide">8~20자 영문 대,소문자/숫자 비밀번호 입력</div>
                    <div class="box">
                        <input type="password" name="confirmPassword" id="pwCheck" class="inputbox" placeholder="비밀번호 확인" onblur="checkPw()"></div>
                    <div class="input-guide"></div>
                </div>

                <div class="input-field">
                    <div class="input-kind">이름</div>
                    <div class="box">
                    <input type="text" name="name" class="inputbox" placeholder="이름을 입력하세요" required></div>
                </div>

                <div class="input-field">
                    <div class="input-kind">학교</div>
                    <div class="box">
                    <input type="text" name="univ" class="inputbox" placeholder="대학교를 입력하세요" required></div>
                </div>

                <div class="input-field">
                    <div class="input-kind">전공</div>
                    <div class="box">
                    <input type="text" name="major" class="inputbox" placeholder="학과(부)를 입력하세요" required></div>
                </div>

                <div class="input-field">
                    <div class="input-kind">학년</div>
                    <div class="box">
                        <select name="grade" id="grade" class="inputbox">
                            <option disabled hidden selected>선택하세요</option>
                            <option value="1">1학년</option>
                            <option value="2">2학년</option>
                            <option value="3">3학년</option>
                            <option value="4">4학년</option>
                        </select>
                    </div>
                </div>

                <div class="input-field">
                    <div class="input-kind">취미</div>
                    <div class="box">
                    <input type="text" name="hobby" class="inputbox" placeholder="취미를 입력하세요" required></div>
                </div>

                <div class="input-field">
                    <div class="input-kind">소개</div>
                    <div class="box-large">
                    <textarea name="introduction" class="textbox" placeholder="소개를 입력하세요" required></textarea></div>
                </div>

                <div class="submit-field">
                    <div class="button">
                    <input type="submit" name="signup" value="회원가입" class="submit"></div>
                </div>
            </form>
  	    </div>
    </div>
</body>
</html>