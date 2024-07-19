/* コード概要 ********************************************************************************************************
機能：ウェブページのサイドバーの表示及び非表示を切り替える

1. サイドバーとトグルボタンの要素を取得する：

2. サイドバーの状態を localStorage から取得する：
・sidebarState は、localStorage に保存されているサイドバーの状態を取得し、Boolean 値に変換します。

3. サイドバーの初期状態を設定する：
・sidebarState の値に基づいて、サイドバーが折りたたまれているかどうかを設定します。

4. トグルボタンのクリックイベントを設定する：
・toggleButton に以前設定されていたクリックイベントリスナーを削除します。
・新しいクリックイベントリスナーを追加し、クリックするたびにサイドバーの表示状態を切り替え、localStorage にその状態を保存します。

5. ページの読み込み時にサイドバーの状態を設定する：
・ページの読み込みとレンダリング時に sidebar_toggle 関数を呼び出します。
*********************************************************************************************************************/

const sidebar_toggle = () => {
  // サイドバーとトグルボタンの要素を取得
  const sidebar = document.getElementById("sidebar-lists");
  const toggleButton = document.getElementById("sidebarToggle");

  // localStorage からサイドバーの状態を取得し、Boolean 値に変換
  const sidebarState = localStorage.getItem('sidebarState') === 'true';

  // トグルボタンとサイドバーが存在する場合
  if (toggleButton && sidebar) {
    // サイドバーの初期状態を設定
    !sidebarState ?
      sidebar.classList.remove('collapsed') : //表示
      sidebar.classList.add('collapsed');     //非表示

    // サイドバーの表示状態を切り替える関数
    const toggleSidebar = function() {
      // サイドバーの表示状態を切り替える
      sidebar.classList.toggle("collapsed");
      // サイドバーが 'collapsed' クラスを持っているかどうかを localStorage に保存
      localStorage.setItem('sidebarState', sidebar.classList.contains("collapsed"));
    };

    // 以前のクリックイベントリスナーを削除
    toggleButton.removeEventListener("click", toggleButton._listener);

    // 新しいクリックイベントリスナーを追加
    toggleButton.addEventListener("click", toggleSidebar);

    // 現在のクリックイベントリスナーを保存
    toggleButton._listener = toggleSidebar;
  }
};

// ページの読み込み時とレンダリング時にサイドバーの状態を設定
window.addEventListener("turbo:load", sidebar_toggle);
window.addEventListener("turbo:render", sidebar_toggle);
