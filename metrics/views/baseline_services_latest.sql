CREATE VIEW foxsec_metrics.baseline_services_latest AS
SELECT
  "service"
, "day"
, "sum"((CASE WHEN (("fail_new" >= 1) OR ("fail_in_progress" >= 1)) THEN 1 ELSE 0 END)) "failures"
, (100 - ((100 * "sum"((CASE WHEN (("fail_new" >= 1) OR ("fail_in_progress" >= 1)) THEN 1 ELSE 0 END))) / "count"(*))) "percent"
, "count"(*) "total"
FROM
  foxsec_metrics.baseline_sites_latest
GROUP BY "service", "day"
ORDER BY "percent" ASC