<#-- widget: blog_recent.html.ftl - list the latest N posts -->
<#assign limit = (config.number!'5')?number />
<#assign posts = recent_posts(limit)/>

<aside class="widget widget-blog-recent">
  <h3 class="widget-title">Recent Work</h3>
  <#if posts?has_content>
    <ul class="widget-list">
      <#list posts as p>
        <li>
          <a href="${p.spec.url}">
            <#if p.spec.cover?? && p.spec.cover != "">
              <img src="${p.spec.cover}" alt="${p.spec.title}">
            </#if>
            <div>
              <div class="widget-post-title">${p.spec.title}</div>
              <div class="widget-post-date">${p.spec.publishTime?string('MM.dd')}</div>
            </div>
          </a>
        </li>
      </#list>
    </ul>
  </#if>
</aside>

<style>
  .widget-title { font-size: 12px; letter-spacing: 0.18em; text-transform: uppercase; color: var(--color-primary,#38bdf8); margin: 28px 0 12px; }
  .widget-list li { border-bottom: 1px solid #eee; padding: 10px 0; }
  .widget-list a { display: flex; gap: 12px; align-items: center; }
  .widget-list img { width: 50px; height: 50px; border-radius: 4px; object-fit: cover; }
  .widget-post-title { font-size: 14px; font-weight: 600; }
  .widget-post-date  { font-size: 11px; color: var(--color-muted); letter-spacing: 0.1em; }
</style>
