let randomCount = 2;

// 모달 열기
document.getElementById("randomBtn").addEventListener("click", function () {
    const modal = new bootstrap.Modal(document.getElementById("randomStudyModal"));
    modal.show();
});

// 인원 수 증가
function increaseRandomMember() {
    randomCount++;
    document.getElementById("randomMemberCount").innerText = randomCount;
}

// 인원 수 감소
function decreaseRandomMember() {
    if (randomCount > 2) {
        randomCount--;
        document.getElementById("randomMemberCount").innerText = randomCount;
    }
}

// 랜덤 스터디 그룹 생성
function generateRandomStudyGroup() {
    const subject = document.getElementById("randomSubject").value;

    if (!subject) {
        alert("과목을 선택해주세요.");
        return;
    }

    alert(`랜덤 스터디 그룹이 생성되었습니다!\n과목: ${subject}\n인원: ${randomCount}`);
    console.log(`랜덤 그룹 생성 요청 - 과목: ${subject}, 인원 수: ${randomCount}`);

    const modal = bootstrap.Modal.getInstance(document.getElementById("randomStudyModal"));
    modal.hide();
}
