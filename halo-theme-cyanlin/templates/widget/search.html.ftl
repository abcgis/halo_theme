<#-- widget: search.html.ftl -->
<aside class="widget widget-search">
  <h3 class="widget-title">Search</h3>
  <form action="/search" method="get">
    <input type="text" name="keyword" placeholder="Search artwork…">
    <button type="submit">Search</button>
  </form>
</aside>
<style>
  .widget-search input { width: 100%; padding: 10px 14px; border: 1px solid #ddd; border-radius: 999px; }
  .widget-search button { margin-top: 10px; width: 100%; }
</style>
