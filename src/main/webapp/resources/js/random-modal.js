
let randomCount = 2;
let availableFriendCount = 0;
let selfJoinedRandom = false;
let randomSubjectSelected = false;

// 모달 열기
document.getElementById("randomBtn").addEventListener("click", function () {
    const modal = new bootstrap.Modal(document.getElementById("randomStudyModal"));
    modal.show();
});

// 과목 변경 시 참여여부 및 가능 인원 확인
document.getElementById("randomSubject").addEventListener("change", function () {
    const subject = this.value;
    if (!subject) return;

    fetch(`getRecommendedFriends?subject=${encodeURIComponent(subject)}`)
        .then(res => res.json())
        .then(data => {
            selfJoinedRandom = data.selfJoined;
            availableFriendCount = data.friends.filter(f => !f.joined).length;
            randomSubjectSelected = true;

            const randomBtn = document.querySelector("#randomStudyModal .btn-primary");
            if (selfJoinedRandom) {
                randomBtn.disabled = true;
                alert("이미 참여 중인 과목입니다!");
            } else {
                randomBtn.disabled = false;
                const maxAllowed = availableFriendCount + 1;
                if (randomCount > maxAllowed) {
                    randomCount = maxAllowed;
                    document.getElementById("randomMemberCount").innerText = randomCount;
                }
            }

            // 인원 수 영역 활성화
            document.querySelectorAll("#randomStudyModal .btn-outline-secondary").forEach(btn => btn.disabled = false);
        });
});

// 인원 수 증가
function increaseRandomMember() {
    if (!randomSubjectSelected) {
        alert("먼저 과목을 선택하세요.");
        return;
    }

    const maxAllowed = availableFriendCount + 1;
    if (randomCount >= maxAllowed) {
        alert(`최대 ${maxAllowed}명까지 가능합니다.`);
        return;
    }
    randomCount++;
    document.getElementById("randomMemberCount").innerText = randomCount;
}

// 인원 수 감소
function decreaseRandomMember() {
    if (!randomSubjectSelected) {
        alert("먼저 과목을 선택하세요.");
        return;
    }

    if (randomCount > 2) {
        randomCount--;
        document.getElementById("randomMemberCount").innerText = randomCount;
    }
}

// 랜덤 스터디 그룹 생성
function generateRandomStudyGroup() {
    const subject = document.getElementById("randomSubject").value;

    if (!subject || selfJoinedRandom) {
        alert("올바른 과목을 선택해주세요.");
        return;
    }

    fetch("RandomStudyServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `subject=${encodeURIComponent(subject)}&memberCount=${randomCount}`
    })
    .then(res => res.text())
    .then(msg => {
        alert(msg);
        const modal = bootstrap.Modal.getInstance(document.getElementById("randomStudyModal"));
        modal.hide();
    })
    .catch(err => {
        console.error("랜덤 생성 오류:", err);
        alert("랜덤 스터디 생성 중 오류 발생");
    });
}

// 과목 선택 전엔 인원 수 버튼 비활성화
window.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll("#randomStudyModal .btn-outline-secondary").forEach(btn => btn.disabled = true);
});
