SELECT foxsec_metrics.baseline_sites.day,
       sum(foxsec_metrics.baseline_sites.pass) AS pass,
       sum(foxsec_metrics.baseline_sites.fail_in_progress) AS fail_in_progress,
       sum(foxsec_metrics.baseline_sites.fail_new) AS fail_new
FROM foxsec_metrics.baseline_sites
GROUP BY foxsec_metrics.baseline_sites.day
ORDER BY foxsec_metrics.baseline_sites.day ASC;