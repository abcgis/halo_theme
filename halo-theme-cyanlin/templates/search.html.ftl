<#-- ============================================================
     search.html.ftl
     Halo uses Kn Finder or built-in search widget in 2.x.
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>
<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">Search</h1>
      <div class="page-description">Type a keyword and press enter.</div>
    </div>
  </section>

  <div class="content">
    <div style="max-width:600px;margin:0 auto 40px;">
      <form action="/search" method="get" style="display:flex;gap:8px;">
        <input type="text" name="keyword" placeholder="Search posts..."
               value="${keyword!''}"
               style="flex:1;padding:14px 18px;border:1px solid #ddd;border-radius:999px;font-size:15px;">
        <button type="submit" class="btn" style="padding:14px 28px;">Search</button>
      </form>
    </div>

    <#if results?has_content>
      <ul class="post-list">
        <#list results as post>
          <li class="post-item">
            <div class="thumb">
              <#if post.spec.cover?? && post.spec.cover != "">
                <img src="${post.spec.cover}" alt="${post.spec.title}">
              </#if>
            </div>
            <div>
              <h2><a href="${post.spec.url}">${post.spec.title}</a></h2>
              <p class="excerpt">${post.spec.excerpt!' '}</p>
            </div>
          </li>
        </#list>
      </ul>
    </#if>
  </div>
</@layout.myLayout>
