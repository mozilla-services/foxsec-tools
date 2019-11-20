SELECT foxsec_metrics.baseline_sites.day,
       sum(CASE
               WHEN foxsec_metrics.baseline_sites.status = 'fail' THEN 1
               ELSE 0
           END) fail,
       sum(CASE
               WHEN foxsec_metrics.baseline_sites.status = 'pass' THEN 1
               ELSE 0
           END) pass
FROM foxsec_metrics.baseline_sites
INNER JOIN foxsec_metrics.metadata_services ON baseline_sites.service = metadata_services.service
WHERE metadata_services.risk = 'low'
GROUP BY foxsec_metrics.baseline_sites.day
ORDER BY foxsec_metrics.baseline_sites.day ASC;