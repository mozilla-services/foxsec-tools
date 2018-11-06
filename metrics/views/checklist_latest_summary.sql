CREATE VIEW foxsec_metrics.checklist_latest_summary AS
SELECT
  "service"
, "trim"("environment") "environment"
, "every"(CAST("pass" AS boolean)) "pass"
FROM
  (
   SELECT *
   FROM
     checklist
UNION ALL    SELECT *
   FROM
     github_checklist_latest
) 
GROUP BY "service", "trim"("environment")
ORDER BY "service" ASC, "trim"("environment") ASC