function modalOpen() {
    const modal = document.getElementById('modalContainer');
    modal.classList.remove('hidden');
}

function modalClose() {
    const modal = document.getElementById('modalContainer');
    modal.classList.add('hidden');
}

function checkForm() {
    const univ = document.getElementById("univ").value;
    const major = document.getElementById("major").value;
    const hobby = document.getElementById("hobby").value;
    const intro = document.getElementById("intro").value;

    if (univ == "" || major == "" || hobby == "" || intro == "") {
        alert("모든 항목을 입력해주세요")
        return false;
    }
    return true;

}