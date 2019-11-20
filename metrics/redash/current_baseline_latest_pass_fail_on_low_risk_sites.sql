SELECT foxsec_metrics.baseline_sites.status,
       COUNT(foxsec_metrics.baseline_sites.site) AS sites
FROM foxsec_metrics.baseline_sites
INNER JOIN foxsec_metrics.metadata_services ON baseline_sites.service = metadata_services.service
JOIN
  ( SELECT max(foxsec_metrics.baseline_sites.day) AS MaxDay
   FROM foxsec_metrics.baseline_sites) md ON foxsec_metrics.baseline_sites.day = MaxDay
WHERE metadata_services.risk = 'low'
GROUP BY foxsec_metrics.baseline_sites.status
ORDER BY status DESC;