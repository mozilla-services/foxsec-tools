SELECT foxsec_metrics.metadata_services.service AS service,
       COALESCE(NULLIF(foxsec_metrics.metadata_services.rraimpact, ''), 'undef') AS impact,
       CASE
           WHEN foxsec_metrics.metadata_services.rraimpact = 'maximum' THEN 4
           WHEN foxsec_metrics.metadata_services.rraimpact = 'high' THEN 3
           WHEN foxsec_metrics.metadata_services.rraimpact = 'medium' THEN 2
           WHEN foxsec_metrics.metadata_services.rraimpact = 'low' THEN 1
           ELSE 0
       END AS r
FROM foxsec_metrics.metadata_services
ORDER BY r DESC;