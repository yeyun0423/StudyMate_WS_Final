document.addEventListener("DOMContentLoaded", function () {
  const subjectFriendsMap = {
    linux: ['@yejin', '@jisu', '@taeho', '@eunwoo', '@eunwoo1', '@eunwoo2', '@eunwoo3', '@eunwoo4'],
    java: ['@minji', '@junsu', '@eunwoo'],
    network: ['@hyunsoo', '@ara', '@dongmin']
  };

  const subjectSelect = document.getElementById("subjectSelect");
  const recommendedUsersDiv = document.getElementById("recommendedUsers");
  const studyMembersInput = document.getElementById("studyMembers");

  const groupSizeInput = document.getElementById("groupSize");
  const modalSubjectSelect = document.getElementById("modalSubject");

  let lastValidMembers = 1;
  let lastValidGroupSize = 2;

  if (subjectSelect) {
    subjectSelect.addEventListener("change", function () {
      const selectedSubject = subjectSelect.value;
      recommendedUsersDiv.innerHTML = "";

      if (subjectFriendsMap[selectedSubject]) {
        const uniqueFriends = Array.from(new Set(subjectFriendsMap[selectedSubject]));

        for (let i = 0; i < uniqueFriends.length; i++) {
          const username = uniqueFriends[i];
          const id = `friend-${i}`;
          const wrapper = document.createElement("div");
          wrapper.className = "form-check";

          const checkbox = document.createElement("input");
          checkbox.type = "checkbox";
          checkbox.className = "form-check-input friend-check";
          checkbox.id = id;
          checkbox.name = "friends";
          checkbox.value = username;

          const label = document.createElement("label");
          label.className = "form-check-label";
          label.setAttribute("for", id);
          label.textContent = username;

          wrapper.appendChild(checkbox);
          wrapper.appendChild(label);
          recommendedUsersDiv.appendChild(wrapper);
        }
      }
    });
  }

  document.addEventListener("change", function () {
    const max = parseInt(studyMembersInput.value);
    if (isNaN(max)) return;

    const checkboxes = document.querySelectorAll(".friend-check");
    let checkedCount = 0;
    for (let i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked) checkedCount++;
    }
    for (let i = 0; i < checkboxes.length; i++) {
      if (!checkboxes[i].checked) {
        checkboxes[i].disabled = checkedCount >= max;
      }
    }
  });

  // ✅ 랜덤 스터디 버튼 클릭 시 유효성 검사
  const randomBtn = document.getElementById("createRandomStudy");
  if (randomBtn) {
    randomBtn.addEventListener("click", function () {
      const subject = modalSubjectSelect.value;
      const groupSize = parseInt(groupSizeInput.value);

      if (subject && groupSize && subject !== '과목 선택') {
        const maxFriends = subjectFriendsMap[subject]
          ? Array.from(new Set(subjectFriendsMap[subject])).length
          : 0;

        if (groupSize > maxFriends) {
          const toastBody = document.getElementById("toastBody");
          toastBody.textContent = "추천 인원 수보다 많은 인원입니다.";
          const toast = new bootstrap.Toast(document.getElementById("limitToast"));
          toast.show();
          return;
        }

        alert(subject + " 과목으로 " + groupSize + "명 랜덤 스터디 그룹이 생성되었습니다.");
        const modal = bootstrap.Modal.getInstance(document.getElementById('randomStudyModal'));
        modal.hide();
      } else {
        alert("모든 옵션을 선택해주세요.");
      }
    });
  }

  // ✅ 커스텀 스터디 제출
  const customForm = document.getElementById("customStudyForm");
  if (customForm) {
    customForm.addEventListener("submit", function (e) {
      e.preventDefault();
      const subject = subjectSelect.value;
      const members = parseInt(studyMembersInput.value);

      const maxFriends = subjectFriendsMap[subject]
        ? Array.from(new Set(subjectFriendsMap[subject])).length
        : 0;

      if (subject === '' || subject === '과목 선택') {
        alert("과목을 선택해주세요.");
        return;
      }

      if (members > maxFriends) {
        const toastBody = document.getElementById("toastBody");
        toastBody.textContent = "추천 인원 수보다 많이 설정할 수 없습니다.";
        const toast = new bootstrap.Toast(document.getElementById("limitToast"));
        toast.show();
        return;
      }

      alert(subject + " 과목으로 " + members + "명 스터디 그룹이 생성되었습니다.");
    });
  }

  // ✅ 커스텀 인원 수 입력 제한
  studyMembersInput.addEventListener("input", function () {
    const selectedSubject = subjectSelect.value;
    const maxFriends = subjectFriendsMap[selectedSubject]
      ? Array.from(new Set(subjectFriendsMap[selectedSubject])).length
      : 0;

    const inputValue = parseInt(studyMembersInput.value);
    if (isNaN(inputValue) || inputValue <= 0) {
      lastValidMembers = 1;
      return;
    }

    if (inputValue > maxFriends) {
      studyMembersInput.value = lastValidMembers;

      const toastBody = document.getElementById("toastBody");
      toastBody.textContent = "추천 인원 수보다 많이 설정할 수 없습니다.";
      const toast = new bootstrap.Toast(document.getElementById("limitToast"));
      toast.show();
    } else {
      lastValidMembers = inputValue;
    }
  });

  // ✅ 모달 인원 수 입력 제한
  groupSizeInput.addEventListener("input", function () {
    const selectedSubject = modalSubjectSelect.value;
    const maxFriends = subjectFriendsMap[selectedSubject]
      ? Array.from(new Set(subjectFriendsMap[selectedSubject])).length
      : 0;

    const inputValue = parseInt(groupSizeInput.value);
    if (isNaN(inputValue) || inputValue <= 0) {
      lastValidGroupSize = 2;
      return;
    }

    if (inputValue > maxFriends) {
      groupSizeInput.value = lastValidGroupSize;

      const toastBody = document.getElementById("toastBody");
      toastBody.textContent = "추천 인원 수보다 많은 인원입니다.";
      const toast = new bootstrap.Toast(document.getElementById("limitToast"));
      toast.show();
    } else {
      lastValidGroupSize = inputValue;
    }
  });
});
