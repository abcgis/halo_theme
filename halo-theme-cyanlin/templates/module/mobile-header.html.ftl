<#-- ============================================================
     Mobile header + drawer menu
     Reuses the same nav config as desktop header
     ============================================================ -->
<div class="mobile-header">
  <a href="/" class="site-logo" aria-label="${site.title!}">
    <#if theme.config.logo_image?? && theme.config.logo_image != "">
      <img src="${theme.config.logo_image}" alt="${site.title!}">
    <#else>
      <span class="logo-text">${(theme.config.logo_text!'CYAN LIN')}</span>
    </#if>
  </a>
  <button class="mobile-menu-toggle hamburger" aria-label="Toggle menu">
    <span></span><span></span><span></span>
  </button>
</div>

<div class="mobile-drawer">
  <nav class="mobile-nav">
    <#assign combinedNav = ((theme.config.nav_left?eval) + (theme.config.nav_right?eval))! />
    <#list combinedNav as item>
      <a href="${item.url}" target="${(item.target!'_self')}" rel="noopener"
         class="<#if item.url == currentUrl!>active</#if>">
        ${item.label}
      </a>
    </#list>
  </nav>
</div>
