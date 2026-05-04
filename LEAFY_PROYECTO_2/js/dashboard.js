function toggleMenu() {
    const dropdown = document.getElementById("dropdownMenu");
    dropdown.classList.toggle("active");
}

document.addEventListener("click", function(event) {
    const menu = document.querySelector(".user-menu");
    const dropdown = document.getElementById("dropdownMenu");

    if (!menu.contains(event.target)) {
        dropdown.classList.remove("active");
    }
});