<#-- widget: social_clients.html.ftl - "Lucky to have worked with" -->
<aside class="widget widget-clients">
  <#if config.title??><h3 class="widget-title">${config.title!'Lucky to have worked with'}</h3></#if>
  <#if config.list?? && config.list != "">
    <ul class="client-chips">
      <#list (config.list?split(',')) as c>
        <li>${c?trim}</li>
      </#list>
    </ul>
  </#if>
</aside>
<style>
  .client-chips { display:flex; flex-wrap:wrap; gap:8px; padding:0; }
  .client-chips li { padding: 6px 12px; border: 1px solid #eee; border-radius:999px; font-size:12px; letter-spacing: 0.04em; }
</style>
