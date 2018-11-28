CREATE VIEW foxsec_metrics.checklist_item_rollup AS
SELECT
  "service"
, "environment"
, "section"
, "item"
, "sum"((CASE "pass" WHEN 'false' THEN 1 ELSE 0 END)) "failures"
FROM
  foxsec_metrics.checklist
GROUP BY ("service", "environment", "section", "item")
ORDER BY ROW ("service", "environment", "section") ASC