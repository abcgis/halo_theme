<#-- widget: blog_list.html.ftl - similar to category page list of cards -->
<aside class="widget widget-blog-list">
  <ul class="post-list">
    <#if posts?has_content>
      <#list posts as p>
        <li class="post-item">
          <div class="thumb">
            <#if p.spec.cover?? && p.spec.cover != "">
              <img src="${p.spec.cover}" alt="${p.spec.title}">
            </#if>
          </div>
          <div>
            <h2><a href="${p.spec.url}">${p.spec.title}</a></h2>
            <p class="excerpt">${p.spec.excerpt!' '}</p>
          </div>
        </li>
      </#list>
    </#if>
  </ul>
</aside>
