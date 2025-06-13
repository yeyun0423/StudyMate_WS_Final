function checkDuplicateId() {
    const userId = document.getElementById("userId").value;
    if (!userId) {
        alert("아이디를 입력하세요.");
        return;
    }

    fetch("check-id?userId=" + encodeURIComponent(userId))
        .then(response => response.text())
        .then(result => {
            const msg = document.getElementById("idCheckResult");
            if (result === "exists") {
                msg.style.color = "red";
                msg.innerText = "이미 사용 중인 아이디입니다.";
            } else {
                msg.style.color = "green";
                msg.innerText = "사용 가능한 아이디입니다.";
            }
        })
        .catch(err => {
            alert("오류가 발생했습니다.");
            console.error(err);
        });
}
