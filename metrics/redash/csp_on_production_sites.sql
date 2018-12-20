SELECT foxsec_metrics.baseline_details.day,
       sum(CASE
               WHEN foxsec_metrics.baseline_details.status = 'pass' THEN 1
               ELSE 0
           END) pass,
       sum(CASE
               WHEN foxsec_metrics.baseline_details.status != 'pass' THEN 1
               ELSE 0
           END) fail
FROM foxsec_metrics.baseline_details
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.url = foxsec_metrics.baseline_details.site
WHERE foxsec_metrics.metadata_urls.status = 'production'
  AND foxsec_metrics.metadata_urls.category != 'API'
  AND foxsec_metrics.baseline_details.rule = 'rule_10038'
GROUP BY foxsec_metrics.baseline_details.day
ORDER BY foxsec_metrics.baseline_details.day ASC;