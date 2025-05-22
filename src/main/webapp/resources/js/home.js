function createStudyGroup() {
    const subject = document.getElementById("subjectSelect").value;
    const checked = Array.from(document.querySelectorAll(".friendCheckbox:checked")).map(el => el.value);

    if (!subject || checked.length === 0) {
        alert("과목과 친구를 선택하세요!");
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
    .then(msg => alert(msg));
}
