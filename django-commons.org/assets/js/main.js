(function () {
  var root = document.documentElement;

  // Light/dark theme toggle. The choice is persisted in localStorage.
  function initThemeToggle() {
    var btn = document.getElementById("theme-toggle");
    if (!btn) return;
    btn.addEventListener("click", function () {
      var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
      root.setAttribute("data-theme", next);
      // Storage can throw (private mode, blocked site data). The theme still
      // switches for this page view, so failing to remember it is harmless.
      try { localStorage.setItem("dc-theme", next); } catch (e) {}
    });
  }

  // Mobile menu button and the expandable "Organization" submenu.
  function initNav() {
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
        var open = btn.closest(".site-nav__item").classList.toggle("open");
        btn.setAttribute("aria-expanded", open ? "true" : "false");
      });
    });
  }

  // Expand a collapsed <details> (e.g. an FAQ entry) when it is the URL hash target.
  function initDetailsHash() {
    function openTarget() {
      var el = location.hash && document.getElementById(decodeURIComponent(location.hash.slice(1)));
      if (el && el.tagName === "DETAILS") el.open = true;
    }
    window.addEventListener("hashchange", openTarget);
    openTarget();
  }

  // Pairs each table-of-contents link with the heading it points to.
  function collectTocEntries(toc) {
    var links = toc.querySelectorAll('a[href^="#"]');
    var byHeading = new Map();
    var headings = [];
    links.forEach(function (a) {
      var h = document.getElementById(decodeURIComponent(a.hash.slice(1)));
      if (h) { byHeading.set(h, a); headings.push(h); }
    });
    return { links: links, byHeading: byHeading, headings: headings };
  }

  // Marks one TOC link as current, and clears the others.
  function setCurrentLink(links, active) {
    links.forEach(function (a) {
      var on = a === active;
      a.classList.toggle("is-current", on);
      if (on) a.setAttribute("aria-current", "location"); else a.removeAttribute("aria-current");
    });
  }

  // Scrolls the (independently scrolling) TOC so the current link stays visible.
  function keepLinkInView(toc, link) {
    var top = link.offsetTop, bottom = top + link.offsetHeight;
    if (top < toc.scrollTop) toc.scrollTop = top - 8;
    else if (bottom > toc.scrollTop + toc.clientHeight) toc.scrollTop = bottom - toc.clientHeight + 8;
  }

  // Highlights the TOC link for the heading currently being read.
  function initTocSpy() {
    var toc = document.querySelector(".toc");
    if (!toc) return;

    var entries = collectTocEntries(toc);
    var headings = entries.headings;
    var inBand = new Set();  // headings inside the observed band near the top of the viewport
    var atEnd = false;       // page scrolled to the bottom: force the last heading
    var offset = 110;        // sticky header height

    function highlight() {
      var current = headings.find(function (h) { return inBand.has(h); });
      if (!current) {
        // No heading in the band: fall back to the last one scrolled past.
        var above = headings.filter(function (h) { return h.getBoundingClientRect().top < offset; });
        current = above[above.length - 1];
      }
      if (atEnd) current = headings[headings.length - 1];
      var active = current && entries.byHeading.get(current);
      setCurrentLink(entries.links, active);
      if (active) keepLinkInView(toc, active);
    }

    var spy = new IntersectionObserver(function (changes) {
      changes.forEach(function (e) {
        if (e.isIntersecting) inBand.add(e.target); else inBand.delete(e.target);
      });
      highlight();
    }, { rootMargin: "-" + offset + "px 0px -65% 0px" });
    headings.forEach(function (h) { spy.observe(h); });

    // Short final sections never reach the band, so treat the page end as its own signal.
    var end = document.querySelector(".doc__edit");
    if (end) {
      new IntersectionObserver(function (changes) {
        atEnd = changes[0].isIntersecting;
        highlight();
      }, { threshold: 1 }).observe(end);
    }
  }

  // Home page project ring: show a project's details on hover, focus or click.
  function initRing() {
    var ring = document.querySelector("[data-ring]");
    if (!ring) return;

    var nodes = ring.querySelectorAll(".ring__node");
    var idle = ring.querySelector(".ring__idle");
    var detail = ring.querySelector(".ring__detail");
    var count = nodes.length;

    function show(node) {
      nodes.forEach(function (x) { x.classList.toggle("is-active", x === node); });
      ring.style.setProperty("--angle", (360 / count) * Number(node.dataset.i) + "deg");
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

  initThemeToggle();
  initNav();
  initDetailsHash();
  initTocSpy();
  initRing();
})();
