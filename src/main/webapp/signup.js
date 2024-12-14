function isValidPw() {
    const regExp = /[^0-9a-zA-Z]/g;
    var userPw = document.getElementById("userPw").value;
    var inputGuide = document.getElementsByClassName("input-guide");

    if (userPw == "" || userPw.length < 8 || userPw.length > 20) {
        inputGuide[1].innerHTML="8~20자 영문 대,소문자/숫자 비밀번호 입력";
        inputGuide[1].style.color = "red";
        return false;
    }
    if (regExp.test(userPw)) {
        inputGuide[1].innerHTML="사용 불가능한 문자를 포함하고 있습니다";
        inputGuide[1].style.color = "red";W
        return false;
    } 
    inputGuide[1].innerHTML = "";
    return true;
}
function checkPw() {
    var userPw = document.getElementById("userPw").value;
    var pwCheck = document.getElementById("pwCheck").value;
    var inputGuide = document.getElementsByClassName("input-guide");
    if (userPw != pwCheck) {
        inputGuide[2].innerHTML = "비밀번호가 다릅니다";
        inputGuide[2].style.color = "red";
        return false;
    }
    else {
        inputGuide[2].innerHTML = "";
        return true;
    }
}
function formCheck() {
    var sel1 = document.getElementById("grade");
	var sel2 = document.getElementById("emailDomain");
    var grade = sel1.selectedIndex;
	var domain = sel2.selectedIndex;
	
    if (isValidPw() == false || checkPw() == false) {
        alert("비밀번호를 확인하세요");
        return false;
    }

    if (grade == 0 || domain == 0) {
        alert("모든 항목을 입력해주세요")
        return false;
    }
    return true;
}