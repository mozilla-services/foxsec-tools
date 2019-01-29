CREATE VIEW foxsec_metrics.checklist_prod_scores AS
SELECT
  "service"
, "sum"("passes") "passes"
, "sum"("failures") "failures"
, (("sum"((CASE "failures" WHEN 0 THEN 1 ELSE 0 END)) * 100) / "count"(DISTINCT "item")) "score"
FROM
  foxsec_metrics.checklist_item_rollup
WHERE (("environment" = 'production') OR ("environment" = 'global'))
GROUP BY "service"
ORDER BY "service" ASC