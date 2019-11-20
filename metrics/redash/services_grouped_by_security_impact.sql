SELECT count(foxsec_metrics.metadata_services.service) AS services,
       COALESCE(NULLIF(foxsec_metrics.metadata_services.risk, ''), 'undef') AS risk
FROM foxsec_metrics.metadata_services
GROUP BY foxsec_metrics.metadata_services.risk;