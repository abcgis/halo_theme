/* ============================================================
 * Halo theme · Cyanlin Portfolio · theme.js
 * Vanilla JS, no dependencies
 * ============================================================ */
(function () {
  "use strict";

  // ---------- mobile menu ----------
  function initMobileMenu() {
    var btn = document.querySelector(".mobile-menu-toggle");
    var drawer = document.querySelector(".mobile-drawer");
    if (!btn || !drawer) return;
    btn.addEventListener("click", function () {
      document.body.classList.toggle("mobile-menu-open");
    });
    drawer.querySelectorAll("a").forEach(function (a) {
      a.addEventListener("click", function () {
        document.body.classList.remove("mobile-menu-open");
      });
    });
  }

  // ---------- sticky header shadow on scroll ----------
  function initStickyShadow() {
    var header = document.querySelector(".site-header, .mobile-header");
    if (!header) return;
    var last = 0;
    window.addEventListener("scroll", function () {
      var y = window.scrollY || window.pageYOffset;
      if (y > 8) header.classList.add("is-scrolled");
      else header.classList.remove("is-scrolled");
      last = y;
    }, { passive: true });
  }

  // ---------- lightbox ----------
  function initLightbox() {
    var enabled = document.body.getAttribute("data-lightbox") !== "false";
    if (!enabled) return;

    var gallery = document.querySelector(".pd-gallery");
    if (!gallery) return;

    var imgs = Array.prototype.slice.call(gallery.querySelectorAll("img"));
    if (!imgs.length) return;

    var lb = document.createElement("div");
    lb.className = "lightbox";
    lb.innerHTML =
      '<button class="lb-close" aria-label="close">✕</button>' +
      '<button class="lb-prev" aria-label="previous">‹</button>' +
      '<button class="lb-next" aria-label="next">›</button>' +
      '<img alt="" />';
    document.body.appendChild(lb);

    var mainImg = lb.querySelector("img");
    var currentIdx = 0;

    function show(idx) {
      currentIdx = (idx + imgs.length) % imgs.length;
      mainImg.src = imgs[currentIdx].src;
      mainImg.alt = imgs[currentIdx].alt || "";
    }
    function open(idx) {
      show(idx);
      lb.classList.add("is-open");
      document.body.style.overflow = "hidden";
    }
    function close() {
      lb.classList.remove("is-open");
      document.body.style.overflow = "";
    }

    imgs.forEach(function (img, i) {
      img.style.cursor = "zoom-in";
      img.addEventListener("click", function (e) {
        e.preventDefault();
        open(i);
      });
    });

    lb.querySelector(".lb-close").addEventListener("click", close);
    lb.querySelector(".lb-prev").addEventListener("click", function () { show(currentIdx - 1); });
    lb.querySelector(".lb-next").addEventListener("click", function () { show(currentIdx + 1); });
    lb.addEventListener("click", function (e) {
      if (e.target === lb) close();
    });
    document.addEventListener("keydown", function (e) {
      if (!lb.classList.contains("is-open")) return;
      if (e.key === "Escape") close();
      if (e.key === "ArrowLeft") show(currentIdx - 1);
      if (e.key === "ArrowRight") show(currentIdx + 1);
    });
  }

  // ---------- back to top ----------
  function initBackToTop() {
    var btn = document.querySelector(".back-to-top");
    if (!btn) return;
    window.addEventListener("scroll", function () {
      if ((window.scrollY || 0) > 300) btn.classList.add("is-visible");
      else btn.classList.remove("is-visible");
    }, { passive: true });
    btn.addEventListener("click", function () {
      window.scrollTo({ top: 0, behavior: "smooth" });
    });
  }

  // ---------- search box inline toggle (optional) ----------
  function initSearchToggle() {
    var t = document.querySelector("[data-search-toggle]");
    var target = document.querySelector("[data-search-target]");
    if (!t || !target) return;
    t.addEventListener("click", function () {
      target.classList.toggle("is-open");
      var input = target.querySelector("input");
      if (input && target.classList.contains("is-open")) input.focus();
    });
  }

  document.addEventListener("DOMContentLoaded", function () {
    initMobileMenu();
    initStickyShadow();
    initLightbox();
    initBackToTop();
    initSearchToggle();
  });
})();
