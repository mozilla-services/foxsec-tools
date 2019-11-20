SELECT
	day, service, site, baseline_details.status, progresslink, failingurls
FROM foxsec_metrics.baseline_details
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.url = foxsec_metrics.baseline_details.site
join (
    select max(baseline_details.day) as MaxDay
    from baseline_details
) md on baseline_details.day = MaxDay
WHERE foxsec_metrics.metadata_urls.status = 'production'
  AND foxsec_metrics.metadata_urls.category != 'API'
  AND foxsec_metrics.baseline_details.rule = 'rule_10038'
  AND baseline_details.status != 'pass'
ORDER BY service, site