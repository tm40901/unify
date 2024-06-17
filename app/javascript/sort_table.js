const sort_table = () => {

  document.querySelectorAll('th').forEach(th => {
    th.addEventListener('click', () => {
      const table = th.closest('table');
      const index = Array.from(th.parentNode.children).indexOf(th);
      const ascending = th.classList.toggle('th-sort-asc');

      Array.from(table.querySelectorAll('tr:nth-child(n+2)'))
        .sort(comparer(index, ascending))
        .forEach(tr => table.querySelector('tbody').appendChild(tr));

      // Remove sort classes from other headers
      Array.from(th.parentNode.children).forEach(cell => {
        if (cell !== th) cell.classList.remove('th-sort-asc', 'th-sort-desc');
      });

      // Toggle the current header's class
      if (!ascending) {
        th.classList.add('th-sort-desc');
      } else {
        th.classList.remove('th-sort-desc');
      }
    });
  });

  function comparer(index, ascending) {
    return (a, b) => ((v1, v2) =>
      v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
    )(getCellValue(ascending ? a : b, index), getCellValue(ascending ? b : a, index));
  }

  function getCellValue(tr, index) {
    return tr.children[index].innerText || tr.children[index].textContent;
  }
};

window.addEventListener("turbo:load", sort_table);
window.addEventListener("turbo:render", sort_table);