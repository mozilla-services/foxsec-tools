SELECT foxsec_metrics.baseline.day,
       sum(CASE
               WHEN foxsec_metrics.baseline.rule_10038 = 'pass' THEN 1
               ELSE 0
           END) pass,
       sum(CASE
               WHEN foxsec_metrics.baseline.rule_10038 != 'pass' THEN 1
               ELSE 0
           END) fail
FROM foxsec_metrics.baseline
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.url = foxsec_metrics.baseline.site
WHERE foxsec_metrics.metadata_urls.status = 'production'
  AND foxsec_metrics.metadata_urls.category != 'API'
GROUP BY foxsec_metrics.baseline.day
ORDER BY foxsec_metrics.baseline.day ASC;