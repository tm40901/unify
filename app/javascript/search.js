const search = () => {
  
  const inspectorList = document.getElementById('inspector_list');
  const inspectorEmployeeNumberField = document.getElementById('inspector_employee_number_field');
  const inspectorNameField = document.getElementById('inspector_name_field');
  const inspectorModalElement = document.getElementById('inspectorModal');
  const inspectorModal = new bootstrap.Modal(inspectorModalElement);

  inspectorModalElement.addEventListener('show.bs.modal', () => {
    fetch('/instruments/load_inspectors')
      .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
      })
      .then(data => {
        inspectorList.innerHTML = '';
        data.inspectors.forEach(inspector => {
          if (inspector.id !== data.current_user_id) {
          const row = document.createElement('tr');
          row.innerHTML = `
            <td>${inspector.employee_number}</td>
            <td>${inspector.last_name} ${inspector.first_name}</td>
            <td>${inspector.department}</td>
            <td><button type="button" class="btn btn-primary select-inspector" 
                        data-inspector-employee-number="${inspector.employee_number}"
                        data-inspector-name="${inspector.last_name} ${inspector.first_name}">選択</button></td>
          `;
          inspectorList.appendChild(row);
          }
        });

        document.querySelectorAll('.select-inspector').forEach(button => {
          button.addEventListener('click', (event) => {
            const employeeNumber = event.target.getAttribute('data-inspector-employee-number');
            const name = event.target.getAttribute('data-inspector-name');

            inspectorEmployeeNumberField.value = employeeNumber;
            inspectorNameField.value = name;

            inspectorModal.hide();
          });
        });
      })
      .catch(error => console.error('Error loading inspectors:', error));
  });
};

window.addEventListener("turbo:load", search);
window.addEventListener("turbo:render", search);