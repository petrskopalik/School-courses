document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".alert").forEach(alert => {
    setTimeout(() => {
      alert.classList.add("hide");
      setTimeout(() => alert.remove(), 500);
    }, 2500);
  });
});