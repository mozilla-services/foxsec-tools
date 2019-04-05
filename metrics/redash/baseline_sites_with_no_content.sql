SELECT 
    baseline_sites_latest.service,
    metadata_urls.category,
    baseline_sites_latest.site
FROM foxsec_metrics.baseline_sites_latest, foxsec_metrics.metadata_urls
WHERE baseline_sites_latest.urlcount < 4 and
baseline_sites_latest.site = metadata_urls.url
ORDER BY baseline_sites_latest.service, baseline_sites_latest.site ASC;
