<#-- ============================================================
     tags.html.ftl
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>
<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">Tags</h1>
    </div>
  </section>
  <div class="content text-center">
    <#if tags?has_content>
      <div style="display:flex;flex-wrap:wrap;gap:10px;justify-content:center;padding:24px 0;">
        <#list tags as t>
          <a href="${t.spec.url}" class="btn" style="padding:6px 16px;font-size:13px;">
            #${t.spec.displayName}<#if t.postCount??> · ${t.postCount}</#if>
          </a>
        </#list>
      </div>
    </#if>
  </div>
</@layout.myLayout>
