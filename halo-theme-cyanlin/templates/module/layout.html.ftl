<#macro myLayout>
<!DOCTYPE html>
<html lang="${site.locale?default('en-US')}" class="theme-cyanlin">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title><#if title??>${title!} · </#if>${site.title!}</title>
  <meta name="description" content="${(metaDescription!site.description!'')?html}">
  <meta name="keywords" content="${(metaKeywords!'')?html}">
  <link rel="icon" href="${site.favicon!'/favicon.ico'}" type="image/x-icon">
  <link rel="alternate" type="application/rss+xml" title="${site.title!} RSS" href="${site.url}/rss.xml">

  <!-- Halo head injected -->
  <@global.head />

  <!-- theme styles -->
  <link rel="stylesheet" href="${theme.config.domain!''}/assets/dist/css/theme.css?version=${theme.version}">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Helvetica+Neue&display=swap">

  <!-- page metadata -->
  <#if ogImage??><meta property="og:image" content="${ogImage}"></#if>
  <style>
    :root {
      --color-primary: ${theme.config.primary_color!'#38bdf8'};
    }
  </style>
</head>
<body data-theme="cyanlin"
      data-lightbox="${(theme.config.enable_lightbox!'true')?string}"
      class="page-${(templateName!?lower_case)!''}">

  <#-- desktop header -->
  <@module name="header"/>

  <#-- mobile drawer -->
  <@module name="mobile-header"/>

  <main class="site-container" id="content" role="main">
    <#nested/>
  </main>

  <@module name="footer"/>

  <#-- back to top -->
  <button class="back-to-top" aria-label="Back to top" title="Back to top">↑</button>

  <script src="${theme.config.domain!''}/assets/dist/js/theme.js?version=${theme.version}"></script>
  <@global.tail />
</body>
</html>
</#macro>
