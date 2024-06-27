const dismiss_alert = () => {
  const alerts = document.querySelectorAll('.alert');
  alerts.forEach(alert => {
    setTimeout(function () {
      alert.remove();
    }, 3000);
  });
};

window.addEventListener("turbo:load", dismiss_alert);
window.addEventListener("turbo:render", dismiss_alert);