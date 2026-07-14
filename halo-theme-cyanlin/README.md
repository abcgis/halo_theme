# Halo Theme · Cyanlin Portfolio

> A minimal, illustration / portfolio oriented Halo 2.x theme inspired by
> [http://www.cyanlin.com/](http://www.cyanlin.com/) — the personal site of
> illustrator **Cyan Lin**.

This theme re-implements the original site's signature three-column layout
with hover-to-zoom thumbnails, sticky 3-zone navigation and a quiet editorial
type system, then bolts it on top of Halo so you get a normal blog / CMS
underneath.

![preview](preview.png)

---

## 1.  What's included

```
halo-theme-cyanlin/
├── theme.yaml            # Manifest
├── settings.yaml         # Theme settings schema
├── README.md
├── preview.png           # Static screenshot (replace manually)
├── templates/
│   ├── index.html.ftl         # Portfolio grid homepage   (≈ cyanlin.com/index.html)
│   ├── post.html.ftl          # Standard blog post
│   ├── portfolio.html.ftl     # Portfolio-item detail      (≈ product_xxx.html)
│   ├── page.html.ftl          # Page (single col + custom 2-col about variant)
│   ├── archives.html.ftl
│   ├── categories.html.ftl
│   ├── tags.html.ftl
│   ├── search.html.ftl
│   ├── friendlinks.html.ftl
│   ├── moment.html.ftl        # Short updates timeline
│   ├── 404.html.ftl
│   ├── sitemap.xml.ftl
│   ├── module/
│   │   ├── layout.html.ftl
│   │   ├── header.html.ftl    # Desktop 3-zone header
│   │   ├── mobile-header.html.ftl
│   │   └── footer.html.ftl
│   └── widget/
│       ├── blog_recent.html.ftl
│       ├── blog_list.html.ftl
│       ├── category_list.html.ftl
│       ├── tag_list.html.ftl
│       ├── profile.html.ftl
│       ├── search.html.ftl
│       ├── archives.html.ftl
│       └── social_clients.html.ftl   # "Lucky to have worked with"
├── static/
│   ├── css/theme.css
│   ├── js/theme.js
│   └── images/logo.svg
```

---

## 2.  Installation

1. Package the folder: `zip -r halo-theme-cyanlin.zip halo-theme-cyanlin/`
2. Halo 2.x admin → **Appearance → Themes → Install** → upload the zip.
3. Activate the theme, then fill in the settings (logo, navigation, primary color).

---

## 3.  Page templates

The theme registers three **custom templates** you can assign per Post/Page:

| Template name           | Use it for                                | Mirrors                       |
|-------------------------|-------------------------------------------|-------------------------------|
| `portfolio`             | A single portfolio item (cover + gallery) | `product_xxx.html`            |
| `page_about`            | About page (two-column bio)               | `about.html`                  |
| `page_portfolio_grid`   | Category / tag landing page               | (uses the same grid as index) |

To assign in Halo: edit the post → **Advanced → Template → Portfolio Detail**.

---

## 4.  Replicating the original site

### 4.1 Portfolio grid (homepage)

The homepage (`index.html.ftl`) shows the latest posts as a 3-column grid with
hover-zoom. To match cyanlin.com exactly:

* Use square cover images.
* Set each Post's **Category** to one of `PORTFOLIO`, `BOOK PROJECT`, `EDITORIAL`,
  `PERSONAL`, `FESTIVAL`, `DIARY` (these mirror the original navigation).

### 4.2 Portfolio detail (≈ product_xxx.html)

Use template `portfolio`. Inside the post body, drop images like:

```md
![Caption 1](https://cdn.example.com/work-1.jpg)

![Caption 2](https://cdn.example.com/work-2.jpg)
```

The template auto-extracts every `<img>` and renders a stacked gallery with
optional lightbox (toggle via `enable_lightbox` setting).

### 4.3 About page (≈ about.html)

Create a new **Page**, assign template `page_about`, and paste Markdown like:

```md
## Education
- **MA Illustration** — Art University of Bournemouth 2019-2020
- **BA Relief Printmaking** — China Academy of Art 2015-2019

## Contact
Email: you@email.com
Instagram: @your_handle
```

Columns are automatically picked up by the `about-grid` style.

### 4.4 "Lucky to have worked with…"

Add a widget `social_clients` to the about page side-bar with:

* Title: `Lucky to have worked with :`
* List: `Aquila, China Post, Duzhe, Funshow Art, HERZ …`  (comma-separated)

---

## 5.  Theme settings (UI in admin)

| Setting               | Type    | Default            | Notes                                              |
|-----------------------|---------|--------------------|----------------------------------------------------|
| `logo_text`           | text    | `CYAN LIN`         | Used when no logo image is supplied                |
| `logo_image`          | text    | empty              | Full URL of PNG/SVG logo                           |
| `site_subtitle`       | text    | `Portfolio`        | Shown next to logo                                 |
| `primary_color`       | color   | `#38bdf8`          | Accent color                                       |
| `nav_left`            | json    | `PORTFOLIO`, `BEHANCE`  | Editable as JSON in the settings UI           |
| `nav_right`           | json    | `INSTAGRAM`, `ABOUT`    | Editable as JSON                             |
| `social_links`        | json    | 3 default entries  | Icon + URL pairs                                   |
| `footer_text`         | text    |                    | Bottom-of-page copyright                           |
| `items_per_page`      | number  | 12                 | Used in pagination                                 |
| `enable_search`       | bool    | true               | Show search box in mobile drawer                   |
| `enable_rss`          | bool    | true               | Inject RSS link                                    |
| `enable_lightbox`     | bool    | true               | Lightbox on portfolio detail page                  |

---

## 6.  Customising colors

Override the CSS variables in `static/css/theme.css`:

```css
:root {
  --color-primary: #a371f7;     /* accent        */
  --color-text:    #1a1a1a;
  --color-line:    #ededed;
  --max-width:     1200px;      /* site width    */
  --logo-height:   80px;
}
```

---

## 7.  JavaScript

`theme.js` is dependency-free vanilla JS and provides:

* `.mobile-menu-toggle` drawer
* Sticky-header shadow on scroll
* Lightbox (Escape / ArrowLeft / ArrowRight)
* Back-to-top button

Disable any of these by removing the body attribute or `data-lightbox="false"`.

---

## 8.  Compatibility

* Tested against Halo `2.10+` (uses Freemarker directives and the standard
  theme extension contract).
* Works with the official search plugin, the comment plugin, and the
  moment plugin out of the box.

---

## 9.  Credits

* Original design: **Cyan Lin** ([@cyan_cha](https://www.instagram.com/cyan_cha/))
* Halo port: *this theme*

This project is not affiliated with cyanlin.com; it is an independent port
made for educational purposes, with the layout reproduced as original.
