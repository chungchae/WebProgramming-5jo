let dayCount = 1;

function checkForm() {
    if (!checkDay()) {
        return false;
    }
    if (!checkTag()) {
        return false;
    }
    const groupName = document.querySelector("input[name='title']").value;
    const maxMember = document.querySelector("input[name='maxMembers']").value;
    const intro = document.querySelector("textarea[name='description']").value;

    if (!groupName || !maxMember || !intro) {
        alert("모든 항목을 작성하세요");
        return false;
    }

    return true;
}

function checkDay() {
    const days = document.querySelectorAll("[name='days[]']");
    const startTimes = document.querySelectorAll("[name='startTimes[]']");
    const endTimes = document.querySelectorAll("[name='endTimes[]']");

    for (let i = 0; i < days.length; i++) {
        const day = days[i];
        const start = startTimes[i].value;
        const end = endTimes[i].value;

        if (day.selectedIndex === 0 || !start || !end) {
            alert("모든 요일과 시간을 입력하세요");
            return false;
        }

        if (start >= end) {
            alert("시작 시간이 종료 시간보다 늦을 수 없습니다");
            return false;
        }
    }

    return true;
}

function checkTag() {
    const tags = document.querySelectorAll(".tags");
    const selectedIndexes = Array.from(tags).map(tag => tag.selectedIndex);

    if (selectedIndexes.every(index => index === 0)) {
        alert("태그를 하나 이상 선택하세요");
        return false;
    }

    const uniqueTags = new Set(selectedIndexes.filter(index => index !== 0));
    if (uniqueTags.size !== selectedIndexes.filter(index => index !== 0).length) {
        alert("태그를 중복으로 선택할 수 없습니다");
        return false;
    }

    return true;
}

function addDay() {
    const container = document.getElementById("daysContainer");
    const dayCountLimit = 5; // 최대 추가 가능한 요일 수

    if (dayCount >= dayCountLimit) {
        alert(`최대 ${dayCountLimit}개의 모임 시간을 추가할 수 있습니다`);
        return;
    }

    const div = document.createElement("div");
    div.innerHTML = `
	<select name="days[]" class="selectbox" required style="display: inline-block;">
	    <option disabled selected hidden>요일</option>
	    <option value="월">월</option>
	    <option value="화">화</option>
	    <option value="수">수</option>
	    <option value="목">목</option>
	    <option value="금">금</option>
	    <option value="토">토</option>
	    <option value="일">일</option>
	  </select>
	  <div style="display: inline-block; margin-left: 10px;">모임 시간:
	  <input type="time" class="timebox" name="startTimes[]" required>
	   ~
	  <input type="time" class="timebox" name="endTimes[]" required></div>
      <button type="button" onclick="this.parentElement.remove(); dayCount--; checkDayCount();">삭제</button>
    `;
    container.appendChild(div);
    dayCount++;
}

function checkDayCount() {
    if (dayCount <= 0) {
        dayCount = 1;
    }
}
