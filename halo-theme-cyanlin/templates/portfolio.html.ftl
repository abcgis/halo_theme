<#-- ============================================================
     portfolio.html.ftl
     Custom template: used as the layout for an individual portfolio item
     (matches the structure of cyanlin.com/product_xxx.html)
     ============================================================ -->
<#import "/module/layout.html.ftl" as layout>

<#assign currentUrl = post.spec.url />
<#assign title = post.spec.title />
<#assign metaDescription = (post.spec.description!?html)!"Explore this portfolio piece on ${site.title}" />
<#if post.spec.cover?? && post.spec.cover != "">
  <#assign ogImage = post.spec.cover />
</#if>

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

  <article class="portfolio-detail">
    <h1 class="pd-title">${post.spec.title}</h1>
    <div class="pd-meta">
      <#if post.categories?? && (post.categories?size > 0)>
        ${post.categories[0].spec.displayName}
      </#if>
      <#if post.spec.publishTime??> · <time>${post.spec.publishTime?string('yyyy.MM.dd')}</time></#if>
    </div>

    <#if (post.spec.description?? && post.spec.description != "")>
      <div class="pd-description">${post.spec.description}</div>
    </#if>

    <#-- image gallery: each line break or [figure] shortcode = an image -->
    <div class="pd-gallery">
      <#if post.spec.content?has_content>
        <#-- attempt to parse <img src="..."> tags out of markdown -->
        <#assign images = (post.spec.content?replace('&quot;','"')?replace('&#34;','"')) />
        <#list (images?split('<img')) as chunk>
          <#if chunk?contains('src=')>
            <#assign srcPart = (chunk?split('src=')[1]) />
            <#assign srcQuote = srcPart?substring(0,1) />
            <#assign srcRemainder = srcPart?substring(1) />
            <#assign srcEnd = srcQuote />
            <#assign srcValue = (srcRemainder?split(srcQuote)[0])!"">
            <#if srcValue != "">
              <a href="${srcValue}" data-lightbox="gallery">
                <img src="${srcValue}" alt="${post.spec.title}" loading="lazy">
              </a>
            </#if>
          </#if>
        </#list>

        <#-- fallback: cover image if we found no images in body -->
        <#if !post.spec.content?contains('<img') && post.spec.cover?? && post.spec.cover != "">
          <a href="${post.spec.cover}"><img src="${post.spec.cover}" alt="${post.spec.title}"></a>
        </#if>
      <#elseif post.spec.cover?? && post.spec.cover != "">
        <a href="${post.spec.cover}"><img src="${post.spec.cover}" alt="${post.spec.title}"></a>
      </#if>
    </div>

    <#-- main content (markdown HTML) rendered below gallery, hidden if author wants pure portfolio layout -->
    <#if settings.portfolio_render_body?? && settings.portfolio_render_body == "true">
      <div class="pd-body">${post.spec.content!"<!---->"}</div>
    </#if>

    <#-- prev / next -->
    <nav class="pd-nav">
      <#if prevPost??>
        <a href="${prevPost.spec.url}">← ${prevPost.spec.title}</a>
      <#else>
        <span></span>
      </#if>
      <#if nextPost??>
        <a href="${nextPost.spec.url}">${nextPost.spec.title} →</a>
      <#else>
        <span></span>
      </#if>
    </nav>
  </article>
</@layout.myLayout>
