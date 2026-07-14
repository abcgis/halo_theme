<#import "/module/layout.html.ftl" as layout>
<@layout.myLayout>
  <section class="page-banner">
    <div class="content">
      <h1 class="page-title">Archives</h1>
      <div class="page-description">All posts grouped by date.</div>
    </div>
  </section>
  <div class="content">
    <ul class="post-list">
      <#list archives??>
        <li>
          <time>${archives.year}-${archives.month}</time>
          <a href="${archives.url}">${archives.title}</a>
        </li>
      </#list>
    </ul>
  </div>
</@layout.myLayout>
