         document.getElementById("isAdmin").addEventListener("change", function () {
            const adminFields = document.getElementById("adminFields");
            adminFields.style.display = this.checked ? "block" : "none";
          });