const sidebar_toggle = () => {
  const sidebar = document.getElementById("sidebar-lists");
  const toggleButton = document.getElementById("sidebarToggle");

  // ローカルストレージから状態を取得
  const sidebarState = localStorage.getItem('sidebarState') === 'true'; // 'true' が非表示（collapsed）

  // 要素が存在するか確認してからリスナーを追加
  if (toggleButton && sidebar) {
    // ページ読み込み時に現在の状態をセット
    !sidebarState ?  // 'true' 以外（＝表示）の場合
      sidebar.classList.remove('collapsed') :
      sidebar.classList.add('collapsed');

    const toggleSidebar = function() {
      // 現在の状態を反転させてローカルストレージに保存
      sidebar.classList.toggle("collapsed");
      localStorage.setItem('sidebarState', sidebar.classList.contains("collapsed"));
    };

    // リスナーが既に登録されている場合は既存のリスナーを削除
    toggleButton.removeEventListener("click", toggleButton._listener);

    // 新しいリスナーを登録
    toggleButton.addEventListener("click", toggleSidebar);

    // カスタムプロパティを使用して新しいリスナーを参照
    toggleButton._listener = toggleSidebar;
  }
};

window.addEventListener("turbo:load", sidebar_toggle);
window.addEventListener("turbo:render", sidebar_toggle);