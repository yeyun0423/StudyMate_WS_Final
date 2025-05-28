let memberCount = 2;
let recommendedFriendCount = 0;
let subjectSelected = false;

function increaseMember() {
    if (!subjectSelected) {
        showToast("먼저 과목을 선택하세요.");
        return;
    }

    const maxAllowed = recommendedFriendCount + 1;
    if (memberCount >= maxAllowed) {
        showToast(`추천 친구가 ${recommendedFriendCount}명이므로 최대 ${maxAllowed}명까지 가능합니다.`);
        return;
    }

    memberCount++;
    document.getElementById("memberCount").textContent = memberCount;

    // 친구 체크박스 전부 해제
    document.querySelectorAll(".friendCheckbox:checked").forEach(cb => cb.checked = false);

    updateCheckboxLimit();
}


function decreaseMember() {
    if (!subjectSelected) {
        showToast("먼저 과목을 선택하세요.");
        return;
    }

    if (memberCount > 2) {
        memberCount--;
        document.getElementById("memberCount").textContent = memberCount;

        // 체크된 친구 전부 해제
        document.querySelectorAll(".friendCheckbox:checked").forEach(cb => cb.checked = false);

        updateCheckboxLimit();
    }
}

function fetchRecommendedFriends() {
    const subjectSelect = document.getElementById("subjectSelect");
    const subject = subjectSelect.value;
    const container = document.getElementById("recommendedContainer");
    const warningMessage = document.getElementById("warningMessage");
    const createBtn = document.getElementById("createBtn");
    const joinedMsg = document.getElementById("alreadyJoinedMsg");

    if (!subject) {
        warningMessage.textContent = "과목을 선택해주세요.";
        subjectSelected = false;
        return;
    }

    warningMessage.textContent = "";
    subjectSelected = true;
    memberCount = 2;
    document.getElementById("memberCount").textContent = memberCount;

    fetch(`getRecommendedFriends?subject=${encodeURIComponent(subject)}`)
        .then(response => response.json())
        .then(data => {
            if (data.selfJoined) {
                createBtn.disabled = true;
                joinedMsg.style.display = "inline";
            } else {
                createBtn.disabled = false;
                joinedMsg.style.display = "none";
            }

            container.innerHTML = "";
            recommendedFriendCount = 0;

            if (!data.friends || data.friends.length === 0) {
                container.innerHTML = '<p class="text-muted">추천할 친구가 없습니다.</p>';
                return;
            }

            const list = document.createElement("div");
            list.className = "list-group";

            data.friends.forEach(friend => {
                const item = document.createElement("label");
                item.className = "list-group-item d-flex justify-content-between align-items-center";

                const nameSpan = document.createElement("span");
                nameSpan.textContent = `${friend.name} (${friend.userId})`;

                const checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.className = "form-check-input friendCheckbox";
                checkbox.value = friend.userId;

                if (friend.joined) {
                    checkbox.disabled = true;
                    nameSpan.innerHTML += " <span class='badge bg-secondary ms-2'>참여중</span>";
                } else {
                    recommendedFriendCount++;
                }

                item.appendChild(nameSpan);
                item.appendChild(checkbox);
                list.appendChild(item);
            });

            container.appendChild(list);
            bindFriendCheckboxLimit();
        })
        .catch(error => {
            console.error("추천 친구 오류:", error);
            container.innerHTML = '<p class="text-danger">추천 친구를 불러오는 중 오류가 발생했습니다.</p>';
        });
}

function bindFriendCheckboxLimit() {
    const checkboxes = document.querySelectorAll(".friendCheckbox:not(:disabled)");

    checkboxes.forEach(cb => {
        cb.addEventListener("change", () => {
            if (!subjectSelected || memberCount < 2) {
                cb.checked = false;
                showToast("먼저 과목과 인원 수를 선택하세요.");
                return;
            }

            const checked = document.querySelectorAll(".friendCheckbox:checked");
            const maxSelectable = memberCount - 1;

            if (checked.length >= maxSelectable) {
                checkboxes.forEach(c => {
                    if (!c.checked) c.disabled = true;
                });
            } else {
                checkboxes.forEach(c => c.disabled = false);
            }
        });
    });
}

function updateCheckboxLimit() {
    const checkboxes = document.querySelectorAll(".friendCheckbox:not(:disabled)");
    const checked = document.querySelectorAll(".friendCheckbox:checked");
    const maxSelectable = memberCount - 1;

    if (checked.length >= maxSelectable) {
        checkboxes.forEach(c => {
            if (!c.checked) c.disabled = true;
        });
    } else {
        checkboxes.forEach(c => c.disabled = false);
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

    if (checked.length > memberCount - 1) {
        alert(`총 ${memberCount}명이 스터디 그룹에 참여해야 합니다.\n선택할 수 있는 친구는 최대 ${memberCount - 1}명입니다.`);
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

function showToast(message) {
    const targetButton = document.getElementById("createBtn");
    const parent = targetButton.parentElement;
    parent.style.position = "relative";

    const toast = document.createElement("div");
    toast.className = "toast text-white bg-danger border-0 position-absolute top-0 start-50 translate-middle-x";
    toast.role = "alert";
    toast.ariaLive = "assertive";
    toast.ariaAtomic = "true";
    toast.style.zIndex = "9999";
    toast.style.minWidth = "200px";

    toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">${message}</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;

    parent.appendChild(toast);
    const toastInstance = new bootstrap.Toast(toast);
    toastInstance.show();

    setTimeout(() => {
        toast.remove();
    }, 3000);
}
