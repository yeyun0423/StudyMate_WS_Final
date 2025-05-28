let memberCount = 1;  // 인원 수 초기값

function increaseMember() {
    memberCount++;
    document.getElementById("memberCount").textContent = memberCount;
}

function decreaseMember() {
    if (memberCount > 1) {
        memberCount--;
        document.getElementById("memberCount").textContent = memberCount;
    }
}

function createStudyGroup() {
    const subjectSelect = document.getElementById("subjectSelect");
    const subject = subjectSelect ? subjectSelect.value : null;
    const checked = Array.from(document.querySelectorAll(".friendCheckbox:checked")).map(el => el.value);

    if (!subject) {
        alert("과목을 선택하세요!");
        return;
    }

    if (checked.length === 0) {
        alert("추천 친구를 1명 이상 선택하세요!");
        return;
    }

    const params = new URLSearchParams();
    params.append("command", "createStudy");
    params.append("subject", subject);
    params.append("max_members", memberCount);
    checked.forEach(friend => params.append("friends[]", friend));

    fetch("StudyGroupServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: params.toString()
    })
    .then(res => res.text())
    .then(msg => alert(msg))
    .catch(err => {
        console.error("스터디 생성 실패:", err);
        alert("스터디 생성 중 오류가 발생했습니다.");
    });
}
