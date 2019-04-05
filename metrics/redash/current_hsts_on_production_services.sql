SELECT CASE
           WHEN foxsec_metrics.baseline_details.status = 'fail' THEN 'fail'
           WHEN foxsec_metrics.baseline_details.status = 'fail_in_progress' THEN 'fail'
           WHEN foxsec_metrics.baseline_details.status = 'fail_new' THEN 'fail'
           ELSE 'pass'
       END AS status,
       count(*) AS Percent
FROM foxsec_metrics.baseline_details
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.url = foxsec_metrics.baseline_details.site
JOIN
  ( SELECT max(foxsec_metrics.baseline_details.day) AS MaxDay
   FROM foxsec_metrics.baseline_details) md ON foxsec_metrics.baseline_details.day = MaxDay
WHERE foxsec_metrics.metadata_urls.status = 'production'
  AND foxsec_metrics.baseline_details.rule = 'rule_10035'
GROUP BY foxsec_metrics.baseline_details.status;