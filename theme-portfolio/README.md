# Halo Portfolio Theme

A minimalist, dark-first **Halo 2.x** portfolio theme. Single display face
(Montserrat), warm gold accent (`#f7b731`), fixed transparent header that
solidifies on scroll, hero treatment on the homepage, scroll-reveal
animations, and full mobile overlay navigation.

> Built following the official Halo developer guide
> ([docs.halo.run/developer-guide/theme/prepare](https://docs.halo.run/developer-guide/theme/prepare))
> and the [`halo-theme-dev`](https://github.com/) AI assistant skill.

---

## Features

| Area | What is demonstrated |
| ---- | ------------------- |
| **Layout reuse** | `templates/layout.html` is a parameterized Thymeleaf fragment (`layout(title, content)`) that every page template reuses via `th:replace`. |
| **Static assets** | CSS / JS / images live under `templates/assets/`, referenced with cache-busting `?v={theme.spec.version}`. |
| **Theme settings form** | `settings.yaml` (FormKit) exposes style / layout / seo groups; values are read via `theme.config.<group>.<field>`. |
| **Global variables** | `site`, `theme`, `theme.config`, `#theme.assets()` — see `layout.html`, `header.html`, `index.html`. |
| **Finder APIs** | `menuFinder.getPrimary()`, `postFinder.cursor()`, `postFinder.listAll()`, `tagFinder.listAll()`. |
| **Pagination** | Built for `posts`, `archives`, `tag`, `category`, `author` using `prevUrl` / `nextUrl` / `hasPrevious()` / `hasNext()`. |
| **Custom templates** | `theme.yaml` registers a **Docs Layout** for posts; the file lives at `templates/post-types/post-docs.html`. |
| **Light / dark mode** | Toggle in the header cycles `system -> light -> dark`; persisted in `localStorage`; system preference respected when set to `system`. |
| **Comment extension** | `<halo:comment>` rendered conditionally on `post.html` and `page.html` via `haloCommentEnabled`. |
| **Footer injection** | `<halo:footer />` is the last body element in `layout.html` so plugins can inject analytics. |
| **Error pages** | `templates/error/404.html` and `4xx.html` (per the Halo error-template resolution order). |
| **i18n-friendly** | All text is in plain HTML / Thymeleaf — no hard-coded copy beyond footer placeholder. |
| **Safe Thymeleaf** | Uses `?.`, `?:`, `#strings.isEmpty`, literal substitutions, `@{${url}}` for permalinks. |
| **Montserrat typography** | Single font family (weights 300-800) loaded from Google Fonts; display titles are 700-800 with tight letter-spacing. |
| **Fixed transparent header** | `position: fixed`, transparent by default; gains a translucent background + backdrop-blur after 24px of scroll. |
| **Hero treatment** | Full-viewport homepage hero — eyebrow, display title (clamp 2.5-5rem), subtitle, CTA — each element fades up in sequence. |
| **Animated nav underline** | Nav links get a 2px gold underline that animates in via `transform: scaleX` from the left. |
| **Mobile overlay nav** | Below 768px the nav becomes a hamburger that opens a full-viewport, blurred overlay (translateX transition; bars animate into an X). |
| **Active-link detection** | JS compares `window.location.pathname` against each nav link's `data-nav-link` attribute to mark the current page. |
| **Scroll-reveal** | Add `data-reveal` to any element; an `IntersectionObserver` adds `.is-visible` to fade it up on first appearance. |
| **SVG social icons** | Footer renders three circular SVG icon links (home / GitHub / email) that lift on hover. |
| **Reduced-motion** | All animations and transitions collapse to 0.01ms when `prefers-reduced-motion: reduce` is set. |
---
## Directory layout

```
theme-portfolio/
|-- theme.yaml                          # Theme manifest
|-- settings.yaml                       # Settings form (FormKit)
|-- README.md
|-- scripts/
|   `-- wrap-and-zip.mjs                # Zero-dep ZIP packager (no npm install)
`-- templates/
    |-- layout.html                     # Parameterized layout fragment
    |-- index.html                      # Home (hero + portfolio grid)
    |-- post.html                       # Post detail (default template)
    |-- page.html                       # Single page detail
    |-- archives.html                   # Year/month archive
    |-- tags.html                       # All tags
    |-- tag.html                        # Posts for one tag
    |-- categories.html                 # All categories
    |-- category.html                   # Posts for one category
    |-- author.html                     # Author profile + posts
    |-- assets/
    |   |-- css/style.css               # Design tokens + components (26 KB, light/dark)
    |   |-- js/main.js                  # Theme toggle + scroll state + mobile nav + reveal
    |   `-- images/logo.svg             # Gold square logo (24x24)
    |-- modules/
    |   |-- header.html                 # Site header fragment (fixed)
    |   `-- footer.html                 # Site footer fragment (dark band)
    |-- error/
    |   |-- 404.html                    # Not found
    |   `-- 4xx.html                    # Generic client error fallback
    `-- post-types/
        `-- post-docs.html              # Custom "Docs Layout" variant
```

---

## Installation

1. Make sure your local folder name matches `metadata.name` in `theme.yaml`
   (`theme-portfolio`). When installing, Halo extracts the theme under its
   `themes/` directory using that exact folder name.
2. Open the Halo Console -> **Appearance -> Themes**.
3. Click **Switch theme -> Not installed**, then **Install** the theme.
4. Click **Enable** on the newly installed theme.
5. (Optional) Open **Theme settings** to adjust accent color, layout and footer.
6. Visit the frontend (default `http://localhost:8090`) to verify.

### Hot-reload during development

- **Source mode** -- add to `application.yml`:
  ```yaml
  spring:
    thymeleaf:
      cache: false
      cache-ttl-ms: 0
  ```
- **Docker** -- set the environment variables:
  ```powershell
  -e SPRING_THYMELEAF_CACHE=false -e SPRING_THYMELEAF_CACHE_TTL=0
  ```

After editing `theme.yaml`, click **Reload theme configuration** on the theme
page in Console for changes to take effect (a page refresh is not enough).

---

## Settings reference

All settings live in three groups defined in `settings.yaml`:

| Group   | Field             | Type      | Default                        | Effect                                       |
| ------- | ----------------- | --------- | ------------------------------ | -------------------------------------------- |
| style   | `color_scheme`    | radio     | `light`                        | Initial light/dark choice (overridable)      |
| style   | `accent_color`    | text      | `#f7b731`                      | CSS variable `--color-accent`                 |
| layout  | `posts_per_page`  | select    | `6`                            | Informational -- used in theme notes          |
| layout  | `show_sidebar`    | switch    | `false`                        | Adds the right sidebar on `post.html`        |
| seo     | `site_subtitle`   | text      | `Selected work & notes`        | Shown next to the site title in the header   |
| seo     | `hero_title`      | text      | (empty, falls back to `site.title`) | Reserved for future hero customization |
| seo     | `footer_text`     | textarea  | `(c) <current year> <site.title>` | Replaces the default footer copyright line |
| seo     | `show_rss`        | switch    | `true`                         | Toggles RSS / Sitemap / Archives footer row  |

> `posts_per_page` is informational -- the actual page size is set per-route
> in **System settings -> Posts/Archives/Tags/Categories** in Console.
>
> The footer default is computed from the current year, so it never goes
> stale.

---

## Adding a new template

1. Drop a new `templates/foo.html` file. Use `th:replace="~{layout :: layout(title = ..., content = ~{::content})}"` at the root and wrap content in `<th:block th:fragment="content">...</th:block>`.
2. Reference static assets via `th:href="@{/assets/...}"` (path is relative to `templates/assets/`). Append `?v={theme.spec.version}` for cache busting.
3. Reinstall the theme in Console if you change `theme.yaml`.

For a new post layout variant:

1. Create `templates/post-types/<name>.html`.
2. Register it in `theme.yaml`:
   ```yaml
   spec:
     customTemplates:
       post:
         - name: My Layout
           file: post-types/<name>.html
   ```
3. Click **Reload theme configuration** in Console.

---

## Building a release ZIP

`scripts/wrap-and-zip.mjs` is a zero-dependency Node script that produces a
Halo-installable ZIP. It uses only Node built-ins (`node:fs`, `node:buffer`,
`node:url`) -- no `npm install` needed.

```powershell
cd theme-portfolio
node scripts/wrap-and-zip.mjs
# -> theme-portfolio/dist/theme-portfolio-1.0.0.zip
```

The script:

- Reads `metadata.name` and `spec.version` from `theme.yaml` (via targeted
  regex, not a full YAML parser -- the script only needs two scalars).
- Walks the theme directory and excludes dev-only paths (`dist/`,
  `node_modules/`, `*.gitignore`, lockfiles, the packager itself).
- Writes every entry with `${themeName}/${rel}` prefix so the ZIP top
  level matches what Halo expects.
- Emits store-mode (uncompressed) ZIPs; size is slightly larger than
  deflate but the script is ~6 KB and has no transitive dependencies.

The output path is configurable:

```powershell
node scripts/wrap-and-zip.mjs <SRC_DIR> <OUT_DIR>
```

---
## Design system

| Token | Light | Dark |
| --- | --- | --- |
| Background | `#fafafa` | `#0d0d0d` |
| Surface | `#ffffff` | `#171717` |
| Foreground | `#171717` | `#fafafa` |
| Muted text | `#737373` | `#a1a1a1` |
| Border | `#e6e6e6` | `#262626` |
| Accent | `#f7b731` (gold) | `#f7b731` (gold) |
| On-accent text | `#0d0d0d` | `#0d0d0d` |
| Footer bg | `#1a1a1a` | `#0a0a0a` |

**Type**: single face -- **Montserrat** (300/400/500/600/700/800), loaded
from Google Fonts with system fallbacks. Display titles use 700-800 + tight
letter-spacing; body copy is 400 at 1.6 line-height.

**Motion**: every transition is 200-300 ms `cubic-bezier(0.4, 0, 0.2, 1)`.
Hero content fades up in sequence (eyebrow -> title -> subtitle -> CTA),
the nav underline animates with `scaleX` from the left, and any element
with `[data-reveal]` fades up when it scrolls into view. Honors
`prefers-reduced-motion`.

**Header**: fixed, transparent by default, gains a translucent background
with backdrop-blur after 24px of scroll.

**Mobile**: nav collapses into a hamburger that opens a full-viewport
overlay (translateX transition). Hamburger bars animate into an X.

---

## Pitfalls and lessons learned

Hard-won fixes for issues that don't show up in the official docs.

### 1. Thymeleaf template cache breaks hot-reload

Halo caches compiled Thymeleaf templates at JVM startup. Editing `.html`
files and refreshing the browser has **no effect** until you restart
Halo. Always disable the cache in development:

```yaml
# application.yml  (source / jar mode)
spring:
  thymeleaf:
    cache: false
    cache-ttl-ms: 0
```

```powershell
# Docker
docker run -e SPRING_THYMELEAF_CACHE=false -e SPRING_THYMELEAF_CACHE_TTL=0 ...
```

Even with this, `theme.yaml` edits still require clicking **Reload theme
configuration** on the theme's Console page -- the cache flag only
affects `.html` templates.

### 2. `|...|` literal substitution **cannot** be nested inside `${... ?: (...)}`

Thymeleaf expands `|...|` to a plain string **before** SpEL sees the
expression. The result is fed straight into SpEL, which then chokes on
non-identifier characters. The crash looks like:

```
SpelParseException: Expression [...] @34: EL1069E: Missing expected character '|'
```

Breaks:
```html
<p th:text="${theme.config?.seo?.footer_text ?: (|© ${site.title}|)}">Footer</p>
<!--                    ^ Thymeleaf expands this to "© My Site",
                         SpEL then fails on "©" -->
```

Fix: lift the literal substitution out via `th:with`:
```html
<p th:with="defaultFooter = |© ${site.title}|"
   th:text="${theme.config?.seo?.footer_text ?: defaultFooter}">Footer</p>
```

The same pattern applies anywhere you would otherwise write
`${A ?: (|...|)}` or `${A ? (|...|) : (|...|)}`.

### 3. `menuFinder.getPrimary()` returns `null` on fresh installs

If the operator has not created a menu yet, `primary.menuItems` NPEs and
**every page** throws 500 because the header is included from the layout
fragment. Always guard:

```html
<nav class="site-nav" th:with="primary = ${menuFinder.getPrimary()}">
  <th:block th:if="${primary != null and not #lists.isEmpty(primary.menuItems)}">
    <a th:each="item : ${primary.menuItems}" ...></a>
  </th:block>
</nav>
```

### 4. `theme.config` is an empty tree until settings are saved

A freshly installed theme has no `ConfigMap` backing the settings. Every
`theme.config.X.Y` access NPEs before the user opens and saves **Theme
settings** in Console. Always use chained safe navigation:

```html
<!-- NPE before settings are saved -->
<span th:text="${theme.config.seo.footer_text}"></span>

<!-- Safe -->
<span th:text="${theme.config?.seo?.footer_text}"></span>
```

This is also why the layout sets a sensible default for every
`theme.config` read (`?: 'fallback'`).

### 5. `@halo-dev/theme-package-cli` does not wrap with `theme-name/`

`npx -y @halo-dev/theme-package-cli package` uses `process.cwd()` as the
glob base and writes files at the ZIP root. Halo refuses to install a
theme that does not have `<metadata.name>/` at the top level. The bundled
[`scripts/wrap-and-zip.mjs`](scripts/wrap-and-zip.mjs) prefixes every
entry with `${theme.metadata.name}/`:

```powershell
node scripts/wrap-and-zip.mjs
# -> <dist>/<theme-name>-<version>.zip
```

### 6. After editing `theme.yaml`, click **Reload theme configuration**

`theme.yaml` changes (new `customTemplates`, `settingName`, etc.) are not
picked up by a page refresh. Open the theme's detail panel in Console and
click the reload button.

### 7. Changing `border-width` on `:hover` makes the layout jiggle

When an element has a 2px border and the hover state adds a 3px border,
the extra pixel shifts every adjacent element by 1px. Two ways around
it:

- Keep the border-width the same and only change `border-color` /
  `background-color` (what this theme does -- `.btn` stays at 2px).
- Use `box-shadow: inset 0 0 0 3px var(--color-accent)` for the hover
  state instead of changing `border-width`. Shadows do not affect
  layout.

### 8. `color-mix()` is a progressive enhancement

`color-mix(in srgb, var(--color-bg) 92%, transparent)` produces the
translucent header background after scroll. It is supported in all
evergreen browsers since 2023 (Chrome 111, Firefox 113, Safari 16.2)
but throws on older engines. The fallback strategy:

1. Older browsers get the base `var(--color-bg)` (no translucency) -- a
   safe solid color.
2. The `@supports (color: color-mix(in srgb, red, blue))` query lets
   you gate richer effects if you need them.
3. Always test with the target user base. For self-hosted personal
   sites, modern browsers are a safe assumption.

### 9. `prefers-reduced-motion` must be honored

Halo visitors may have motion sensitivity (vestibular disorders, etc.).
Always wrap your animations in a `prefers-reduced-motion` media query
that collapses durations to ~0:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
  [data-reveal] { opacity: 1; transform: none; }
}
```

This theme follows that pattern at the bottom of `style.css`.

---

## References

- Halo developer guide -- [Theme preparation](https://docs.halo.run/developer-guide/theme/prepare)
- Halo developer guide -- [Template variables](https://docs.halo.run/developer-guide/theme/template-variables)
- Halo developer guide -- [Finder APIs](https://docs.halo.run/developer-guide/theme/finder-apis)
- Halo developer guide -- [Form schema](https://docs.halo.run/developer-guide/form-schema)
- `halo-theme-dev` skill -- bundled with this repository
- [Montserrat](https://fonts.google.com/specimen/Montserrat) -- the single typeface used throughout
