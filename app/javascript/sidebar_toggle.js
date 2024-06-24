const sidebar_toggle = () => {
  const sidebar = document.getElementById("sidebar");
  const toggleButton = document.getElementById("sidebarToggle");

  const toggleSidebar = function() {
    sidebar.classList.toggle("collapsed");
  };

  toggleButton.addEventListener("click", toggleSidebar);

};

window.addEventListener("turbo:load", sidebar_toggle);
