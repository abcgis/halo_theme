<#-- ============================================================
     post.html.ftl
     Standard blog post template (alternative to the portfolio layout)
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>

<#assign currentUrl = post.spec.url />
<#assign title = post.spec.title />

<@layout.myLayout>
  <div class="content">
    <nav class="breadcrumb">
      <a href="/">Home</a>
      <span class="sep">/</span>
      <#if post.categories?? && (post.categories?size > 0)>
        <a href="${post.categories[0].spec.url}">${post.categories[0].spec.displayName}</a>
        <span class="sep">/</span>
      </#if>
      <span>${post.spec.title}</span>
    </nav>
  </div>

  <article class="content" style="max-width:780px;padding-top:8px;">
    <header style="text-align:center;margin-bottom:48px;">
      <h1 class="pd-title">${post.spec.title}</h1>
      <div class="pd-meta">
        <time>${post.spec.publishTime?string('yyyy.MM.dd')}</time>
        <#if post.categories?? && (post.categories?size > 0)> · ${post.categories[0].spec.displayName}</#if>
        <#if post.spec.visits??> · ${post.spec.visits} views</#if>
      </div>
    </header>

    <#if post.spec.cover?? && post.spec.cover != "">
      <img src="${post.spec.cover}" alt="${post.spec.title}"
           style="width:100%;border-radius:6px;margin-bottom:40px;">
    </#if>

    <div class="post-content" style="font-size:16px;line-height:1.9;color:#333;">
      ${post.spec.content}
    </div>

    <#if post.tags?? && (post.tags?size > 0)>
      <div style="margin-top:48px;padding-top:24px;border-top:1px solid #eee;">
        <#list post.tags as t>
          <a class="btn" href="${t.spec.url}" style="padding:6px 14px;font-size:12px;margin-right:6px;border-radius:999px;">
            #${t.spec.displayName}
          </a>
        </#list>
      </div>
    </#if>

    <nav class="pd-nav">
      <#if prevPost??><a href="${prevPost.spec.url}">← ${prevPost.spec.title}</a><#else><span></span></#if>
      <#if nextPost??><a href="${nextPost.spec.url}">${nextPost.spec.title} →</a><#else><span></span></#if>
    </nav>

    <@widget name="comment" />
  </article>
</@layout.myLayout>
