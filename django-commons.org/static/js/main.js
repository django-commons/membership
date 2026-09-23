(function () {
  var root = document.documentElement;

  var themeBtn = document.getElementById("theme-toggle");
  if (themeBtn) {
    themeBtn.addEventListener("click", function () {
      var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
      root.setAttribute("data-theme", next);
      try { localStorage.setItem("dc-theme", next); } catch (e) {}
    });
  }

  var navBtn = document.getElementById("nav-toggle");
  var nav = document.getElementById("site-nav");
  if (navBtn && nav) {
    navBtn.addEventListener("click", function () {
      var open = nav.classList.toggle("open");
      navBtn.setAttribute("aria-expanded", open ? "true" : "false");
    });
  }
  document.querySelectorAll(".site-nav__link--parent").forEach(function (btn) {
    btn.addEventListener("click", function () {
      btn.closest(".site-nav__item").classList.toggle("open");
    });
  });

  function openTarget() {
    var el = location.hash && document.getElementById(decodeURIComponent(location.hash.slice(1)));
    if (el && el.tagName === "DETAILS") el.open = true;
  }
  window.addEventListener("hashchange", openTarget);
  openTarget();

  var ring = document.querySelector("[data-ring]");
  if (ring) {
    var nodes = ring.querySelectorAll(".ring__node");
    var idle = ring.querySelector(".ring__idle");
    var detail = ring.querySelector(".ring__detail");
    var n = nodes.length;
    var touch = window.matchMedia("(hover: none)").matches;

    function show(node) {
      nodes.forEach(function (x) { x.classList.toggle("is-active", x === node); });
      ring.style.setProperty("--angle", (360 / n) * Number(node.dataset.i) + "deg");
      ring.classList.add("has-active");
      detail.querySelector(".ring__name").textContent = node.dataset.name;
      detail.querySelector(".ring__desc").textContent = node.dataset.desc;
      detail.querySelector(".ring__date").textContent = node.dataset.joined ? "Joined " + node.dataset.joined : "";
      detail.querySelector(".ring__open").href = node.href;
      detail.hidden = false;
      idle.style.opacity = 0;
    }
    function clear() {
      nodes.forEach(function (x) { x.classList.remove("is-active"); });
      ring.classList.remove("has-active");
      detail.hidden = true;
      idle.style.opacity = "";
    }

    nodes.forEach(function (node) {
      node.addEventListener("mouseenter", function () { show(node); });
      node.addEventListener("focus", function () { show(node); });
      node.addEventListener("blur", clear);
      if (touch) {
        node.addEventListener("click", function (e) { e.preventDefault(); show(node); });
      }
    });
    ring.addEventListener("mouseleave", clear);
  }
})();
