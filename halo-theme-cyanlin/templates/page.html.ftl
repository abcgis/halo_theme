<#-- ============================================================
     page.html.ftl
     DEFAULT page template (single column).
     For the two-column About layout use page_about.html.ftl
     (set as Custom Template in the page editor).
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>

<#assign currentUrl = page.spec.url />
<#assign title = page.spec.title />

<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">${page.spec.title}</h1>
      <#if page.spec.description?? && page.spec.description != "">
        <div class="page-description">${page.spec.description}</div>
      </#if>
    </div>
  </section>

  <div class="content" style="padding-top:0;">
    <article class="page-body" style="max-width:760px;margin:0 auto;line-height:1.9;font-size:16px;color:#333;">
      ${page.spec.content}
    </article>
  </div>
</@layout.myLayout>
