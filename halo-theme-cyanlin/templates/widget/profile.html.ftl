<#-- widget: profile.html.ftl - sidebar profile about author / studio -->
<aside class="widget widget-profile">
  <#if config.avatar_url?? && config.avatar_url != "">
    <img src="${config.avatar_url}" class="profile-avatar" alt="${site.title!}">
  </#if>
  <h3 class="profile-name">${(config.display_name!site.title!)}</h3>
  <p class="profile-bio">${config.bio!'Illustrator &amp; visual storyteller.'}</p>
  <#if config.socials?has_content>
    <div class="profile-social">
      <#list config.socials?eval as s>
        <a href="${s.url}" target="_blank" rel="noopener">${s.label}</a>
      </#list>
    </div>
  </#if>
</aside>
<style>
  .widget-profile { text-align: center; padding: 24px 12px; border-radius: 8px; background: var(--color-soft,#f7f7f7); }
  .profile-avatar { width: 96px; height: 96px; border-radius: 50%; object-fit: cover; margin: 0 auto 14px; }
  .profile-name   { margin: 0 0 6px; font-size: 16px; letter-spacing: 0.1em; }
  .profile-bio    { font-size: 13px; color: var(--color-muted,#888); margin: 0 0 12px; }
  .profile-social { display: flex; justify-content: center; gap: 10px; }
  .profile-social a { font-size: 12px; border-bottom: 1px solid #ccc; letter-spacing: 0.08em; }
</style>
