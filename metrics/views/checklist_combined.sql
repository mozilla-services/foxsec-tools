CREATE VIEW foxsec_metrics.checklist_combined AS
SELECT
  "environment"
, "item"
, "link"
, "pass"
, "section"
, "service"
, "site"
FROM
  checklist
UNION ALL SELECT *
FROM
  github_checklist_latest
