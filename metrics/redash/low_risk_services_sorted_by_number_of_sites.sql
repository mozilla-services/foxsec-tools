SELECT CONCAT('<a href="https://sql.telemetry.mozilla.org/dashboard/security-baseline-service-scores?p_service_60201=', foxsec_metrics.metadata_services.service, '">', foxsec_metrics.metadata_services.service, '</a>') AS service,
       foxsec_metrics.metadata_services.risk AS criticality,
       COUNT(foxsec_metrics.metadata_urls.url) AS sites,
       foxsec_metrics.metadata_services.rraimpact
FROM foxsec_metrics.metadata_services
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.service = foxsec_metrics.metadata_services.service
WHERE foxsec_metrics.metadata_services.risk='low'
GROUP BY foxsec_metrics.metadata_services.service,
         foxsec_metrics.metadata_services.risk,
         foxsec_metrics.metadata_services.rraimpact
ORDER BY COUNT(foxsec_metrics.metadata_urls.url) DESC;
