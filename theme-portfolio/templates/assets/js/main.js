/**
 * Theme Portfolio - main.js
 *
 * Responsibilities:
 *   1. Color-scheme cycling (system / light / dark) with localStorage persistence.
 *   2. Header scroll state - toggles data-scrolled="true" when the page
 *      is scrolled past the header height, so the background fades in.
 *   3. Mobile menu toggle - flips aria-expanded and the nav overlay state.
 *   4. Active-link highlighting - marks the current nav link based on URL path.
 *   5. Scroll-reveal observer - adds .is-visible to any [data-reveal] element
 *      that enters the viewport, for fade-up animation.
 *   6. AOS-style animation observer - adds .aos-animate to [data-aos] elements
 *      when they enter the viewport, with support for data-aos-delay.
 *
 * No external dependencies.
 */
(function () {
  "use strict";

  // ============================================================
  // 1. Color scheme
  // ============================================================
  var STORAGE_KEY = "halo-portfolio-theme";
  var html = document.documentElement;

  function currentScheme() {
    return html.getAttribute("data-theme") || "dark";
  }
  function applyScheme(scheme) {
    html.setAttribute("data-theme", scheme);
  }
  function cycleScheme() {
    var order = ["system", "light", "dark"];
    var next = order[(order.indexOf(currentScheme()) + 1) % order.length];
    applyScheme(next);
    try { localStorage.setItem(STORAGE_KEY, next); } catch (_) {}
    updateToggleLabels();
  }
  function updateToggleLabels() {
    var label = "Color scheme: " + currentScheme() + " (click to cycle)";
    document.querySelectorAll("[data-theme-toggle]").forEach(function (btn) {
      btn.setAttribute("title", label);
      btn.setAttribute("aria-label", label);
    });
  }

  document.addEventListener("click", function (e) {
    var btn = e.target.closest("[data-theme-toggle]");
    if (btn) cycleScheme();
  });

  // Restore user override before paint, if present
  try {
    var saved = localStorage.getItem(STORAGE_KEY);
    if (saved) applyScheme(saved);
  } catch (_) {}
  updateToggleLabels();

  // ============================================================
  // 2. Header scroll state
  // ============================================================
  var header = document.querySelector("[data-site-header]");
  if (header) {
    var SCROLL_THRESHOLD = 24;
    function syncHeader() {
      var scrolled = window.scrollY > SCROLL_THRESHOLD;
      header.setAttribute("data-scrolled", scrolled ? "true" : "false");
    }
    syncHeader();
    window.addEventListener("scroll", syncHeader, { passive: true });
  }

  // ============================================================
  // 3. Mobile menu toggle
  // ============================================================
  var menuToggle = document.querySelector("[data-menu-toggle]");
  var siteNav = document.querySelector("[data-site-nav]");
  if (menuToggle && siteNav) {
    menuToggle.addEventListener("click", function () {
      var open = menuToggle.getAttribute("aria-expanded") === "true";
      menuToggle.setAttribute("aria-expanded", open ? "false" : "true");
      siteNav.setAttribute("data-open", open ? "false" : "true");
    });
    // Close menu when a link is tapped
    siteNav.addEventListener("click", function (e) {
      if (e.target.closest("a") && window.matchMedia("(max-width: 768px)").matches) {
        menuToggle.setAttribute("aria-expanded", "false");
        siteNav.setAttribute("data-open", "false");
      }
    });
  }

  // ============================================================
  // 4. Active-link highlighting based on path
  // ============================================================
  try {
    var path = window.location.pathname.replace(/\/+$/, "") || "/";
    var links = document.querySelectorAll("[data-nav-link]");
    links.forEach(function (a) {
      var href = a.getAttribute("data-nav-link") || a.getAttribute("href") || "";
      var normalized = href.replace(/\/+$/, "") || "/";
      if (normalized === path || (path === "/" && normalized === "/")) {
        a.classList.add("active");
        a.setAttribute("aria-current", "page");
      }
    });
  } catch (_) {}

  // ============================================================
  // 5. Scroll-reveal observer (legacy [data-reveal])
  // ============================================================
  if ("IntersectionObserver" in window) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          io.unobserve(entry.target);
        }
      });
    }, { rootMargin: "0px 0px -10% 0px", threshold: 0.05 });

    document.querySelectorAll("[data-reveal]").forEach(function (el) {
      io.observe(el);
    });
  } else {
    document.querySelectorAll("[data-reveal]").forEach(function (el) {
      el.classList.add("is-visible");
    });
  }

  // ============================================================
  // 6. AOS-style animation observer ([data-aos])
  // ============================================================
  if ("IntersectionObserver" in window) {
    var aosObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          var el = entry.target;
          var delay = parseInt(el.getAttribute("data-aos-delay") || "0", 10);
          if (delay > 0) {
            setTimeout(function () {
              el.classList.add("aos-animate");
            }, delay);
          } else {
            el.classList.add("aos-animate");
          }
          aosObserver.unobserve(el);
        }
      });
    }, { rootMargin: "0px 0px -8% 0px", threshold: 0.05 });

    document.querySelectorAll("[data-aos]").forEach(function (el) {
      aosObserver.observe(el);
    });
  } else {
    document.querySelectorAll("[data-aos]").forEach(function (el) {
      el.classList.add("aos-animate");
    });
  }
})();
