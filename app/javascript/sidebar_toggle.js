const sidebar_toggle = () => {
  const sidebar = document.getElementById("sidebar-lists");
  const toggleButton = document.getElementById("sidebarToggle");

  // 要素が存在するか確認してからリスナーを追加
  if (toggleButton && sidebar) {
    const toggleSidebar = function() {
      sidebar.classList.toggle("collapsed");
    };

    // リスナーが既に登録されている場合は既存のリスナーを削除
    toggleButton.removeEventListener("click", toggleButton._listener);
    
    // 新しいリスナーを登録
    toggleButton.addEventListener("click", toggleSidebar);

    // カスタムプロパティを使用して新しいリスナーを参照
    toggleButton._listener = toggleSidebar;
  }
};

// turbo:loadとturbo:renderの両方に対してリスナーを追加
window.addEventListener("turbo:load", sidebar_toggle);
window.addEventListener("turbo:render", sidebar_toggle);