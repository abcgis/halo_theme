<header class="site-header" id="site-header">
  <div class="left">
    <#assign leftNav = (theme.config.nav_left?eval)!'[]' />
    <nav class="nav" data-section="left">
      <#list leftNav as item>
        <#assign isActive = (item.url == '/' && isHome!) || item.url == currentUrl! />
        <a href="${item.url}"
           class="nav-item <#if isActive>active</#if>"
           target="${(item.target!'_self')}"
           rel="noopener">
          <span>${item.label}</span>
        </a>
      </#list>
    </nav>
  </div>

  <a href="/" class="site-logo" aria-label="${site.title!}">
    <#if theme.config.logo_image?? && theme.config.logo_image != "">
      <img src="${theme.config.logo_image}" alt="${site.title!}">
    <#else>
      <span class="logo-text">${(theme.config.logo_text!'CYAN LIN')}</span>
      <#if theme.config.site_subtitle?? && theme.config.site_subtitle != "">
        <span class="tagline">${theme.config.site_subtitle}</span>
      </#if>
    </#if>
  </a>

  <div class="right">
    <#assign rightNav = (theme.config.nav_right?eval)!'[]' />
    <nav class="nav" data-section="right">
      <#list rightNav as item>
        <#assign isActive = (item.url == currentUrl!) />
        <a href="${item.url}"
           class="nav-item <#if isActive>active</#if>"
           target="${(item.target!'_self')}"
           rel="noopener">
          <span>${item.label}</span>
        </a>
      </#list>
    </nav>
  </div>
</header>
