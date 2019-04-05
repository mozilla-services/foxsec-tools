SELECT foxsec_metrics_stage.baseline_sites.day,
       sum(CASE
               WHEN foxsec_metrics_stage.baseline_sites.status = 'fail' THEN 1
               ELSE 0
           END) fail,
       sum(CASE
               WHEN foxsec_metrics_stage.baseline_sites.status = 'pass' THEN 1
               ELSE 0
           END) pass
FROM foxsec_metrics_stage.baseline_sites
GROUP BY foxsec_metrics_stage.baseline_sites.day
ORDER BY foxsec_metrics_stage.baseline_sites.day ASC;