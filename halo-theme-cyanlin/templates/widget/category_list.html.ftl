<#-- widget: category_list.html.ftl -->
<#assign cats = categories/>
<aside class="widget widget-categories">
  <h3 class="widget-title">Categories</h3>
  <#if cats?has_content>
    <ul class="widget-list">
      <#list cats as c>
        <li>
          <a href="${c.spec.url}">${c.spec.displayName}
            <span class="text-muted">(${c.postCount!'0'})</span>
          </a>
        </li>
      </#list>
    </ul>
  </#if>
</aside>
