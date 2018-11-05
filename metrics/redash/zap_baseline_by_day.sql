SELECT foxsec_metrics.baseline.day,
       sum(foxsec_metrics.baseline.pass) AS pass,
       sum(foxsec_metrics.baseline.fail_in_progress) AS fail_in_progress,
       sum(foxsec_metrics.baseline.fail_new) AS fail_new
FROM foxsec_metrics.baseline
GROUP BY foxsec_metrics.baseline.day
ORDER BY foxsec_metrics.baseline.day ASC;