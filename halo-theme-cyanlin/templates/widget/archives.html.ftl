<#-- widget: archives.html.ftl -->
<#assign archs = archives/>
<aside class="widget widget-archives">
  <h3 class="widget-title">Archives</h3>
  <#if archs?has_content>
    <ul class="widget-list">
      <#list archs as a>
        <li>
          <a href="${a.url}">
            <span>${a.year?c}-${(a.month?c)?left_pad(2,'0')}</span>
            <span class="text-muted">(${a.count})</span>
          </a>
        </li>
      </#list>
    </ul>
  </#if>
</aside>
