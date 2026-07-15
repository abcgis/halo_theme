# Halo Themes

A multi-theme repository of Halo 2.x themes. Each theme ships as its own
top-level directory with everything needed to install, customize, and
re-package it.

> Themes are built following the official Halo developer guide
> ([docs.halo.run/developer-guide/theme/prepare](https://docs.halo.run/developer-guide/theme/prepare))
> and the `halo-theme-dev` AI assistant skill.

## Themes

| Theme | Directory | Version | Description |
| --- | --- | --- | --- |
| **Halo Portfolio Theme** | `theme-portfolio/` | 1.0.0 | Responsive portfolio theme for showcasing projects, posts, and personal work. Includes light/dark mode, FormKit settings, custom Docs Layout post variant. |

## Repository layout

```
halo_theme/
|-- README.md                       # This file (multi-theme repo overview)
|-- .gitignore                      # Ignores dist/, *.zip, node_modules/, AI helpers
|-- theme-portfolio/                # Halo Portfolio Theme
    |-- theme.yaml                  # Theme manifest
    |-- settings.yaml               # Settings form (FormKit)
    |-- README.md                   # Theme-specific docs (features, pitfalls, etc.)
    |-- scripts/
    |   `-- wrap-and-zip.mjs        # Zero-dep ZIP packager (no npm install)
    |-- templates/                  # Thymeleaf templates + assets
    `-- dist/                       # Build output (gitignored)
        `-- theme-portfolio-1.0.0.zip
```

Each theme is self-contained and can be developed independently. Themes
share **only** the conventions documented below; there is no shared code,
no monorepo toolchain, and no cross-theme dependencies.
## Building a theme

Every theme includes a zero-dependency packager that wraps the theme
contents inside `<metadata.name>/` (which is what Halo expects in an
uploaded ZIP).

```powershell
cd theme-portfolio
node scripts/wrap-and-zip.mjs
# -> theme-portfolio/dist/theme-portfolio-1.0.0.zip
```

The script reads `theme.yaml` for `metadata.name` and `spec.version`, then
emits `<dist>/<name>-<version>.zip`. Output path is configurable:

```powershell
node scripts/wrap-and-zip.mjs <SRC_DIR> <OUT_DIR>
```

## Adding a new theme

1. Create a new top-level directory matching the desired `metadata.name`,
   e.g. `theme-blog/`.
2. Copy the boilerplate from an existing theme (`theme-portfolio/` is the
   canonical starter). Minimum required files:
   - `theme.yaml` (with `metadata.name`, `spec.version`, `spec.requires`,
     `spec.settingName`, `spec.configMapName`)
   - `settings.yaml` (with `metadata.name` matching `settingName`)
   - `templates/` with at least `index.html` and `layout.html`
   - `scripts/wrap-and-zip.mjs` (unchanged from the starter)
3. Update identifiers in `theme.yaml` and `settings.yaml`:
   - `metadata.name`
   - `spec.settingName`
   - `spec.configMapName`
   - `spec.logo` (path under `/themes/<name>/...`)
4. Author your templates under `templates/`.
5. Add a row to the **Themes** table above.
6. Run the packager and upload the resulting ZIP to Halo Console.

## Conventions

- **Directory name** must match `metadata.name` in `theme.yaml`.
- **Settings and config map names** follow `<name>-setting` and
  `<name>-configmap`.
- **Custom post/page templates** live under
  `templates/post-types/<variant>.html` and are registered in
  `theme.yaml` under `spec.customTemplates`.
- **Static assets** live under `templates/assets/` and are referenced
  via `th:href="@{/assets/...}?v={theme.spec.version}"` for cache busting.
- **Build output** (`dist/`) and release zips are gitignored.

## See also

- Each theme's own `README.md` for theme-specific features and pitfalls
  (e.g. `theme-portfolio/README.md` documents six Thymeleaf / Halo quirks
  encountered during development).
- Halo developer guide -- [Theme preparation](https://docs.halo.run/developer-guide/theme/prepare)
- Halo developer guide -- [Template variables](https://docs.halo.run/developer-guide/theme/template-variables)
- Halo developer guide -- [Finder APIs](https://docs.halo.run/developer-guide/theme/finder-apis)
- Halo developer guide -- [Form schema](https://docs.halo.run/developer-guide/form-schema)
