<#-- ============================================================
     sitemap.xml.ftl
     ============================================================ -->
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>${site.url}/</loc><changefreq>daily</changefreq><priority>1.0</priority></url>
  <#if categories?has_content>
    <#list categories as c>
      <url>
        <loc>${site.url}${c.spec.url}</loc>
        <changefreq>weekly</changefreq><priority>0.8</priority>
      </url>
    </#list>
  </#if>
  <#if tags?has_content>
    <#list tags as t>
      <url>
        <loc>${site.url}${t.spec.url}</loc>
        <changefreq>weekly</changefreq><priority>0.6</priority>
      </url>
    </#list>
  </#if>
  <#if posts?has_content>
    <#list posts.items as p>
      <url>
        <loc>${site.url}${p.spec.url}</loc>
        <lastmod>${p.spec.publishTime?string('yyyy-MM-dd')}</lastmod>
        <priority>0.7</priority>
      </url>
    </#list>
  </#if>
</urlset>
