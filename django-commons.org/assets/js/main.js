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

  var toc = document.querySelector(".toc");
  if (toc) {
    var links = toc.querySelectorAll('a[href^="#"]');
    var byHeading = new Map();
    var headings = [];
    links.forEach(function (a) {
      var h = document.getElementById(decodeURIComponent(a.hash.slice(1)));
      if (h) { byHeading.set(h, a); headings.push(h); }
    });
    var inBand = new Set();
    var atEnd = false;
    var offset = 110;

    function highlight() {
      var current = headings.find(function (h) { return inBand.has(h); });
      if (!current) {
        var above = headings.filter(function (h) { return h.getBoundingClientRect().top < offset; });
        current = above[above.length - 1];
      }
      if (atEnd) current = headings[headings.length - 1];
      var active = current && byHeading.get(current);
      links.forEach(function (a) {
        var on = a === active;
        a.classList.toggle("is-current", on);
        if (on) a.setAttribute("aria-current", "location"); else a.removeAttribute("aria-current");
      });
      if (active) {
        var t = active.offsetTop, b = t + active.offsetHeight;
        if (t < toc.scrollTop) toc.scrollTop = t - 8;
        else if (b > toc.scrollTop + toc.clientHeight) toc.scrollTop = b - toc.clientHeight + 8;
      }
    }

    var spy = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) inBand.add(e.target); else inBand.delete(e.target);
      });
      highlight();
    }, { rootMargin: "-" + offset + "px 0px -65% 0px" });
    headings.forEach(function (h) { spy.observe(h); });

    var end = document.querySelector(".doc__edit");
    if (end) {
      new IntersectionObserver(function (entries) {
        atEnd = entries[0].isIntersecting;
        highlight();
      }, { threshold: 1 }).observe(end);
    }
  }

  var ring = document.querySelector("[data-ring]");
  if (ring) {
    var nodes = ring.querySelectorAll(".ring__node");
    var idle = ring.querySelector(".ring__idle");
    var detail = ring.querySelector(".ring__detail");
    var n = nodes.length;

    function show(node) {
      nodes.forEach(function (x) { x.classList.toggle("is-active", x === node); });
      ring.style.setProperty("--angle", (360 / n) * Number(node.dataset.i) + "deg");
      ring.classList.add("has-active");
      detail.querySelector(".ring__name").textContent = node.dataset.name;
      detail.querySelector(".ring__desc").textContent = node.dataset.desc;
      detail.querySelector(".ring__date").textContent = node.dataset.joined ? "Joined " + node.dataset.joined : "";
      detail.querySelector(".ring__open").href = node.dataset.url;
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
      node.addEventListener("click", function () { show(node); });
    });
    ring.addEventListener("mouseleave", clear);
    ring.addEventListener("focusout", function (e) {
      if (!ring.contains(e.relatedTarget)) clear();
    });
  }
})();
