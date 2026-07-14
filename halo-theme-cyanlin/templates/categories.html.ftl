<#-- ============================================================
     categories.html.ftl
     Shows all categories in a clean grid
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>
<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">Categories</h1>
    </div>
  </section>
  <div class="content">
    <ul class="post-list">
      <#if categories?has_content>
        <#list categories as c>
          <li class="post-item">
            <div class="thumb">
              <#if c.spec.cover?? && c.spec.cover != "">
                <img src="${c.spec.cover}" alt="${c.spec.displayName}">
              <#else>
                <div style="background:#f7f7f7;height:100%;display:flex;align-items:center;justify-content:center;color:#38bdf8;font-size:32px;font-weight:700;">
                  ${c.spec.displayName?substring(0,1)}
                </div>
              </#if>
            </div>
            <div>
              <h2><a href="${c.spec.url}">${c.spec.displayName}</a></h2>
              <p class="excerpt">${c.spec.description!'Browse all items in this category.'}</p>
              <div class="meta">${c.postCount!'0'} items</div>
            </div>
          </li>
        </#list>
      </#if>
    </ul>
  </div>
</@layout.myLayout>
