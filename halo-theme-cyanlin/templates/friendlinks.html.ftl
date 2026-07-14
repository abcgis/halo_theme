<#-- ============================================================
     friendlinks.html.ftl
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>
<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">Friend Links</h1>
      <div class="page-description">Friendly illustrators and studios I collaborate with.</div>
    </div>
  </section>
  <div class="content">
    <#if links?has_content>
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:18px;padding:20px 0;">
        <#list links as l>
          <a class="portfolio-card" href="${l.url}" target="_blank" rel="noopener"
             style="padding:18px;display:flex;align-items:center;gap:14px;">
            <#if l.logo?? && l.logo != "">
              <img src="${l.logo}" alt="${l.name}" style="width:48px;height:48px;border-radius:50%;object-fit:cover;">
            </#if>
            <div>
              <div class="title">${l.name}</div>
              <div class="text-muted" style="font-size:13px;">${l.description!''}</div>
            </div>
          </a>
        </#list>
      </div>
    </#if>
  </div>
</@layout.myLayout>
