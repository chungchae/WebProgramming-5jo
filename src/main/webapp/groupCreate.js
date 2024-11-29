var day_cnt = 1;

function checkForm() {
    if (checkDay() == false) {
        return false;
    }
    if (checkTag() == false) {
        return false;
    }
    if (groupName == "" || maxMember =="" || intro == "") {
        alert("모든 항목을 작성하세요");
        return false;
    }
    else return true;
}

function checkDay() {
    const day1 = document.getElementById("day1");
    const day2 = document.getElementById("day2");
    const day3 = document.getElementById("day3");
    const start1 = document.getElementById("start1").value;
    const start2 = document.getElementById("start2").value;
    const start3 = document.getElementById("start3").value;
    const end1 = document.getElementById("end1").value;
    const end2 = document.getElementById("end2").value;
    const end3 = document.getElementById("end3").value;

    if (day1.selectedIndex == 0 || !start1 || !end1) {
        alert("모든 항목을 작성하세요");
        return false;
    }

    if (day2.selectedIndex != 0) {
        if (!start2 || !end2) {
            alert("모임 시간을 입력하세요");
            return false;
        }
    }
    
    if (day3.selectedIndex != 0) {
        if (!start3 || !end3) {
            alert("모임 시간을 입력하세요");
            return false;
        }
    }
    
    if (start1 > end1 || start2 > end2 || start3 > end3) {
        alert("모임 시간을 확인하세요");
        return false;
    }

    return true;
    
}

function checkTag() {
    const tags = document.getElementsByClassName("tags");
    const idx1 = tags[0].selectedIndex;
    const idx2 = tags[1].selectedIndex;
    const idx3 = tags[2].selectedIndex;

    if (idx1 == 0 && idx2 == 0 && idx3 == 0) {
        alert("태그를 하나 이상 선택하세요");
        return false;
    }
    if (idx1 == idx2 && idx1 != 0) {
        alert("태그를 중복으로 선택할 수 없습니다");
        return false;
    }
    if (idx2 == idx3 && idx2 != 0) {
        alert("태그를 중복으로 선택할 수 없습니다");
        return false;
    }
    if (idx3 == idx1 && idx3 != 0) {
        alert("태그를 중복으로 선택할 수 없습니다");
        return false;
    }
    return true;
}

function addDay() {
    var days = document.getElementsByClassName("days");
    if (day_cnt == 1) {
        days[1].classList.remove('hidden');
        day_cnt++;
    }
    else if (day_cnt == 2)  {
        days[2].classList.remove('hidden');
        day_cnt++;
    }
}