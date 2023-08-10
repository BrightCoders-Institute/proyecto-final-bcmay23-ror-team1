var modal = document.getElementById("myModal");
var closeButton = document.getElementById("closeModal");

document.querySelector('#openModalButton').addEventListener('click', () => {
  modal.style.display = "flex";
});

closeButton.addEventListener("click", function() {
  modal.style.display = "none";
});