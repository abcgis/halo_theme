# Halo Demo Theme

A clean, responsive **Halo 2.x** demo theme that showcases the core capabilities
every theme author needs to know about.

> Built following the official Halo developer guide
> ([docs.halo.run/developer-guide/theme/prepare](https://docs.halo.run/developer-guide/theme/prepare))
> and the [`halo-theme-dev`](../halo-theme-dev) AI assistant skill.

---

## Features

| Area | What is demonstrated |
| ---- | ------------------- |
| **Layout reuse** | `templates/layout.html` is a parameterized Thymeleaf fragment (`layout(title, content)`) that every page template reuses via `th:replace`. |
| **Static assets** | CSS / JS / images live under `templates/assets/`, referenced with cache-busting `?v={theme.spec.version}`. |
| **Theme settings form** | `settings.yaml` (FormKit) exposes style / layout / SEO groups; values are read via `theme.config.<group>.<field>`. |
| **Global variables** | `site`, `theme`, `theme.config`, `#theme.assets()` — see `layout.html`, `header.html`, `index.html`. |
| **Finder APIs** | `menuFinder.getPrimary()`, `postFinder.cursor()`, `postFinder.listAll()`, `tagFinder.listAll()`. |
| **Pagination** | Built for `posts`, `archives`, `tag`, `category`, `author` using `prevUrl` / `nextUrl` / `hasPrevious()` / `hasNext()`. |
| **Custom templates** | `theme.yaml` registers a **Docs Layout** for posts; the file lives at `templates/post-types/post-docs.html`. |
| **Light / dark mode** | Toggle in the header; persisted in `localStorage`; system preference respected when no override is set. |
| **Comment extension** | `<halo:comment>` rendered conditionally on `post.html` and `page.html` via `haloCommentEnabled`. |
| **Footer injection** | `<halo:footer />` is the last body element in `layout.html` so plugins can inject analytics. |
| **Error pages** | `templates/error/404.html` and `4xx.html` (per the Halo error-template resolution order). |
| **i18n-friendly** | All text is in plain HTML / Thymeleaf — no hard-coded copy beyond footer placeholder. |
| **Safe Thymeleaf** | Uses `?.`, `?:`, `#strings.isEmpty`, literal substitutions, `@{${url}}` for permalinks. |

---

## Directory layout

```
halo-theme-demo/
├── theme.yaml                          # Theme manifest
├── settings.yaml                       # Settings form (FormKit)
├── README.md
└── templates/
    ├── layout.html                     # Parameterized layout fragment
    ├── index.html                      # Home (post list grid)
    ├── post.html                       # Post detail (default template)
    ├── page.html                       # Single page detail
    ├── archives.html                   # Year/month archive
    ├── tags.html                       # All tags
    ├── tag.html                        # Posts for one tag
    ├── categories.html                 # All categories
    ├── category.html                   # Posts for one category
    ├── author.html                     # Author profile + posts
    ├── assets/
    │   ├── css/style.css               # Theme stylesheet (light/dark tokens)
    │   ├── js/main.js                  # Theme toggle + localStorage
    │   └── images/logo.svg
    ├── modules/
    │   ├── header.html                 # Site header fragment
    │   └── footer.html                 # Site footer fragment
    ├── error/
    │   ├── 404.html                    # Not found
    │   └── 4xx.html                    # Generic client error fallback
    └── post-types/
        └── post-docs.html              # Custom "Docs Layout" variant
```

---

## Installation

1. Make sure your local folder name matches `metadata.name` in `theme.yaml`
   (`theme-demo`). When installing, Halo extracts the theme under its
   `themes/` directory using that exact folder name.
2. Open the Halo Console → **Appearance → Themes**.
3. Click **Switch theme → Not installed**, then **Install** the theme.
4. Click **Enable** on the newly installed theme.
5. (Optional) Open **Theme settings** to adjust accent color, layout and footer.
6. Visit the frontend (default `http://localhost:8090`) to verify.

### Hot-reload during development

- **Source mode** — add to `application.yml`:
  ```yaml
  spring:
    thymeleaf:
      cache: false
  ```
- **Docker** — add the environment variable `SPRING_THYMELEAF_CACHE=false`.

After editing `theme.yaml`, click **Reload theme configuration** on the theme
page in Console for changes to take effect.

---

## Settings reference

All settings live in three groups defined in `settings.yaml`:

| Group   | Field             | Type      | Default              | Effect                                       |
| ------- | ----------------- | --------- | -------------------- | -------------------------------------------- |
| style   | `color_scheme`    | radio     | `system`             | Initial light/dark choice (overridable)      |
| style   | `accent_color`    | text      | `#3b82f6`            | CSS variable `--color-accent`                 |
| layout  | `posts_per_page`  | select    | `10`                 | Informational — used in theme notes          |
| layout  | `show_sidebar`    | switch    | `true`               | Adds the right sidebar on `post.html`        |
| seo     | `site_subtitle`   | text      | `A Halo 2.x demo theme` | Shown next to the site title in the header |
| seo     | `footer_text`     | textarea  | `© Halo Demo Theme …` | Replaces the default footer copyright line   |
| seo     | `show_rss`        | switch    | `true`               | Toggles RSS / Sitemap / Archives footer row  |

> `posts_per_page` is informational — the actual page size is set per-route in
> **System settings → Posts/Archives/Tags/Categories** in Console.

---

## Adding a new template

1. Drop a new `templates/foo.html` file. Use `th:replace="~{layout :: layout(title = ..., content = ~{::content})}"` at the root and wrap content in `<th:block th:fragment="content">…</th:block>`.
2. Reference static assets via `th:href="@{/assets/...}"` (path is relative to `templates/assets/`).
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

## References

- Halo developer guide — [Theme preparation](https://docs.halo.run/developer-guide/theme/prepare)
- Halo developer guide — [Template variables](https://docs.halo.run/developer-guide/theme/template-variables)
- Halo developer guide — [Finder APIs](https://docs.halo.run/developer-guide/theme/finder-apis)
- Halo developer guide — [Form schema](https://docs.halo.run/developer-guide/form-schema)
- `halo-theme-dev` skill — `references/` (bundled with this repo)
