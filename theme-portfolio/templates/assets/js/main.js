/**
 * Halo Demo Theme — main.js
 * Handles theme (color scheme) switching with localStorage persistence.
 * Reads the initial scheme from <html data-theme> set by the layout template.
 */
(function () {
  "use strict";

  var STORAGE_KEY = "halo-demo-theme";
  var html = document.documentElement;

  function apply(scheme) {
    // scheme: "light" | "dark" | "system"
    html.setAttribute("data-theme", scheme);
  }

  function current() {
    return html.getAttribute("data-theme") || "system";
  }

  // Persist override on click of the toggle button.
  document.addEventListener("click", function (e) {
    var btn = e.target.closest("[data-theme-toggle]");
    if (!btn) return;
    var order = ["system", "light", "dark"];
    var next = order[(order.indexOf(current()) + 1) % order.length];
    apply(next);
    try { localStorage.setItem(STORAGE_KEY, next); } catch (_) {}
  });

  // Restore user override before paint if present.
  try {
    var saved = localStorage.getItem(STORAGE_KEY);
    if (saved) apply(saved);
  } catch (_) {}

  // Friendly label on the toggle button.
  var btn = document.querySelector("[data-theme-toggle]");
  if (btn) {
    btn.setAttribute("title", "Color scheme: " + current() + " (click to cycle)");
    btn.setAttribute("aria-label", "Toggle color scheme");
  }
})();
