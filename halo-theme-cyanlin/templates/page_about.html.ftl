<#-- ============================================================
     page_about.html.ftl
     Custom template variant — two-column About layout (matches
     the structure of cyanlin.com/about.html)
     To use: edit a page -> Advanced -> Template -> About Layout
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
    <#-- body content as single block -->
    <div class="about-body" style="font-size:16px;line-height:1.9;color:#333;max-width:820px;margin:0 auto;">
      ${page.spec.content}
    </div>

    <#-- Optional: "Lucky to have worked with" via widget -->
    <@widget name="social_clients" />
  </div>
</@layout.myLayout>

<#-- ============================================================
     Standard two-column style: applied automatically by the
     theme whenever the rendered page has an ".about-grid" class
     inserted via markdown (use raw HTML in editor).
     ============================================================ -->
<style>
  .about-body .about-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
    align-items: start;
    max-width: 1100px;
    margin: 40px auto;
  }
  .about-body .about-grid > .col h3 {
    font-size: 14px;
    letter-spacing: 0.18em;
    text-transform: uppercase;
    color: var(--color-primary, #38bdf8);
    margin: 28px 0 12px;
    border-bottom: 1px solid #eaeaea;
    padding-bottom: 8px;
  }
  .about-body .about-grid > .col h3:first-child { margin-top: 0; }
  .about-body .about-grid > .col p {
    font-size: 15px;
    line-height: 1.85;
    color: #444;
    margin: 0 0 14px;
  }
  .about-body hr {
    border: 0;
    border-top: 1px solid #ddd;
    width: 60%;
    margin: 36px auto;
  }
  @media (max-width: 768px) {
    .about-body .about-grid { grid-template-columns: 1fr; gap: 32px; }
  }
</style>
