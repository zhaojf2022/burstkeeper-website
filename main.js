(function () {
  var html = document.documentElement;
  var buttons = document.querySelectorAll('.lang-switch button');
  function apply(lang) {
    var isEn = lang === 'en';
    html.setAttribute('lang', isEn ? 'en' : 'zh-Hant');
    document.querySelectorAll('[data-zh]').forEach(function (el) {
      var zh = el.getAttribute('data-zh');
      var en = el.getAttribute('data-en');
      if (zh !== null && en !== null) el.textContent = isEn ? en : zh;
    });
    buttons.forEach(function (b) {
      var on = b.dataset.lang === lang;
      b.classList.toggle('active', on);
      b.setAttribute('aria-pressed', on ? 'true' : 'false');
    });
    try { localStorage.setItem('lang', lang); } catch (e) {}
  }
  buttons.forEach(function (b) {
    b.addEventListener('click', function () { apply(b.dataset.lang); });
  });
  var saved = null;
  try { saved = localStorage.getItem('lang'); } catch (e) {}
  if (saved === 'en') apply('en');
  document.getElementById('year').textContent = String(new Date().getFullYear());
})();
