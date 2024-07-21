/* コード概要 ********************************************************************************************************
機能：点検者を選択するためのモーダルウィンドウを表示し、そのモーダル内で点検者リストを取得し、
ユーザーが選択した点検者の情報を入力フィールドに反映する機能
*********************************************************************************************************************/

const search = () => {
  
  const inspectorList = document.getElementById('inspector_list');
  const inspectorEmployeeNumberField = document.getElementById('inspector_employee_number_field');
  const inspectorNameField = document.getElementById('inspector_name_field');
  const inspectorModalElement = document.getElementById('inspectorModal');
  const inspectorModal = new bootstrap.Modal(inspectorModalElement);

  //モーダル表示イベントのリスナー設定
  inspectorModalElement.addEventListener('show.bs.modal', () => {
    
    fetch('/instruments/load_inspectors')
      .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        // レスポンスをJSON形式に変換
        return response.json();
      })

      .then(data => {
        // 点検者リストクリア
        inspectorList.innerHTML = '';
        // 各点検者情報を表示
        data.inspectors.forEach(inspector => {
          // ログインユーザーのデータを除外
          if (inspector.id !== data.current_user_id) {
          // テーブル行を作成  
          const row = document.createElement('tr');
          // 作成したテーブル行の内部HTMLを設定
          row.innerHTML = `
            <td>${inspector.employee_number}</td>
            <td>${inspector.last_name} ${inspector.first_name}</td>
            <td>${inspector.department}</td>
            <td><button type="button" class="btn btn-primary select-inspector" 
                        data-inspector-employee-number="${inspector.employee_number}"
                        data-inspector-name="${inspector.last_name} ${inspector.first_name}">選択</button></td>
          `;
          // 作成したテーブル行をリストに追加
          inspectorList.appendChild(row);
          }
        });

        // 選択ボタンを取得し、クリックイベントを設定
        document.querySelectorAll('.select-inspector').forEach(button => {
          // ボタンにクリックイベントリスナーを追加
          button.addEventListener('click', (event) => {
            // クリックされたボタンのデータ属性を取得
            const employeeNumber = event.target.getAttribute('data-inspector-employee-number');
            const name = event.target.getAttribute('data-inspector-name');
            // 取得したデータを入力フィールドに設定
            inspectorEmployeeNumberField.value = employeeNumber;
            inspectorNameField.value = name;
            // モーダルを非表示にする
            inspectorModal.hide();
          });
        });
      })
      .catch(error => console.error('Error loading inspectors:', error));
  });
};

window.addEventListener("turbo:load", search);
window.addEventListener("turbo:render", search);