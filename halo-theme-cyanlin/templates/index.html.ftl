<#-- ============================================================
     index.html.ftl  (Homepage)
     Inspired by http://www.cyanlin.com/index.html
     3-column portfolio grid with hover effect
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>
<#assign currentUrl = '/' />
<#assign title = (site.title! + ' · ' + theme.config.site_subtitle!'Portfolio')! />

<@layout.myLayout>
  <#-- intro / hero block - rendered only when the site has an intro -->
  <#if (settings.intro_paragraph?? || settings.hero_image??)>
    <section class="page-banner content">
      <#if settings.hero_image?? && settings.hero_image != "">
        <img src="${settings.hero_image}" alt="" style="max-width:420px;margin:0 auto 32px;border-radius:8px;"/>
      </#if>
      <h1 class="page-title">${settings.hero_title!'Hello, I''m a visual storyteller.'}</h1>
      <div class="page-description">
        ${settings.intro_paragraph!'A portfolio of illustrations, artwork and personal projects. Browse the gallery below or filter by category.'}
      </div>
    </section>
  </#if>

  <div class="content">
    <#-- portfolio grid: shows the latest posts (treated as portfolio items) -->
    <#if posts?? && (posts.items)?has_content>
      <ul class="portfolio-grid">
        <#list posts.items as post>
          <li class="portfolio-card">
            <a href="${post.spec.url!('/archives/' + post.metadata.name)}" aria-label="${post.spec.title}">
              <div class="thumb">
                <#assign cover = (post.spec.cover??"") />
                <#if cover != "">
                  <img src="${cover}" alt="${post.spec.title}" loading="lazy">
                <#else>
                  <div style="display:flex;align-items:center;justify-content:center;height:100%;background:#e6f6ff;color:#38bdf8;font-size:48px;font-weight:700;">
                    ${post.spec.title?substring(0,1)}
                  </div>
                </#if>
              </div>
              <div class="meta">
                <div>
                  <h3 class="title">${post.spec.title}</h3>
                  <#if post.categories?? && (post.categories?size > 0)>
                    <div class="category">${post.categories[0].spec.displayName}</div>
                  </#if>
                </div>
                <span class="arrow" aria-hidden="true">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                       stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M5 12h14M13 5l7 7-7 7"/>
                  </svg>
                </span>
              </div>
            </a>
          </li>
        </#list>
      </ul>

      <#-- pagination -->
      <#if posts.totalPages?? && posts.totalPages &gt; 1>
        <nav class="pagination">
          <#if posts.hasPrev>
            <a href="${posts.prevUrl!}">‹ Prev</a>
          </#if>
          <#list 1..posts.totalPages as p>
            <#if p == posts.page>
              <span class="current">${p}</span>
            <#else>
              <a href="<#if p == 1>/<#else>/page/${p}.html</#if>">${p}</a>
            </#if>
          </#list>
          <#if posts.hasNext>
            <a href="${posts.nextUrl!}">Next ›</a>
          </#if>
        </nav>
      </#if>
    <#else>
      <div style="text-align:center;padding:80px 24px;color:#888;">
        <p>No portfolio items yet. <a href="/admin" style="color:#38bdf8;text-decoration:underline;">Log in</a> and publish your first piece.</p>
      </div>
    </#if>
  </div>
</@layout.myLayout>
