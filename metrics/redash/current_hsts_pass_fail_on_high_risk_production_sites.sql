SELECT (CASE
               WHEN foxsec_metrics.baseline_details.status = 'fail' THEN 'fail'
               WHEN foxsec_metrics.baseline_details.status = 'fail_in_progress' THEN 'fail'
               WHEN foxsec_metrics.baseline_details.status = 'fail_new' THEN 'fail'
               ELSE 'pass'
        END) status,
       COUNT(DISTINCT(foxsec_metrics.baseline_details.site)) AS sites
FROM foxsec_metrics.baseline_details
INNER JOIN foxsec_metrics.baseline_sites ON foxsec_metrics.baseline_sites.site = foxsec_metrics.baseline_details.site
INNER JOIN foxsec_metrics.metadata_services ON foxsec_metrics.baseline_sites.service = foxsec_metrics.metadata_services.service
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.service = foxsec_metrics.baseline_sites.service
JOIN
  (SELECT max(foxsec_metrics.baseline_details.day) AS MaxDay
   FROM foxsec_metrics.baseline_details) md ON foxsec_metrics.baseline_details.day = MaxDay
WHERE foxsec_metrics.metadata_urls.status = 'production'
  AND foxsec_metrics.baseline_details.rule = 'rule_10035'
  AND foxsec_metrics.metadata_services.risk = 'high'
GROUP BY foxsec_metrics.baseline_details.status;