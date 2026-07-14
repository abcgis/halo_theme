<#-- ============================================================
     moment.html.ftl
     Timeline of short updates (Moments)
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>
<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">Moments</h1>
      <div class="page-description">Daily sketches, quick thoughts and short updates.</div>
    </div>
  </section>

  <div class="content" style="max-width:760px;">
    <#if moments?has_content>
      <ol style="border-left:2px solid #eaeaea;margin-left:16px;padding-left:24px;">
        <#list moments as m>
          <li style="margin-bottom:36px;position:relative;">
            <span style="position:absolute;left:-32px;top:6px;width:14px;height:14px;border-radius:50%;background:var(--color-primary,#38bdf8);border:3px solid #fff;box-shadow:0 0 0 1px #ddd;"></span>
            <div class="text-muted" style="font-size:12px;letter-spacing:0.1em;text-transform:uppercase;">
              ${m.spec.creationTime?string('yyyy.MM.dd')}
            </div>
            <div style="margin-top:8px;font-size:15px;line-height:1.7;">${m.spec.content}</div>
            <#if m.spec.images?has_content>
              <div style="margin-top:12px;display:grid;grid-template-columns:repeat(auto-fill,minmax(120px,1fr));gap:8px;">
                <#list m.spec.images as img>
                  <img src="${img}" alt="" style="border-radius:4px;object-fit:cover;">
                </#list>
              </div>
            </#if>
          </li>
        </#list>
      </ol>
    </#if>
  </div>
</@layout.myLayout>
