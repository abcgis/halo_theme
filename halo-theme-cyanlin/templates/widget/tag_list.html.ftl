<#-- widget: tag_list.html.ftl -->
<#assign tgs = tags/>
<aside class="widget widget-tags">
  <h3 class="widget-title">Tags</h3>
  <div style="display:flex;flex-wrap:wrap;gap:8px;">
    <#list tgs as t>
      <a href="${t.spec.url}" class="widget-tag">#${t.spec.displayName}</a>
    </#list>
  </div>
</aside>
<style>
  .widget-tag {
    padding: 4px 12px;
    border: 1px solid var(--color-line,#eee);
    border-radius: 999px;
    font-size: 12px;
    letter-spacing: 0.05em;
    transition: all .2s;
  }
  .widget-tag:hover { background: var(--color-primary,#38bdf8); color: #fff; border-color: transparent; }
</style>
